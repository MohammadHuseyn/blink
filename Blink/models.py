from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractUser, User


class Customer(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    image = models.CharField(max_length=2048, null=True, blank=True)
    def __str__(self):
        return self.username


class Delivery(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    driving_license_number = models.CharField(max_length=20, unique=False, help_text="Unique driving license number")
    vehicle_license_plate = models.CharField(max_length=15, unique=False, help_text="Vehicle license plate number")
    image = models.CharField(max_length=2048, null=True, blank=True)
    def __str__(self):
        return f"{self.username} (Driving License: {self.driving_license_number})"


class Administrator(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)
    image = models.CharField(max_length=2048, null=True, blank=True)
    def __str__(self):
        return self.username


class CustomerSupport(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    image = models.CharField(max_length=2048, null=True, blank=True)
    def __str__(self):
        return self.username


class Location(models.Model):
    name = models.CharField(max_length=20, blank=True)
    latitude = models.DecimalField(max_digits=25, decimal_places=15)
    longitude = models.DecimalField(max_digits=25, decimal_places=15)
    timestamp = models.DateTimeField(auto_now_add=True)
    address = models.CharField(max_length=200, blank=True)
    user = models.ForeignKey(User, related_name='location', on_delete=models.CASCADE)

    def __str__(self):
        return f"Latitude: {self.latitude}, Longitude: {self.longitude}"


class Seller(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    store = models.OneToOneField('Store', related_name='seller_profile', on_delete=models.CASCADE, null=True)
    image = models.CharField(max_length=2048, null=True)


class DiscountCode(models.Model):
    code = models.CharField(max_length=20)
    discount_value = models.IntegerField(default=0, help_text="Discount value between 1 to 100 percent")
    creation_date = models.DateTimeField(auto_now_add=True)
    expiration_date = models.DateTimeField()
    creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='created_discount_codes')

    def __str__(self):
        return self.code


class Category(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Store(models.Model):
    name = models.CharField(max_length=100)
    location = models.ForeignKey("Location", related_name='stores', on_delete=models.SET_NULL, null=True, blank=True)
    discount_codes = models.ManyToManyField(DiscountCode, related_name='stores', blank=True)
    image = models.CharField(max_length=2048, null=True, blank=True)
    rate = models.DecimalField(max_digits= 3, decimal_places=2)
    category = models.ForeignKey(Category, related_name='stores', on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.name
class StoreComment(models.Model):
    store = models.ForeignKey(Store, related_name='store_comments', on_delete=models.CASCADE)
    user = models.ForeignKey(User, related_name='store_comments', on_delete=models.CASCADE)
    comment = models.TextField()
    comment_created = models.DateTimeField(auto_now_add=True)
    rate = models.DecimalField(max_digits= 1, decimal_places=0, default=3)
    def __str__(self):
        return f"Comment for {self.store.name}"


class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.IntegerField()
    store = models.ForeignKey(Store, related_name='products', on_delete=models.CASCADE, null=True)
    category = models.ForeignKey(Category, related_name='products', on_delete=models.CASCADE, null=True)
    image = models.CharField(max_length=2048, null=True, blank=True)
    description = models.TextField(blank=True, max_length=100)
    rate = models.DecimalField(max_digits= 3, decimal_places=2, null=True)
    def __str__(self):
        return self.name


class ProductComment(models.Model):
    product = models.ForeignKey(Product, related_name='comments', on_delete=models.CASCADE)
    user = models.ForeignKey(User, related_name='comments', on_delete=models.CASCADE)
    comment = models.TextField()
    comment_created = models.DateTimeField(auto_now_add=True)
    rate = models.DecimalField(max_digits= 1, decimal_places=0, default=3)
    def __str__(self):
        return f"Comment for {self.product.name}"


class SalesReport(models.Model):
    store = models.ForeignKey(Store, related_name='sales_reports', on_delete=models.CASCADE)
    date = models.DateField()
    total_items_sold = models.IntegerField()
    total_income = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Sales Report for {self.store.name} on {self.date}"


class Order(models.Model):
    class OrderStatus(models.TextChoices):
        CREATED = 'CREATED', _('Created')
        PENDING = 'PENDING', _('Pending')
        PROCESSING = 'PROCESSING', _('Processing')
        WAITING = 'WAITING', _('Waiting')
        DISPATCHED = 'DISPATCHED', _('Dispatched')
        DELIVERED = 'DELIVERED', _('Delivered')
        CANCELLED = 'CANCELLED', _('Cancelled')
        FAILED = 'PAYMENT', _('Failed')

    customer = models.ForeignKey(Customer, related_name='orders', on_delete=models.CASCADE)
    store = models.ForeignKey(Store, related_name='orders', on_delete=models.CASCADE)
    delivery_location = models.ForeignKey(Location, on_delete=models.SET_NULL, null=True, blank=True,
                                          related_name='orders')
    delivery_person = models.ForeignKey(Delivery, related_name='orders', on_delete=models.SET_NULL, null=True,
                                        blank=True)
    delivery_price = models.DecimalField(max_digits=15, decimal_places=2, help_text="Cost of delivery")
    discount = models.ForeignKey(DiscountCode, on_delete=models.SET_NULL, null=True, blank=True,
                                 help_text="Optional discount code applied to the order")
    discount_value = models.DecimalField(max_digits=15, decimal_places=2, default=0,
                                         help_text="Amount of discount applied to the order")
    total_price = models.DecimalField(max_digits=15, decimal_places=2,
                                      help_text="Total price of the order, including items and delivery")
    status = models.CharField(max_length=10, choices=OrderStatus.choices, default=OrderStatus.CREATED,
                              help_text="Status of the order")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    fast_delivery = models.BooleanField(default=False)
    payment_method = models.BooleanField(default=False)
    description = models.TextField(blank=True, max_length=100)

    def __str__(self):
        return f"Order #{self.id} by {self.customer.username} - Total: {self.total_price} - Status: {self.status}"


class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, related_name='order_items', on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1, help_text="Quantity of the product in the order")

    def __str__(self):
        return f"{self.product.name} (x{self.quantity}) in Order #{self.order.id}"


class ShoppingCart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f"Shopping Cart for {self.user.username}"


class CartItem(models.Model):
    cart = models.ForeignKey(ShoppingCart, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)

    def __str__(self):
        return f"{self.quantity} x {self.product.name} in {self.cart}"

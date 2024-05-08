from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import User

class Customer(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)  # Use CharField for phone number
    location = models.ForeignKey("Location", related_name='customers', on_delete=models.SET_NULL, null=True, blank=True)
    def __str__(self):
        return self.username

class Delivery(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    driving_license_number = models.CharField(max_length=20, unique=True, help_text="Unique driving license number")
    vehicle_license_plate = models.CharField(max_length=15, unique=True, help_text="Vehicle license plate number")

    def __str__(self):
        return f"{self.username} (Driving License: {self.driving_license_number})"

class Administrator(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)
    def __str__(self):
        return self.username

class CustomerSupport(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)
    def __str__(self):
        return self.username


class Location(models.Model):
    name = models.CharField(max_length=20, blank=True)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Latitude: {self.latitude}, Longitude: {self.longitude}"


class Seller(User):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    store = models.OneToOneField('Store', related_name='seller_profile', on_delete=models.CASCADE, null=True)

class DiscountCode(models.Model):
    code = models.CharField(max_length=20, unique=True)
    discount_value = models.IntegerField(default=0, help_text="Discount value between 1 to 100")
    creation_date = models.DateTimeField(auto_now_add=True)
    expiration_date = models.DateTimeField()

    def __str__(self):
        return self.code

class Store(models.Model):
    name = models.CharField(max_length=100)
    location = models.ForeignKey("Location", related_name='stores', on_delete=models.SET_NULL, null=True, blank=True)
    discount_codes = models.ManyToManyField(DiscountCode, related_name='stores', blank=True)

    def __str__(self):
        return self.name

class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.IntegerField()
    store = models.ForeignKey(Store, related_name='products', on_delete=models.CASCADE, null=True)


    def __str__(self):
        return self.name


class ProductPicture(models.Model):
    product = models.ForeignKey(Product, related_name='pictures', on_delete=models.CASCADE)
    picture = models.ImageField(upload_to='product_pictures/')

    def __str__(self):
        return f"{self.product.name} Picture"

class ProductComment(models.Model):
    product = models.ForeignKey(Product, related_name='comments', on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, related_name='comments', on_delete=models.CASCADE)
    comment = models.TextField()
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comment for {self.product.name}"

class SalesReport(models.Model):
    store = models.ForeignKey(Store, related_name='sales_reports', on_delete=models.CASCADE)
    date = models.DateField()
    total_items_sold = models.IntegerField()
    total_income = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Sales Report for {self.store.name} on {self.date}"

class Chat(models.Model):
    customer_support = models.ForeignKey(CustomerSupport, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    def __str__(self):
        return f"Chat between {self.customer_support.user.username} and {self.customer.username}"

class Message(models.Model):
    chat = models.ForeignKey(Chat, related_name='messages', on_delete=models.CASCADE)
    text = models.TextField()
    date = models.DateTimeField(auto_now_add=True)
    sender_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    sender_id = models.PositiveIntegerField()
    sender = GenericForeignKey('sender_type', 'sender_id')

    def __str__(self):
        return f"Message in chat between {self.chat.customer_support.user.username} and {self.chat.customer.username}"

class Order(models.Model):
    class OrderStatus(models.TextChoices):
        PENDING = 'PENDING', _('Pending')
        PROCESSING = 'PROCESSING', _('Processing')
        DISPATCHED = 'DISPATCHED', _('Dispatched')
        DELIVERED = 'DELIVERED', _('Delivered')
        CANCELLED = 'CANCELLED', _('Cancelled')
        RETURNED = 'RETURNED', _('Returned')
        FAILED = 'FAILED', _('Failed')

    customer = models.ForeignKey(Customer, related_name='orders', on_delete=models.CASCADE)
    delivery_location = models.ForeignKey(Location, on_delete=models.SET_NULL, null=True, blank=True, related_name='orders')
    delivery_person = models.ForeignKey(Delivery, related_name='orders', on_delete=models.SET_NULL, null=True, blank=True)
    delivery_price = models.DecimalField(max_digits=6, decimal_places=2, help_text="Cost of delivery")
    discount = models.ForeignKey(DiscountCode, on_delete=models.SET_NULL, null=True, blank=True, help_text="Optional discount code applied to the order")
    discount_value = models.DecimalField(max_digits=10, decimal_places=2, default=0, help_text="Amount of discount applied to the order")
    total_price = models.DecimalField(max_digits=10, decimal_places=2, help_text="Total price of the order, including items and delivery")
    status = models.CharField(max_length=10, choices=OrderStatus.choices, default=OrderStatus.PENDING, help_text="Status of the order")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Order #{self.id} by {self.customer.username} - Total: {self.total_price} - Status: {self.status}"

class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, related_name='order_items', on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1, help_text="Quantity of the product in the order")

    def __str__(self):
        return f"{self.product.name} (x{self.quantity}) in Order #{self.order.id}"
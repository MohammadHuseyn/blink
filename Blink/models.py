from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
class User(models.Model):
    username = models.CharField(max_length=50, unique=True)
    firstname = models.CharField(max_length=100)
    lastname = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=20, null=True, blank=True)  # Use CharField for phone number
    email = models.EmailField(unique=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)

    class Meta:
        abstract = True

    def __str__(self):
        return self.username

    def full_name(self):
        return f"{self.firstname} {self.lastname}"

    def update_profile(self, firstname=None, lastname=None, phone_number=None, email=None, profile_picture=None):
        if firstname:
            self.firstname = firstname
        if lastname:
            self.lastname = lastname
        if phone_number:
            self.phone_number = phone_number
        if email:
            self.email = email
        if profile_picture:
            self.profile_picture = profile_picture
        self.save()

    def change_password(self, new_password):
        self.password = new_password
        self.save()

    def delete_account(self):
        self.delete()


class Customer(User):
    location = models.ForeignKey("Location", related_name='customers', on_delete=models.SET_NULL, null=True, blank=True)
    def __str__(self):
        return self.username

class Administrator(User):
    def __str__(self):
        return self.username

class CustomerSupport(User):
    def __str__(self):
        return self.username

class Location(models.Model):
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    address = models.CharField(max_length=255, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Latitude: {self.latitude}, Longitude: {self.longitude}"


class Seller(User):
    store = models.OneToOneField('Store', related_name='seller_profile', on_delete=models.CASCADE)

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
    seller = models.ForeignKey(Seller, related_name='stores_managed', on_delete=models.CASCADE)
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
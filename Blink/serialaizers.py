from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Customer, Seller, Delivery, Store, Location, Product, ShoppingCart, CartItem, ProductComment, Order, \
    StoreComment, Category, OrderItem


class UserSignupSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=150, required=True)
    password = serializers.CharField(write_only=True, required=True)
    email = serializers.EmailField(required=False, allow_blank=True)
    first_name = serializers.CharField(required=False, allow_blank=True)
    last_name = serializers.CharField(required=False, allow_blank=True)
    phone_number = serializers.CharField(required=False, allow_blank=True)
    user_type = serializers.ChoiceField(
        choices=[('customer', 'Customer'), ('seller', 'Seller'), ('delivery', 'Delivery')])

    store_name = serializers.CharField(max_length=100, required=False)
    category = serializers.CharField(max_length=25, required=False)
    latitude = serializers.DecimalField(max_digits=25, decimal_places=15, required=False)
    longitude = serializers.DecimalField(max_digits=25, decimal_places=15, required=False)
    location_name = serializers.CharField(max_length=20, required=False, allow_blank=True)
    image = serializers.CharField(max_length=20480000, required=False, allow_null=True, allow_blank=True)
    vehicle_license_plate = serializers.CharField(max_length=20, required=False, allow_blank=True)
    driving_license_number = serializers.CharField(max_length=20, required=False, allow_blank=True)

    def create(self, validated_data):
        user_type = validated_data.get('user_type')

        image = validated_data.get('image', None)
        if image == '':
            image = None

        if user_type == 'customer':
            user = Customer.objects.create_user(
                username=validated_data.get('username', ''),
                email=validated_data.get('email', ''),
                password=validated_data.get('password', ''),
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', ''),
                image=image
            )

        elif user_type == 'seller':

            user = Seller.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', ''),
                image=image
            )
            store_name = validated_data.pop('store_name', None)
            category = Category.objects.create(
                name=validated_data.pop('category', None)
            )
            seller = User.objects.get(id=user.id)

            if not store_name:
                raise serializers.ValidationError("Store name is required")
            if not store_name:
                raise serializers.ValidationError("Store category is required")

            location = Location.objects.create(
                latitude=validated_data.pop('latitude'),
                longitude=validated_data.pop('longitude'),
                name=validated_data.pop('location_name', ''),
                address=validated_data.pop('address', ''),
                user_id=seller.id
            )
            store = Store.objects.create(
                name=store_name,
                location=location,
                image=image,
                category=category,
                rate = 0
            )
            user.store = store
            user.save()

        elif user_type == 'delivery':
            # Add additional fields specific to delivery if needed
            user = Delivery.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', ''),
                vehicle_license_plate=validated_data.get('plate', ''),
                driving_license_number=validated_data.get('license', ''),
                image=validated_data.get('image', '')
            )
        else:
            raise serializers.ValidationError("Invalid user type")

        return user

class GeneralUserDetailSerializer(serializers.ModelSerializer):
    # Extend this serializer to capture common fields across all user types
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'password']  # Basic user fields


# If you have specific user types with additional fields, you can create specialized serializers
class CustomerDetailSerializer(GeneralUserDetailSerializer):
    class Meta:
        model = Customer
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', 'image']


class SellerDetailSerializer(GeneralUserDetailSerializer):
    class Meta:
        model = Seller
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', 'store', 'image']


class DeliveryDetailSerializer(GeneralUserDetailSerializer):
    class Meta:
        model = Delivery
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', 'vehicle_license_plate',
                                                            'driving_license_number']

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'name', 'price', 'quantity', 'image', 'category', 'rate']

class StoreSerializer(serializers.ModelSerializer):
    location = serializers.SerializerMethodField()

    class Meta:
        model = Store
        fields = ['id', 'name', 'location', 'image','category', 'rate', 'category']

    def get_location(self, obj):
        return LocationSerializer(obj.location).data

class CartItemSerializer(serializers.Serializer):
    product_id = serializers.IntegerField()
    quantity = serializers.IntegerField()

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'name', 'latitude', 'longitude', 'address']


class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class ProductCommentSerializer(serializers.ModelSerializer):
    user_first_name = serializers.CharField(source='user.first_name', read_only=True)
    user_last_name = serializers.CharField(source='user.last_name', read_only=True)
    class Meta:
        model = ProductComment
        fields = ['id', 'product', 'user', 'comment', 'user_first_name',
                  'user_last_name', 'comment_created', 'rate']
        read_only_fields = ['user_first_name', 'user_last_name']

class StoreCommentSerializer(serializers.ModelSerializer):
    user_first_name = serializers.CharField(source='user.first_name', read_only=True)
    user_last_name = serializers.CharField(source='user.last_name', read_only=True)
    class Meta:
        model = StoreComment
        fields = ['id', 'store', 'user', 'comment', 'user_first_name',
                  'user_last_name', 'comment_created', 'rate']
        read_only_fields = ['user_first_name', 'user_last_name']

class OrderItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer()
    class Meta:
        model = OrderItem
        fields = '__all__'
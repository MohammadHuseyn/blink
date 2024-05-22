from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Customer, Seller, Delivery, Store, Location, Product, ShoppingCart, CartItem, ProductComment


class UserSignupSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=150, required=True)
    password = serializers.CharField(write_only=True, required=True)
    email = serializers.EmailField(required=False, allow_blank=True)
    first_name = serializers.CharField(required=False, allow_blank=True)
    last_name = serializers.CharField(required=False, allow_blank=True)
    phone_number = serializers.CharField(required=False, allow_blank=True)
    user_type = serializers.ChoiceField(
        choices=[('customer', 'Customer'), ('seller', 'Seller'), ('delivery', 'Delivery')])
    # Additional fields for seller store information
    store_name = serializers.CharField(max_length=100, required=False)
    latitude = serializers.DecimalField(max_digits=25, decimal_places=15, required=False)  # For new location
    longitude = serializers.DecimalField(max_digits=25, decimal_places=15, required=False)  # For new location
    location_name = serializers.CharField(max_length=20, required=False, allow_blank=True)
    image = serializers.CharField(max_length=20480000, required=False)
    vehicle_license_plate = serializers.CharField(max_length=20, required=False, allow_blank=True)
    driving_license_number = serializers.CharField(max_length=20, required=False, allow_blank=True)
    def create(self, validated_data):
        user_type = validated_data.get('user_type')
        # Create the appropriate user based on user_type
        if user_type == 'customer':
            user = Customer.objects.create_user(
                username=validated_data.get('username', ''),
                email=validated_data.get('email', ''),
                password=validated_data.get('password', ''),
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', ''),
                image=validated_data.get('image', '')
            )

        elif user_type == 'seller':

            user = Seller.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', ''),
                image=validated_data.get('image', '')
            )
            store_name = validated_data.pop('store_name', None)
            user1 = User.objects.get(id=user.id)
            if not store_name:
                raise serializers.ValidationError("Store name is required")
            location = Location.objects.create(
                latitude=validated_data.pop('latitude'),
                longitude=validated_data.pop('longitude'),
                name=validated_data.pop('location_name', ''),
                address=validated_data.pop('address', ''),
                user_id=user1.id
            )
            print(location.latitude)
            store = Store.objects.create(
                name=store_name,
                location=location,
                image=validated_data.get('image', '')
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
        fields = ['id', 'name', 'price', 'quantity', 'image', 'category']

class StoreSerializer(serializers.ModelSerializer):
    products = serializers.SerializerMethodField()
    location = serializers.SerializerMethodField()

    class Meta:
        model = Store
        fields = ['id', 'name', 'location', 'products', 'image']

    def get_location(self, obj):
        return LocationSerializer(obj.location).data

    def get_products(self, obj):
        # Retrieve products related to this store and format as required
        product_data = ProductSerializer(obj.products.all(), many=True).data  # Get all products for this store

        # Create a dictionary with product_id as keys
        product_dict = {str(p['id']): p for p in product_data}

        return product_dict

class CartItemSerializer(serializers.Serializer):
    product_id = serializers.IntegerField()
    quantity = serializers.IntegerField()

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'name', 'latitude', 'longitude', 'address']
class ProductCommentSerializer(serializers.ModelSerializer):
    user_first_name = serializers.CharField(source='user.first_name', read_only=True)
    user_last_name = serializers.CharField(source='user.last_name', read_only=True)
    class Meta:
        model = ProductComment
        fields = ['id', 'product', 'user', 'comment', 'user_first_name',
                  'user_last_name', 'comment_created']
        read_only_fields = ['user_first_name', 'user_last_name']


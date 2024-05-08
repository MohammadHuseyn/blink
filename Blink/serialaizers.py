from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Customer, Seller, Delivery, Order, OrderItem


class UserSignupSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=150, required=True)
    password = serializers.CharField(write_only=True, required=True)
    email = serializers.EmailField(required=False, allow_blank=True)
    first_name = serializers.CharField(required=False, allow_blank=True)
    last_name = serializers.CharField(required=False, allow_blank=True)
    phone_number = serializers.CharField(required=False, allow_blank=True)
    user_type = serializers.ChoiceField(
        choices=[('customer', 'Customer'), ('seller', 'Seller'), ('delivery', 'Delivery')])

    def create(self, validated_data):
        user_type = validated_data.get('user_type')

        # Create the appropriate user based on user_type
        if user_type == 'customer':
            user = Customer.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', '')
            )
        elif user_type == 'seller':
            # You might need to handle store-related fields separately
            user = Seller.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', '')
            )
        elif user_type == 'delivery':
            # Add additional fields specific to delivery if needed
            user = Delivery.objects.create_user(
                username=validated_data['username'],
                email=validated_data.get('email', ''),
                password=validated_data['password'],
                first_name=validated_data.get('first_name', ''),
                last_name=validated_data.get('last_name', ''),
                phone_number=validated_data.get('phone_number', '')
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
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', 'location']

class SellerDetailSerializer(GeneralUserDetailSerializer):
    class Meta:
        model = Seller
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', '', 'store']

class DeliveryDetailSerializer(GeneralUserDetailSerializer):
    class Meta:
        model = Delivery
        fields = GeneralUserDetailSerializer.Meta.fields + ['phone_number', 'vehicle_license_plate', 'driving_license_number']
class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ['id', 'product', 'quantity']

class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)
    class Meta:
        model = Order
        fields = ['id', 'customer', 'delivery_location', 'delivery_person', 'delivery_price',
                  'discount', 'discount_value', 'total_price', 'status', 'created_at', 'updated_at', 'items']

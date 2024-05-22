from rest_framework.authentication import TokenAuthentication
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .serialaizers import UserSignupSerializer, GeneralUserDetailSerializer, CustomerDetailSerializer, \
    SellerDetailSerializer, DeliveryDetailSerializer, StoreSerializer, CartItemSerializer, LocationSerializer, \
    ProductSerializer, ProductCommentSerializer
from rest_framework.views import APIView
from rest_framework import status, generics
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import Customer, Seller, Delivery, Store, ShoppingCart, Product, CartItem, Location, Order, OrderItem, \
    Category, ProductComment
from rest_framework.authtoken.models import Token
from rest_framework.parsers import JSONParser
from django.utils import timezone
from rest_framework.filters import SearchFilter
from django_filters.rest_framework import DjangoFilterBackend
from django.contrib.auth.hashers import make_password, check_password

class SignupView(APIView):
    def post(self, request):
        serializer = UserSignupSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            try:
                customer = Customer.objects.get(id=user.id)

            except:
                customer = False
            try:
                seller = Seller.objects.get(id=user.id)

            except:
                seller = False
            try:
                delivery = Delivery.objects.get(id=user.id)
            except:
                delivery = False

            if customer:
                user_serializer = CustomerDetailSerializer(user)
                phone_number = customer.phone_number
                image = customer.image
                user_type = 'Customer'
            elif seller:
                user_serializer = SellerDetailSerializer(user)
                phone_number = seller.phone_number
                image = seller.image
                user_type = 'Seller'
            elif delivery:
                user_serializer = DeliveryDetailSerializer(user)
                phone_number = delivery.phone_number
                image = delivery.image
                user_type = 'Delivery'
            token, created = Token.objects.get_or_create(user=user)
            return Response({
                'token': token.key,
                'user': user_serializer.data,
                'phone_number': phone_number,
                'image': image,
                'user_type': user_type
            }, content_type='application/json; charset=utf-8', status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors,content_type='application/json; charset=utf-8', status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    def post(self, request):
        # Validate user input
        data = request.data
        username = data.get("username")
        password = data.get("password")
        phone_number = ''
        user_type = ''

        # Authenticate the user
        user = authenticate(username=username, password=password)
        try:
            customer = Customer.objects.get(id=user.id)

        except:
            customer = False
        try:
            seller = Seller.objects.get(id=user.id)

        except:
            seller = False
        try:
            delivery = Delivery.objects.get(id=user.id)
        except:
            delivery = False

        if user is not None:
            token, created = Token.objects.get_or_create(user=user)

            if customer:
                user_serializer = CustomerDetailSerializer(user)
                phone_number = customer.phone_number
                image = customer.image
                user_type = 'Customer'
            elif seller:
                user_serializer = SellerDetailSerializer(user)
                phone_number = seller.phone_number
                image = seller.image
                user_type = 'Seller'
            elif delivery:
                user_serializer = DeliveryDetailSerializer(user)
                phone_number = delivery.phone_number
                image = delivery.image
                user_type = 'Delivery'

            else:
                user_serializer = GeneralUserDetailSerializer(user)

            return Response({
                'token': token.key,
                'user': user_serializer.data,
                'phone_number': phone_number,
                'user_type': user_type,
                'image': image
            },content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)
        else:
            return Response({
                "error": "Invalid credentials"
            },content_type='application/json; charset=utf-8', status=status.HTTP_401_UNAUTHORIZED)


class StoreListView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        longitude = request.data.get("longitude")
        latitude = request.data.get("latitude")

        if not longitude or not latitude:
            return Response(
                {"error": "Longitude, latitude, and token are required"},content_type='application/json; charset=utf-8',
                status=status.HTTP_400_BAD_REQUEST
            )
        try:

            # Get all stores (you might want to filter by location or other criteria)
            stores = Store.objects.all()
            serializer = StoreSerializer(stores, many=True)
            store_dict = {str(store['id']): store for store in serializer.data}

            return Response(store_dict,content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)

        except Token.DoesNotExist:
            return Response(
                {"error": "Invalid token"},content_type='application/json; charset=utf-8',
                status=status.HTTP_401_UNAUTHORIZED
            )


class ShoppingCartView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = JSONParser().parse(request)
        serializer = CartItemSerializer(data=data, many=True)
        if serializer.is_valid():
            # Assuming the user is authenticated and retrieved from the token
            user = request.user
            # Create or get the shopping cart for the user
            shopping_cart, created = ShoppingCart.objects.get_or_create(user=user)

            # Process each cart item
            for cart_item_data in serializer.validated_data:
                product_id = cart_item_data['product_id']
                quantity = cart_item_data['quantity']
                product = Product.objects.get(pk=product_id)
                # Create or update the cart item
                cart_item, created = CartItem.objects.update_or_create(
                    cart=shopping_cart,
                    product=product,
                    defaults={'quantity': quantity}
                )
                # Optionally, you can perform additional actions here, such as updating product stock
            total_price = sum(item.product.price * item.quantity for item in shopping_cart.items.all()) + 50000

            return Response({"message": "Shopping cart updated successfully","total_price":total_price}, content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, content_type='application/json; charset=utf-8', status=status.HTTP_400_BAD_REQUEST)


class OrderFromCartView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        # Assuming the user is authenticated and retrieved from the token
        user = request.user
        user = Customer.objects.get(id=user.id)

        if not isinstance(user, Customer):
            # Handle the case where the user is not a Customer (e.g., raise an error)
            raise ValueError("User must be a Customer instance")
        # Retrieve the shopping cart for the user
        shopping_cart = ShoppingCart.objects.get(user=user)

        # Assuming the delivery location and other necessary details are provided in the request
        delivery_location_id = request.data.get('location_id')
        delivery_location = Location.objects.get(pk=delivery_location_id)
        total_price = sum(item.product.price * item.quantity for item in shopping_cart.items.all())

        # Create the order
        order = Order.objects.create(
            customer=user,
            delivery_location=delivery_location,
            delivery_price=50000,  # Example delivery price, replace with actual value
            discount=None,  # No discount applied initially, can be set based on business logic
            discount_value=0.00,  # No discount applied initially
            total_price=total_price,
            status=Order.OrderStatus.PENDING,  # Initial status set to PENDING
            created_at=timezone.now(),  # Set current time as creation time
            updated_at=timezone.now()  #
        )

        # Move items from the shopping cart to the order
        for cart_item in shopping_cart.items.all():
            OrderItem.objects.create(
                order=order,
                product=cart_item.product,
                quantity=cart_item.quantity
            )

        # Optionally, clear the shopping cart after creating the order
        shopping_cart.items.all().delete()

        return Response({"message": "Order placed successfully","order_id":order.id}, content_type='application/json; charset=utf-8', status=status.HTTP_201_CREATED)

class PaymentView(APIView):
    def post(self, request):
        order_id = request.data.get('order_id')
        is_paid = request.data.get('paid')  # Assuming you receive 'paid' parameter for payment status
        order = Order.objects.get(id=order_id)

        if is_paid:
            order.status = Order.OrderStatus.PENDING
            order.save()

            for item in order.items.all():
                product = item.product
                product.quantity -= item.quantity
                product.save()

            return Response({'pay': True, 'order_id': order_id}, content_type='application/json; charset=utf-8')
        else:
            order.status = Order.OrderStatus.FAILED
            order.save()
            return Response({'pay': False, 'order_id': order_id}, content_type='application/json; charset=utf-8')
class AddProductView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            data = request.data
            product_name = data.get('product_name')
            price = data.get('price')
            quantity = data.get('quantity')
            category_id = data.get('category_id')
            store_id = data.get('store_id')
            image = data.get('image')
            if not all([product_name, price, quantity, category_id, store_id]):
                return Response({'error': 'Missing required fields'}, status=status.HTTP_400_BAD_REQUEST, content_type='application/json; charset=utf-8')

            category, _ = Category.objects.get_or_create(id=category_id)
            store, _ = Store.objects.get_or_create(id=store_id)

            product = Product.objects.create(
                name=product_name,
                price=price,
                quantity=quantity,
                category=category,
                store=store,
                image=image
            )

            return Response({'success': 'Product added successfully', 'product_id': product.id}, status=status.HTTP_201_CREATED, content_type='application/json; charset=utf-8',)

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR, content_type='application/json; charset=utf-8')

class EditProductView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def put(self, request):
        try:
            data = request.data
            product_id = data.get('product_id')
            product_name = data.get('product_name')
            price = data.get('price')
            quantity = data.get('quantity')
            category_id = data.get('category_id')
            store_id = data.get('store_id')

            if not all([product_id, product_name, price, quantity, category_id, store_id]):
                return Response({'error': 'Missing required fields'}, status=status.HTTP_400_BAD_REQUEST, content_type='application/json; charset=utf-8',)

            product = Product.objects.get(id=product_id)

            category, _ = Category.objects.get_or_create(id=category_id)
            store, _ = Store.objects.get_or_create(id=store_id)

            product.name = product_name
            product.price = price
            product.quantity = quantity
            product.category = category
            product.store = store
            product.save()

            return Response({'success': 'Product updated successfully'}, status=status.HTTP_200_OK, content_type='application/json; charset=utf-8')

        except Product.DoesNotExist:
            return Response({'error': 'Product does not exist'}, status=status.HTTP_404_NOT_FOUND, content_type='application/json; charset=utf-8')

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR, content_type='application/json; charset=utf-8',)


class CustomerProfileEdit(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def put(self, request):
        user = request.user
        user = Customer.objects.get(id=user.id)
        data = request.data

        # Update user profile data
        user.username = data.get('username', user.username)
        user.email = data.get('email', user.email)
        user.first_name = data.get('first_name', user.first_name)
        user.last_name = data.get('last_name', user.last_name)
        password = data.get('password')
        image = data.get('image')
        user.phone_number = data.get('phone_number', user.phone_number)
        current_password = data.get('current_password')

        if password and current_password:
            if check_password(current_password, user.password):
                user.password = make_password(password)
            else:
                return Response({'error': 'Current password is incorrect'}, status=status.HTTP_400_BAD_REQUEST, content_type='application/json; charset=utf-8')

        user.save()

        return Response({'success': 'Profile updated successfully'}, status=status.HTTP_200_OK, content_type='application/json; charset=utf-8')

class LocationView(APIView):

    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    def get(self, request):
        user = request.user
        locations = Location.objects.filter(user_id=user.id)
        serializer = LocationSerializer(locations, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = LocationSerializer(data=request.data)
        customer = Customer.objects.get(user_ptr_id=request.user.id)
        if serializer.is_valid():
            location = Location.objects.create(
                name=request.data.get('name'),
                address=request.data.get('address'),
                longitude=request.data.get('longitude'),
                latitude=request.data.get('latitude'),
                user_id=customer.id
            )

            return Response(serializer.data, status=status.HTTP_201_CREATED, content_type='application/json; charset=utf-8',)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST, content_type='application/json; charset=utf-8',)


class SellerStoresView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        # Retrieve the seller based on the token
        seller = request.user

        try:
            seller_profile = Seller.objects.get(id=seller.id)

            # Get the seller's store
            store = seller_profile.store

            if store:
                # Get all products for the store
                products = Product.objects.filter(store=store)

                # Serialize the store and its products
                store_data = StoreSerializer(store).data
                products_data = ProductSerializer(products, many=True).data

                response_data = {
                    'store': store_data
                }

                return Response(response_data, status=status.HTTP_200_OK, content_type='application/json; charset=utf-8')
            else:
                return Response(
                    {"error": "No store associated with this seller."},
                    status=status.HTTP_404_NOT_FOUND, content_type='application/json; charset=utf-8'
                )

        except Seller.DoesNotExist:
            return Response(
                {"error": "Seller does not exist."},
                status=status.HTTP_404_NOT_FOUND, content_type='application/json; charset=utf-8'
            )

class ProductSearchView(generics.ListAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    filter_backends = [SearchFilter, DjangoFilterBackend]
    search_fields = ['name']

    def get_queryset(self):
        queryset = super().get_queryset()
        store_id = self.request.query_params.get('store_id', None)
        if store_id:
            queryset = queryset.filter(store_id=store_id)
        return queryset


class ProductCommentView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    def get(self, request):
        product_id = request.query_params.get('product_id')
        if not product_id:
            return Response({"error": "product_id is required as a query parameter"},
                            status=status.HTTP_400_BAD_REQUEST)
        comments = ProductComment.objects.filter(product_id=product_id)
        serializer = ProductCommentSerializer(comments, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK, content_type='application/json; charset=utf-8')

    def post(self, request):
        product_id = request.query_params.get('product_id')
        if not product_id:
            return Response({"error": "product_id is required as a query parameter"}, content_type='application/json; charset=utf-8',
                            status=status.HTTP_400_BAD_REQUEST)

        data = request.data.copy()
        data['product'] = product_id
        data['user'] = request.user.id
        serializer = ProductCommentSerializer(data=data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED, content_type='application/json; charset=utf-8')
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST, content_type='application/json; charset=utf-8')
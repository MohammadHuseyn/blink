from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .serialaizers import UserSignupSerializer, GeneralUserDetailSerializer, CustomerDetailSerializer, \
    SellerDetailSerializer, DeliveryDetailSerializer, StoreSerializer, CartItemSerializer, LocationSerializer, \
    ProductSerializer, OrderSerializer, ProductCommentSerializer
from rest_framework.views import APIView
from rest_framework import status, generics
from django.contrib.auth import authenticate
from .models import Customer, Seller, Delivery, Store, ShoppingCart, Product, CartItem, Location, Order, OrderItem, \
    Category, ProductComment
from rest_framework.authtoken.models import Token
from rest_framework.parsers import JSONParser
from django.utils import timezone
from rest_framework.filters import SearchFilter
from django_filters.rest_framework import DjangoFilterBackend
from django.contrib.auth.hashers import make_password, check_password
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi


class SignupView(APIView):
    @swagger_auto_schema(
        operation_description="Users Signup",
        responses={201: openapi.Response('Created', UserSignupSerializer), 400: 'Bad Request'},
        request_body=UserSignupSerializer
    )

    def post(self, request):
        serializer = UserSignupSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            try:
                customer = Customer.objects.get(id=user.id)

            except:
                customer = None
            try:
                seller = Seller.objects.get(id=user.id)

            except:
                seller = None
            try:
                delivery = Delivery.objects.get(id=user.id)
            except:
                delivery = None

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
                user_serializer = None
                phone_number = None
                image = None
                user_type = None
            token, created = Token.objects.get_or_create(user=user)
            return Response({
                'token': token.key,
                'user': user_serializer.data,
                'phone_number': phone_number,
                'image': image,
                'user_type': user_type
            }, content_type='application/json; charset=utf-8', status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, content_type='application/json; charset=utf-8',
                            status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    @swagger_auto_schema(
        operation_description="User Login",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username'),
                'password': openapi.Schema(type=openapi.TYPE_STRING, description='Password'),
            },
            required=['username', 'password']
        ),
        responses={
            200: 'Login Successful',
            401: 'Invalid Credentials'
        }
    )
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
            customer = None

        try:
            seller = Seller.objects.get(id=user.id)
        except:
            seller = None

        try:
            delivery = Delivery.objects.get(id=user.id)
        except:
            delivery = None

        if user is not None:
            token, created = Token.objects.get_or_create(user=user)

            if customer:
                user_serializer = CustomerDetailSerializer(customer)
                phone_number = customer.phone_number
                image = customer.image
                user_type = 'Customer'
            elif seller:
                user_serializer = SellerDetailSerializer(seller)
                phone_number = seller.phone_number
                image = seller.image
                user_type = 'Seller'
            elif delivery:
                user_serializer = DeliveryDetailSerializer(delivery)
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
            }, content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)
        else:
            return Response({
                "error": "Invalid credentials"
            }, content_type='application/json; charset=utf-8', status=status.HTTP_401_UNAUTHORIZED)


class StoreListView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve stores",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'longitude': openapi.Schema(type=openapi.TYPE_STRING, description='Longitude'),
                'latitude': openapi.Schema(type=openapi.TYPE_STRING, description='Latitude'),
            },
            required=['longitude', 'latitude']
        ),
        responses={
            200: StoreSerializer(many=True),
            400: 'Bad Request',
            401: 'Unauthorized'
        }
    )
    def post(self, request):
        longitude = request.data.get("longitude")
        latitude = request.data.get("latitude")

        if not longitude or not latitude:
            return Response(
                {"error": "Longitude, latitude, and token are required"},
                content_type='application/json; charset=utf-8',
                status=status.HTTP_400_BAD_REQUEST
            )
        try:

            # Get all stores (you might want to filter by location or other criteria)
            stores = Store.objects.all()
            serializer = StoreSerializer(stores, many=True)
            store_dict = {str(store['id']): store for store in serializer.data}

            return Response(store_dict, content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)

        except Token.DoesNotExist:
            return Response(
                {"error": "Invalid token"}, content_type='application/json; charset=utf-8',
                status=status.HTTP_401_UNAUTHORIZED
            )


class ShoppingCartView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Update shopping cart",
        responses={200: 'Shopping cart updated successfully', 400: 'Bad Request'},
        request_body=CartItemSerializer(many=True)
    )
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

            return Response({"message": "Shopping cart updated successfully", "total_price": total_price},
                            content_type='application/json; charset=utf-8', status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, content_type='application/json; charset=utf-8',
                            status=status.HTTP_400_BAD_REQUEST)


class OrderFromCartView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Create an order from shopping cart",
        responses={201: 'Order placed successfully', 400: 'Bad Request'},
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'location_id': openapi.Schema(type=openapi.TYPE_INTEGER, description='Delivery location ID'),
                'store_id': openapi.Schema(type=openapi.TYPE_INTEGER, description='Store ID'),
                'fast_delivery': openapi.Schema(type=openapi.TYPE_BOOLEAN, description='Fast delivery option')
            }
        )
    )
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
        delivery_location = Location.objects.get(id=delivery_location_id)
        total_price = sum(item.product.price * item.quantity for item in shopping_cart.items.all())
        store_id = request.data.get('store_id')
        store = Store.objects.get(id=store_id)
        fast_delivery = request.data.get('fast_delivery')
        if fast_delivery:
            delivery_price = 100000
        else:
            delivery_price = 50000

        # Create the order
        order = Order.objects.create(
            customer=user,
            delivery_location=delivery_location,
            delivery_price=delivery_price,
            discount=None,
            discount_value=0.00,
            total_price=total_price,
            status=Order.OrderStatus.PENDING,
            created_at=timezone.now(),
            updated_at=timezone.now(),
            store=store,
            fast_delivery=fast_delivery,
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

        return Response({"message": "Order placed successfully", "order_id": order.id},
                        content_type='application/json; charset=utf-8', status=status.HTTP_201_CREATED)


class PaymentView(APIView):
    @swagger_auto_schema(
        operation_description="Process a payment for an order",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'order_id': openapi.Schema(type=openapi.TYPE_INTEGER, description='ID of the order'),
                'paid': openapi.Schema(type=openapi.TYPE_BOOLEAN, description='Payment status')
            },
            required=['order_id', 'paid']
        ),
        responses={
            200: openapi.Response(description='Payment processed successfully', examples={
                'application/json': {'pay': True, 'order_id': 1}
            }),
            400: openapi.Response(description='Bad Request')
        }
    )
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

    @swagger_auto_schema(
        operation_description="Add a new product",
        request_body=ProductSerializer,
        responses={
            201: openapi.Response(description='Product added successfully', examples={
                'application/json': {'success': 'Product added successfully', 'product_id': 1}
            }),
            400: openapi.Response(description='Bad Request'),
            500: openapi.Response(description='Internal Server Error')
        }
    )
    def post(self, request):
        try:
            data = request.data
            product_name = data.get('product_name')
            price = data.get('price')
            quantity = data.get('quantity')
            category_id = data.get('category_id')
            store_id = data.get('store_id')
            image = data.get('image')
            description = data.get('product_description')
            if not all([product_name, price, quantity, category_id, store_id]):
                return Response({'error': 'Missing required fields'}, status=status.HTTP_400_BAD_REQUEST,
                                content_type='application/json; charset=utf-8')

            category, _ = Category.objects.get_or_create(id=category_id)
            store, _ = Store.objects.get_or_create(id=store_id)

            product = Product.objects.create(
                name=product_name,
                price=price,
                quantity=quantity,
                category=category,
                store=store,
                image=image,
                description=description
            )

            return Response({'success': 'Product added successfully', 'product_id': product.id},
                            status=status.HTTP_201_CREATED, content_type='application/json; charset=utf-8', )

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                            content_type='application/json; charset=utf-8')


class EditProductView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Edit an existing product",
        request_body=ProductSerializer,
        responses={
            200: openapi.Response(description='Product updated successfully', examples={
                'application/json': {'success': 'Product updated successfully'}
            }),
            400: openapi.Response(description='Bad Request'),
            404: openapi.Response(description='Product not found'),
            500: openapi.Response(description='Internal Server Error')
        }
    )
    def put(self, request):
        try:
            data = request.data
            product_id = data.get('product_id')
            product_name = data.get('product_name')
            price = data.get('price')
            quantity = data.get('quantity')
            category_id = data.get('category_id')
            store_id = data.get('store_id')
            image = data.get('image')
            description = data.get('product_description')

            if not all([product_id, product_name, price, quantity, category_id, store_id]):
                return Response({'error': 'Missing required fields'}, status=status.HTTP_400_BAD_REQUEST,
                                content_type='application/json; charset=utf-8', )

            product = Product.objects.get(id=product_id)

            category, _ = Category.objects.get_or_create(id=category_id)
            store, _ = Store.objects.get_or_create(id=store_id)

            product.name = product_name
            product.price = price
            product.quantity = quantity
            product.category = category
            product.store = store
            product.image = image
            product.description = description
            product.save()

            return Response({'success': 'Product updated successfully'}, status=status.HTTP_200_OK,
                            content_type='application/json; charset=utf-8')

        except Product.DoesNotExist:
            return Response({'error': 'Product does not exist'}, status=status.HTTP_404_NOT_FOUND,
                            content_type='application/json; charset=utf-8')

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                            content_type='application/json; charset=utf-8', )


class CustomerProfileEdit(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Edit customer profile",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'username': openapi.Schema(type=openapi.TYPE_STRING, description='Username'),
                'email': openapi.Schema(type=openapi.TYPE_STRING, description='Email'),
                'first_name': openapi.Schema(type=openapi.TYPE_STRING, description='First Name'),
                'last_name': openapi.Schema(type=openapi.TYPE_STRING, description='Last Name'),
                'password': openapi.Schema(type=openapi.TYPE_STRING, description='New Password'),
                'current_password': openapi.Schema(type=openapi.TYPE_STRING, description='Current Password'),
                'phone_number': openapi.Schema(type=openapi.TYPE_STRING, description='Phone Number'),
                'image': openapi.Schema(type=openapi.TYPE_STRING, description='Profile Image URL'),
            }
        ),
        responses={
            200: openapi.Response(description='Profile updated successfully', examples={
                'application/json': {'success': 'Profile updated successfully'}
            }),
            400: openapi.Response(description='Bad Request')
        }
    )
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
                return Response({'error': 'Current password is incorrect'}, status=status.HTTP_400_BAD_REQUEST,
                                content_type='application/json; charset=utf-8')

        user.save()

        return Response({'success': 'Profile updated successfully'}, status=status.HTTP_200_OK,
                        content_type='application/json; charset=utf-8')


class LocationView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve user locations",
        responses={200: LocationSerializer(many=True)}
    )
    def get(self, request):
        user = request.user
        locations = Location.objects.filter(user_id=user.id)
        serializer = LocationSerializer(locations, many=True)
        return Response(serializer.data)

    @swagger_auto_schema(
        operation_description="Add a new location",
        request_body=LocationSerializer,
        responses={
            201: openapi.Response(description='Location added successfully', examples={
                'application/json': {'success': 'Location added successfully'}
            }),
            400: openapi.Response(description='Bad Request')
        }
    )
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

            return Response(serializer.data, status=status.HTTP_201_CREATED,
                            content_type='application/json; charset=utf-8', )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST,
                        content_type='application/json; charset=utf-8', )


class SellerStoresView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve seller stores and their products",
        responses={
            200: openapi.Response(description='Store details and products retrieved successfully'),
            404: openapi.Response(description='Seller or store not found')
        }
    )
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

                return Response(response_data, status=status.HTTP_200_OK,
                                content_type='application/json; charset=utf-8')
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

    @swagger_auto_schema(
        operation_description="Search products by name and optionally filter by store ID",
        manual_parameters=[
            openapi.Parameter('store_id', openapi.IN_QUERY, description="ID of the store", type=openapi.TYPE_INTEGER)
        ],
        responses={200: ProductSerializer(many=True)}
    )
    def get_queryset(self):
        queryset = super().get_queryset()
        store_id = self.request.query_params.get('store_id', None)
        if store_id:
            queryset = queryset.filter(store_id=store_id)
        return queryset


class AcceptRejectOrderView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve pending, processing, and waiting orders for a store",
        manual_parameters=[
            openapi.Parameter('store_id', openapi.IN_QUERY, description="ID of the store", type=openapi.TYPE_INTEGER)
        ],
        responses={200: openapi.Response(description="Orders retrieved successfully")}
    )
    def get(self, request):
        store_id = request.query_params.get('store_id')
        desired_statuses = ['PENDING', 'PROCESSING', 'WAITING']
        orders = Order.objects.filter(store_id=store_id, status__in=desired_statuses)
        json_data = []
        for order in orders:
            customer_name = order.customer.first_name + " " + order.customer.last_name
            delivery_location = Location.objects.get(id=order.delivery_location.id).address
            order_items = OrderItem.objects.filter(order_id=order.id)
            fast_delivery = order.fast_delivery
            order_items_data = []
            for item in order_items:
                product = Product.objects.get(id=item.product.id)
                product_id = product.id
                product_name = product.name
                count = item.quantity
                price = product.price
                image = product.image
                order_items_data.append(
                    {"product_id": product_id, "product_name": product_name, "count": count, "price": price,
                     "image": image})

            json_data.append({"order_id": order.id, 'customer_name': customer_name,
                              'delivery_location': delivery_location, "status": order.status,
                              "total_price": order.total_price, "order_items": order_items_data,
                              "discount_value": order.discount_value, "discount_code": None,
                              "fast_delivery": fast_delivery})

        return Response(json_data)

    @swagger_auto_schema(
        operation_description="Accept, reject, or process an order",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'order_id': openapi.Schema(type=openapi.TYPE_INTEGER, description='ID of the order'),
                'status': openapi.Schema(type=openapi.TYPE_STRING, description='New status of the order')
            },
            required=['order_id', 'status']
        ),
        responses={
            200: openapi.Response(description='Order status updated successfully', examples={
                'application/json': {'message': 'Order status updated successfully'}
            }),
            400: openapi.Response(description='Bad Request'),
            404: openapi.Response(description='Order not found')
        }
    )
    def post(self, request):
        # Parse JSON data
        data = request.data
        order_id = data.get('order_id')
        order_status = data.get('status')
        desired_statuses = ['PENDING', 'PROCESSING', 'WAITING']

        # Validate data
        if order_id is None or order_status is None:
            return Response({'error': 'Both order_id and accept fields are required'},
                            status=status.HTTP_400_BAD_REQUEST)

        try:
            # Retrieve the order
            order = Order.objects.get(pk=order_id, status__in=desired_statuses)

            # Update order status based on accept value
            if order_status == 'Accepted':
                order.status = Order.OrderStatus.PROCESSING
            elif order_status == 'Rejected':
                order.status = Order.OrderStatus.CANCELLED
            elif order_status == 'Processed':
                order.status = Order.OrderStatus.WAITING

            # Save changes
            order.updated_at = timezone.now()
            order.save()

            return Response({'message': 'Order status updated successfully'}, status=status.HTTP_200_OK)

        except Order.DoesNotExist:
            return Response({'error': 'Order not found'}, status=status.HTTP_404_NOT_FOUND)


class OrderStatusView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve order status",
        manual_parameters=[
            openapi.Parameter('order_id', openapi.IN_QUERY, description="ID of the order", type=openapi.TYPE_INTEGER)
        ],
        responses={200: OrderSerializer}
    )
    def get(self, request):
        order_id = request.query_params.get('order_id')
        order = Order.objects.get(id=order_id)
        order_data = OrderSerializer(order)

        return Response({"order": order_data.data})


class DeliveryOrdersView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve dispatched and waiting orders",
        responses={200: openapi.Response(description="Orders retrieved successfully")}
    )
    def get(self, request):
        desired_statuses = ['DISPATCHED', 'WAITING']
        orders = Order.objects.filter(status__in=desired_statuses)
        json_data = []
        for order in orders:
            customer_name = order.customer.first_name + " " + order.customer.last_name
            store = Store.objects.get(id=order.store_id)
            delivery_location = Location.objects.get(id=order.delivery_location.id)
            store_location = Location.objects.get(id=store.location.id)
            delivery_address = delivery_location.address
            delivery_long = delivery_location.longitude
            delivery_lat = delivery_location.latitude
            store_address = store_location.address
            store_long = store_location.longitude
            store_lat = store_location.latitude

            delivery_price = order.delivery_price
            store_name = store.name

            fast_delivery = order.fast_delivery
            json_data.append({"order_id": order.id, 'customer_name': customer_name,
                              "delivery_address": delivery_address, "status": order.status,
                              "store_address": store_address, "fast_delivery": fast_delivery,
                              "store_name": store_name, "delivery_price": delivery_price,
                              "delivery_latitude": delivery_lat, "delivery_longitude": delivery_long,
                              "store_latitude": store_lat, "store_longitude": store_long
                              })

        return Response(json_data)

    @swagger_auto_schema(
        operation_description="Update delivery order status",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'order_id': openapi.Schema(type=openapi.TYPE_INTEGER, description='ID of the order'),
                'status': openapi.Schema(type=openapi.TYPE_STRING, description='New status of the order')
            },
            required=['order_id', 'status']
        ),
        responses={
            200: openapi.Response(description='Order status updated successfully', examples={
                'application/json': {'message': 'Order status updated successfully'}
            }),
            400: openapi.Response(description='Bad Request'),
            404: openapi.Response(description='Order not found')
        }
    )
    def post(self, request):
        user = request.user
        user = Delivery.objects.get(id=user.id)
        data = request.data
        order_id = data.get('order_id')
        order_status = data.get('status')

        # Validate data
        if order_id is None or order_status is None:
            return Response({'error': 'Both order_id and accept fields are required'},
                            status=status.HTTP_400_BAD_REQUEST)

        try:
            # Retrieve the order
            order = Order.objects.get(pk=order_id)

            # Update order status based on accept value
            if order_status == 'Accepted':
                order.status = Order.OrderStatus.DISPATCHED
                order.delivery_person = user
            elif order_status == 'Rejected':
                order.status = Order.OrderStatus.WAITING
                order.delivery_person = None
            elif order_status == 'Delivered':
                order.status = Order.OrderStatus.DELIVERED

            # Save changes
            order.updated_at = timezone.now()
            order.save()

            return Response({'message': 'Order status updated successfully'}, status=status.HTTP_200_OK)

        except Order.DoesNotExist:
            return Response({'error': 'Order not found'}, status=status.HTTP_404_NOT_FOUND)


class ProductCommentView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_description="Retrieve comments for a product",
        manual_parameters=[
            openapi.Parameter('product_id', openapi.IN_QUERY, description="ID of the product",
                              type=openapi.TYPE_INTEGER)
        ],
        responses={200: ProductCommentSerializer(many=True)}
    )
    def get(self, request):
        product_id = request.query_params.get('product_id')
        if not product_id:
            return Response({"error": "product_id is required as a query parameter"},
                            status=status.HTTP_400_BAD_REQUEST)
        comments = ProductComment.objects.filter(product_id=product_id)
        serializer = ProductCommentSerializer(comments, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK, content_type='application/json; charset=utf-8')

    @swagger_auto_schema(
        operation_description="Add a comment to a product",
        request_body=ProductCommentSerializer,
        responses={
            201: openapi.Response(description='Comment created successfully', examples={
                'application/json': {'message': 'Comment created successfully'}
            }),
            400: openapi.Response(description='Bad Request')
        }
    )
    def post(self, request):
        product_id = request.query_params.get('product_id')
        if not product_id:
            return Response({"error": "product_id is required as a query parameter"},
                            content_type='application/json; charset=utf-8',
                            status=status.HTTP_400_BAD_REQUEST)

        data = request.data.copy()
        data['product'] = product_id
        data['user'] = request.user.id
        serializer = ProductCommentSerializer(data=data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED,
                            content_type='application/json; charset=utf-8')
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST,
                        content_type='application/json; charset=utf-8')

from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .serialaizers import UserSignupSerializer, GeneralUserDetailSerializer, CustomerDetailSerializer, \
    SellerDetailSerializer, DeliveryDetailSerializer, StoreSerializer
from rest_framework.views import APIView
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import Customer, Seller, Delivery, Store
from rest_framework.authtoken.models import Token


class SignupView(APIView):
    def post(self, request):
        serializer = UserSignupSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            token, created = Token.objects.get_or_create(user=user)
            return Response({
                'token': token.key,
                'user_id': user.id,
                'username': user.username
            }, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    def post(self, request):
        # Validate user input
        data = request.data
        username = data.get("username")
        password = data.get("password")

        # Authenticate the user
        user = authenticate(username=username, password=password)

        if user is not None:
            token, created = Token.objects.get_or_create(user=user)

            # Determine the type of user
            if isinstance(user, Customer):
                user_serializer = CustomerDetailSerializer(user)
            elif isinstance(user, Seller):
                user_serializer = SellerDetailSerializer(user)
            elif isinstance(user, Delivery):
                user_serializer = DeliveryDetailSerializer(user)
            else:
                user_serializer = GeneralUserDetailSerializer(user)

            return Response({
                'token': token.key,
                'user': user_serializer.data,
            }, status=status.HTTP_200_OK)
        else:
            return Response({
                "error": "Invalid credentials"
            }, status=status.HTTP_401_UNAUTHORIZED)


class StoreListView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        longitude = request.data.get("longitude")
        latitude = request.data.get("latitude")
        token_key = request.data.get("token")

        if not longitude or not latitude or not token_key:
            return Response(
                {"error": "Longitude, latitude, and token are required"},
                status=status.HTTP_400_BAD_REQUEST
            )
        try:
            token = Token.objects.get(key=token_key)
            user = token.user

            # Get all stores (you might want to filter by location or other criteria)
            stores = Store.objects.all()
            serializer = StoreSerializer(stores, many=True)
            store_dict = {str(store['id']): store for store in serializer.data}

            return Response(store_dict, status=status.HTTP_200_OK)

        except Token.DoesNotExist:
            return Response(
                {"error": "Invalid token"},
                status=status.HTTP_401_UNAUTHORIZED
            )

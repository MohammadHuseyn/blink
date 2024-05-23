"""
URL configuration for Blink project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from .views import SignupView, LoginView, StoreListView, ShoppingCartView, OrderFromCartView, PaymentView, \
    AddProductView, CustomerProfileEdit, LocationView, SellerStoresView, EditProductView, AcceptRejectOrderView, \
    OrderStatusView, DeliveryOrdersView, ProductSearchView, ProductCommentView, StoreCommentView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('signup/', SignupView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('stores/', StoreListView.as_view(), name='store-list'),
    path('cart/',ShoppingCartView.as_view(), name='cart'),
    path('makeorder/', OrderFromCartView.as_view(), name='makeorder'),
    path('payment/', PaymentView.as_view(), name='payment'),
    path('add_product/', AddProductView.as_view(), name='add_product'),
    path('edit_product/', EditProductView.as_view(), name='add_product'),
    path('customer_edit_profile/', CustomerProfileEdit.as_view(), name='customer_edit_profile'),
    path('locations/', LocationView.as_view(), name='location'),
    path('get_sellers_store/', SellerStoresView.as_view(), name='seller-stores'),
    path('accept_reject_order/', AcceptRejectOrderView.as_view(), name='accept_reject_order'),
    path('order_status/', OrderStatusView.as_view(), name='order_status'),
    path('delivery_orders/', DeliveryOrdersView.as_view(), name='delivery'),
    path('product-comments/', ProductCommentView.as_view(), name='product-comments'),
    path('products/search/', ProductSearchView.as_view(), name='product-search'),
    path('store-comments/', StoreCommentView.as_view(), name='store-comments'),

]

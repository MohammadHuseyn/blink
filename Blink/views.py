from django.shortcuts import render
from .utils import get_all_customers

def users_list_view(request):
    customers = get_all_customers()

    context = {'Customers': customers}

    return render(request, 'customers_list.html', context)

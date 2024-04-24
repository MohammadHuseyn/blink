from .models import Customer


def get_all_customers():
    return Customer.objects.all()

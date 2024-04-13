class Shop:
    def __init__(self, name, address, location):
        self.name = name
        self.address = address
        self.location = location
        self.comments = []
        self.discount_codes = []
        self.products = []

    def add_product(self, product):
        self.products.append(product)
        print(f"Product '{product.name}' added to shop '{self.name}'.")

    def modify_product(self, product_name, new_price=None, new_quantity=None):
        for product in self.products:
            if product.name == product_name:
                if new_price is not None:
                    product.price = new_price
                    print(f"Price of product '{product_name}' modified to {new_price}.")
                if new_quantity is not None:
                    product.quantity = new_quantity
                    print(f"Quantity of product '{product_name}' modified to {new_quantity}.")
                return
        print(f"Product '{product_name}' not found in shop '{self.name}'.")

    def modify_shop_info(self, name=None, address=None, location=None):
        if name:
            self.name = name
            print(f"Shop name modified to '{name}'.")
        if address:
            self.address = address
            print(f"Shop address modified to '{address}'.")
        if location:
            self.location = location
            print(f"Shop location modified to '{location}'.")
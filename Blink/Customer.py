from Blink.User import User

class Customer(User):
    def __init__(self, username, name, password, email, location=None, address=None, profile_picture=None):
        super().__init__(username, name, password, email, profile_picture)
        self.location = location
        self.address = address
        self.cart = []
        self.chats = []

    def modify_location(self, location):
        self.location = location

    def modify_address(self, address):
        self.address = address

    def add_to_cart(self, product):
        self.cart.append(product)
        print(f"Product '{product.name}' added to cart.")

    def remove_from_cart(self, product):
        if product in self.cart:
            self.cart.remove(product)
            print(f"Product '{product.name}' removed from cart.")
        else:
            print("Product not found in cart.")
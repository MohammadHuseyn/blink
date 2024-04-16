class Product:
    def __init__(self, name, price, quantity, comments=None, pictures=None):
        self.name = name
        self.price = price
        self.quantity = quantity
        self.comments = comments if comments else []
        self.pictures = pictures if pictures else []

    def add_comment(self, comment):
        self.comments.append(comment)
        print(f"Comment added to product '{self.name}': {comment}")

    def add_picture(self, picture):
        self.pictures.append(picture)
        print(f"Picture added to product '{self.name}': {picture}")

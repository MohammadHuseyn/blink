class User:
    def __init__(self, username, name, password, email, profile_picture=None):
        self.username = username
        self.name = name
        self.password = password
        self.email = email
        self.profile_picture = profile_picture

    def modify_profile(self, name=None, password=None, email=None, profile_picture=None):
        if name:
            self.name = name
        if password:
            self.password = password
        if email:
            self.email = email
        if profile_picture:
            self.profile_picture = profile_picture
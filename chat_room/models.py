from django.db import models
import uuid
from datetime import datetime
from Blink.models import *


class Room(models.Model):
    uuid = models.CharField(max_length=225 ,default=uuid.uuid4())
    user = models.OneToOneField(Customer, on_delete=models.CASCADE)
    support = models.OneToOneField(CustomerSupport, on_delete=models.CASCADE)

    def __str__(self):
        return self.uuid




class Message(models.Model):
    message = models.TextField()
    date = models.DateTimeField(default=datetime.now, blank=True)
    sender = models.CharField(max_length=225)
    room = models.ForeignKey(Room, on_delete=models.CASCADE)




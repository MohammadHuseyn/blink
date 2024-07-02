from rest_framework import serializers
from .models import *
from django.shortcuts import get_object_or_404


class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = []


    def create(self, validated_data):
  
  
        validated_data['support'] = get_object_or_404(CustomerSupport, username='chat_admin')
        return super().create(validated_data)





class RoomDeleteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = "__all__"






class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['message']

    def create(self, validated_data):
        sender = validated_data['sender']
        
        try:
            room = Room.objects.get(user=sender)
        except:
            room = Room.objects.get(support=sender)


        validated_data['room'] =  get_object_or_404(Room, uuid=room)
        return super().create(validated_data)








class MessageViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = '__all__'



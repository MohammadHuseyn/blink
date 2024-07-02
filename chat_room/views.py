from chat_room.serializers import *
from rest_framework import generics
from .models import *
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404





class StartChatRoom(generics.CreateAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        user = get_object_or_404(Customer, username=self.request.user)
        serializer.save(user=user)



class DeleteChatRoom(generics.DestroyAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomDeleteSerializer
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]








class ViewMessage(generics.ListAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageViewSerializer
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]



class SendMessage(generics.CreateAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(sender=self.request.user)





from django.urls import path, include
from .views import *


urlpatterns = [
    path('start_room', StartChatRoom.as_view()),
    path('delete_room/<int:pk>', DeleteChatRoom.as_view()),
    path('view_message', ViewMessage.as_view()),
    path('send_message', SendMessage.as_view()),
]

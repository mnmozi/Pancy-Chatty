 # Pancy-Chatty 

Hello :wave: my name is Mostafa Nasr

And this is a chat system application using Ruby on Rails

---
## How to run the project!

all you need is docker installed in you machine and run the following

 
```bash
  docker-compose build
```
This will build the docker file for the application.

```bash
  docker-compose up
```
This will run the app and you can start sending requests.


## Documentation

This app is a simple chatting app where we have 3 modules that you can think
of.
1. Application.
2. Chat.
3. Messages.

You can create multiple applications, each application can have multiple chats
and each chat can have multiple messages.

once your start the project locally you can run this commands to test it.
### Application
#### Create an app

To create an application you need to send a POST request to

```bash
localhost:3000/api/v1/apps
```

with body 

    "app":{
        "name":"app1"
    }


this will create an application with the name app1 and will return you the
token for this app, we will use this token to identify our app

#### Get the token for this app

To get the token for your app by name you send a GET request to
```bash
localhost:3000/api/v1/<NAME_OF_YOUR_APP>
```
or to get all the application you have you can set a GET request to 

```bash
localhost:3000/api/v1/apps/
```


Now you are set to create chats in your application.

### Chat
#### Create a chat

With your token you can create chats for your app, Send a POST request to

```bash
localhost:3000/api/v1/apps/<YOUR_APP_TOKEN>/chats
```
This will create a chat for you and will return you the number of this chat.


#### Get the chats
To know all your chats in your application you can send a GET request to

```bash
localhost:3000/api/v1/apps/<YOUR_APP_TOKEN>/chats
```

this will return you a list of all the chats with their numbers.

### Messages
#### Send a message in a specific chat

To send a message in a chat you created you can send a POST requst to

```bash
localhost:3000/api/v1/apps/<YOUR_APP_TOKEN>/chats/<CHAT_NUMBER>/messages
```
with a body

    "app":{
        "content":"Good morning!"
    }

this will create a message for this chat and assigns a number to it.

#### Get all messages in a chat

To get the messages in the chat you can send a GET request to
```bash
localhost:3000/api/v1/apps/<YOUR_APP_TOKEN>/chats/<CHAT_NUMBER>/messages
```

this is limited to 100 record and you can specify :limit and :offset

#### Search for a message

This feature is made by elastic search so you need to hava an instance of elastic
running and provide the url in the ruby.env file

I couldn't run it in my docker-compose as it freezes my laptop for some reason.

So I used the free tiral in elasticsearch and added the url in the ruby.env file
so It will only work for 14 days maybe less.

you can search by sending a GET request to

```bash
localhost:3000/api/v1/apps/<YOUR_APP_TOKEN>/chats/<CHAT_NUMBER>/search/<SEARCH_KEY>
```


 
 




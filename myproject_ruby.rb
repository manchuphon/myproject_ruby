### แทนใน attributes: name, email, and password ###
class User
    attr_accessor :name, :email, :password, :rooms
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []  # List of rooms the user has joined
    end
  
    ####  Method for a user to enter a room ####
    def enter_room(room)
      room.add_user(self)
      @rooms << room unless @rooms.include?(room)
      puts "#{@name} has entered the room: #{room.name}"
    end
  
    #### Method for a user to send a message to a room ###
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "You need to join the room before sending a message!"
      end
    end
  
    ##### Method to acknowledge receipt of a message ####
    def acknowledge_message(room, message)
      if @rooms.include?(room)
        puts "#{@name} acknowledges the message: '#{message.content}' from #{message.user.name}"
      else
        puts "Message not received. You are not in the room."
      end
    end
  end
  
  ####### Class representing a room with a name, description, and a list of users #####
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []  # Users in the room
    end
  
    ##### เพิ่มผู้ใช้ ####
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    #### Broadcast a message to all users in the room ####
    def broadcast(message)
      puts "Broadcasting in room #{name}: '#{message.content}' from #{message.user.name}"
      @users.each do |user|
        user.acknowledge_message(self, message) unless user == message.user
      end
    end
  end
  
  ##### Class representing a message with attributes: user, room, and content #####
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
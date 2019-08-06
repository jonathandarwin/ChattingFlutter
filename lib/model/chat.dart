class Chat{  
  String _username;
  String _chat;

  Chat();

  Chat.setData(
    this._username,
    this._chat
  );

  String get username => _username;
  String get chat => _chat;

  set username(String username) => this._username = username;
  set chat(String chat) => this._chat = chat;

  Chat.fromJson(Map<dynamic, dynamic> data){
    this._username = data['username'];
    this._chat = data['chat'];
  }
  

  Map<dynamic, dynamic> toJson() => {
    'username' : this._username,
    'chat' : this._chat
  };
}
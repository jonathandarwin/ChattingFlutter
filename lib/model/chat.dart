class Chat{  
  String _username;
  String _chat;
  String _datetime;

  Chat();

  Chat.setData(
    this._username,
    this._chat,
    this._datetime
  );

  String get username => _username;
  String get chat => _chat;
  String get datetime => _datetime;

  set username(String username) => this._username = username;
  set chat(String chat) => this._chat = chat;
  set datetime(String datetime) => this._datetime = datetime;

  Chat.fromJson(Map<dynamic, dynamic> data){
    this._username = data['username'];
    this._chat = data['chat'];
    this._datetime = data['datetime'];
  }
  

  Map<dynamic, dynamic> toJson() => {
    'username' : this._username,
    'chat' : this._chat,
    'datetime' : this._datetime
  };
}
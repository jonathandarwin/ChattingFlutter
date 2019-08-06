class User{
  String _name;
  String _username;
  String _password;  

  User();

  User.setData(
    this._name,
    this._username,
    this._password
  );

  User.fromJson(Map<dynamic, dynamic> data){
    this._name = data['name'];
    this._username = data['username'];
    this._password = data['password'];
  }

  Map<String, dynamic> toJson(){
    return {
      'name' : this._name,
      'username' : this._username,
      'password' : this._password
    };
  }

  get name => _name;
  get username => _username;
  get password => _password;  

  set name(String name) => this._name = name;
  set username(String username) => this._username = username;
  set password(String password) => this._password = password;  
}
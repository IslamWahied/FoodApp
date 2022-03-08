// @dart=2.9
class UserModel
{

  String image;
  bool isAdmin;
  int departmentId;
  String mobile;
  String userName;
  String fireBaseToken;


  UserModel({
    this.departmentId,
    this.image,
    this.isAdmin,

    this.mobile,
    this.userName,
    this.fireBaseToken,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    departmentId = json['departmentId'];
    image = json['image'];
    isAdmin = json['isAdmin'];

    mobile = json['mobile'];
    userName = json['userName'];
    fireBaseToken = json['fireBaseToken']??'';
  }

  Map<String, dynamic> toMap()
  {
    return {
      'departmentId':departmentId,
      'image':image,
      'isAdmin':isAdmin,

      'mobile':mobile,
      'fireBaseToken':fireBaseToken??'',
      'userName':userName,
    };
  }
}
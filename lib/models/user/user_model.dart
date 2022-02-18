// @dart=2.9
class UserModel
{

  String image;
  bool isAdmin;
  int departmentId;
  String mobile;
  String userName;


  UserModel({
    this.departmentId,
    this.image,
    this.isAdmin,

    this.mobile,
    this.userName,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    departmentId = json['departmentId'];
    image = json['image'];
    isAdmin = json['isAdmin'];

    mobile = json['mobile'];
    userName = json['userName'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'departmentId':departmentId,
      'image':image,
      'isAdmin':isAdmin,

      'mobile':mobile,
      'userName':userName,
    };
  }
}
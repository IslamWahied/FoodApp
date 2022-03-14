// @dart=2.9
class UserModel
{

  String image;
  bool isAdmin;

  String mobile;
  String userName;
  String fireBaseToken;
  String departMent;


  UserModel({

    this.image,
    this.isAdmin,
    this.departMent,
    this.mobile,
    this.userName,
    this.fireBaseToken,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {

    image = json['image'];
    isAdmin = json['isAdmin'];
    departMent = json['departMent'];
    mobile = json['mobile'];
    userName = json['userName'];
    fireBaseToken = json['fireBaseToken']??'';
  }

  Map<String, dynamic> toMap()
  {
    return {

      'image':image,
      'isAdmin':isAdmin,
      'mobile':mobile,
      'fireBaseToken':fireBaseToken??'',
      'userName':userName,
    };
  }
}
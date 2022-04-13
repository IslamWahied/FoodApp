// @dart=2.9
class UserModel
{

  String image;
  bool isAdmin;
double currentBalance ;
  String mobile;
  String userName;
  String fireBaseToken;
  int departmentId;
  String createdDate;


  UserModel({

    this.image,
    this.isAdmin,
    this.departmentId,
    this.mobile,
    this.userName,
    this.fireBaseToken,
    this.createdDate,
    this.currentBalance,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {

    image = json['image'];
    isAdmin = json['isAdmin'];
    departmentId = json['departmentId'];
    currentBalance = json['currentBalance'].toDouble();
    mobile = json['mobile'];
    userName = json['userName'];
    fireBaseToken = json['fireBaseToken']??'';
    createdDate = json['createdDate']??'';
  }

  Map<String, dynamic> toMap()
  {
    return {

      'image':image,
      'departmentId':departmentId,
      'currentBalance':currentBalance,
      'isAdmin':isAdmin,
      'mobile':mobile,
      'fireBaseToken':fireBaseToken??'',
      'userName':userName,
      'createdDate':createdDate,
    };
  }
}
// @dart=2.9
class UserModel
{

  String image;
  bool isAdmin;
  bool isActive;
double currentBalance ;
  String mobile;
  String userName;
  String fireBaseToken;
  int departmentId;
  String address;
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
    this.address,
    this.isActive,
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
    address = json['address']??'';
    isActive = json['isActive']??'';
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
      'address':address,
      'createdDate':createdDate,
      'isActive':isActive,
    };
  }
}
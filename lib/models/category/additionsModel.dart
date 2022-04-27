// @dart=2.9

class AdditionsModel {
  String itemTitle;
  int categoryId;
  int itemId;

  int supCategoryId;
  String categoryTitle;
  String description;
  String supCategoryTitle;
  String image;
  dynamic price;
  dynamic oldPrice;
  String createdDate;
  int isDeleted;
  int orderCount;
  bool isAvailable;
  bool isPopular;
  bool isDiscount;
  int projectId;



  AdditionsModel({
    this.itemTitle,
    this.itemId,
    this.categoryId,
    this.supCategoryId,
    this.categoryTitle,
    this.description,
    this.supCategoryTitle,
    this.image,
    this.price,
    this.oldPrice,
    this.createdDate,
    this.isDeleted,
    this.orderCount,
    this.isAvailable,
    this.isPopular,
    this.isDiscount,
    this.projectId
  });

  AdditionsModel.fromJson(Map<String, dynamic> json)
  {
    itemTitle = json['itemTitle'];
    categoryId = json['categoryId'];
    itemId = json['itemId'];
    supCategoryId = json['supCategoryId'];
    categoryTitle = json['categoryTitle'];
    description = json['description']??'';
    supCategoryTitle = json['supCategoryTitle'];
    image = json['image'];
    price = json['price'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
    orderCount = json['orderCount']??0;
    oldPrice = json['oldPrice']??0;
    isAvailable = json['isAvailable']??true;
    isPopular = json['isPopular']??false;
    isDiscount = json['isDiscount']??false;
    projectId = json['projectId']??1;

  }





  Map<String, dynamic> toMap()
  {
    return {

      'itemTitle':itemTitle,
      'categoryId':categoryId,
      'itemId':itemId,
      'supCategoryId':supCategoryId,
      'categoryTitle':categoryTitle,
      'description':description??'',
      'supCategoryTitle':supCategoryTitle,
      'image':image,
      'price':price,
      'createdDate':createdDate,
      'isDeleted':isDeleted,

      'oldPrice':oldPrice??0,
      'orderCount':orderCount??0,
      'isAvailable':isAvailable??true,
      'isPopular':isPopular??false,
      'isDiscount':isDiscount??false,
      'projectId':projectId??1,
    };
  }


}
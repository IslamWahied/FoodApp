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
  double price;
  String createdDate;
  int isDeleted;


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
    this.createdDate,
    this.isDeleted,
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

  }

  AdditionsModel.to(Map<String, dynamic> json)
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
    };
  }


}
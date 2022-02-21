// @dart=2.9
class SubCategory {
  String name;
  int categoryId;
  String categoryName;
  int supCategoryId;
  int isDeleted;
  String createdDate;
  String image;
  SubCategory({this.name,this.categoryId,this.createdDate,this.image,this.isDeleted,this.supCategoryId,this.categoryName});

  SubCategory.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    categoryId = json['categoryId'];
    createdDate = json['createdDate'];
    image = json['image'];
    isDeleted = json['isDeleted'];
    supCategoryId = json['supCategoryId'];
    categoryName = json['categoryName'];

  }

  Map<String, dynamic> toMap()
  {
    return {

      'name':name,
      'categoryId':categoryId,
      'createdDate':createdDate,
      'image':image,
      'isDeleted':isDeleted,
      'supCategoryId':supCategoryId,
      'categoryName':categoryName,


    };
  }


}
// @dart=2.9
class SubCategory {
  String subCategoryTitle;
  int categoryId;
  String categoryTitle;
  int supCategoryId;
  int isDeleted;
  String createdDate;
  String image;
  bool isAvailable;
  SubCategory({this.isAvailable,this.subCategoryTitle,this.categoryId,this.createdDate,this.image,this.isDeleted,this.supCategoryId,this.categoryTitle});

  SubCategory.fromJson(Map<String, dynamic> json)
  {
    subCategoryTitle = json['subCategoryTitle'];
    categoryId = json['categoryId'];
    createdDate = json['createdDate'];
    image = json['image'];
    isDeleted = json['isDeleted'];
    supCategoryId = json['supCategoryId'];
    categoryTitle = json['categoryTitle'];
    isAvailable = json['isAvailable']??true;

  }

  Map<String, dynamic> toMap()
  {
    return {

      'subCategoryTitle':subCategoryTitle,
      'categoryId':categoryId,
      'createdDate':createdDate,
      'image':image,
      'isDeleted':isDeleted,
      'supCategoryId':supCategoryId,
      'categoryTitle':categoryTitle,
      'isAvailable':isAvailable,


    };
  }


}
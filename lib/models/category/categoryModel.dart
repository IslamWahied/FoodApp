// @dart=2.9
class CategoryModel {
  String categoryTitle;
  int categoryId;
  int isDeleted;
  String createdDate;
  String image;
  bool isAvailable;
  int projectId;





  CategoryModel({this.isAvailable,this.categoryTitle,this.categoryId,this.createdDate,this.image,this.isDeleted,this.projectId});

  CategoryModel.fromJson(Map<String, dynamic> json)
  {
    categoryTitle = json['categoryTitle'];
    categoryId = json['categoryId'];
    createdDate = json['createdDate'];
    image = json['image'];
    isDeleted = json['isDeleted'];
    isAvailable = json['isAvailable']??true;
    projectId = json['projectId']??true;
  }

  Map<String, dynamic> toMap()
  {
    return {

      'categoryTitle':categoryTitle,
      'categoryId':categoryId,
      'createdDate':createdDate,
      'image':image,
      'isDeleted':isDeleted,
      'isAvailable':isAvailable??true,
      'projectId':projectId??0

    };
  }


}
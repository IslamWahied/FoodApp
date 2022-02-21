// @dart=2.9
class Category {
  String name;
  int id;
  int isDeleted;
  String createdDate;
  String image;
  Category({this.name,this.id,this.createdDate,this.image,this.isDeleted});

  Category.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    id = json['id'];
    createdDate = json['createdDate'];
    image = json['image'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toMap()
  {
    return {

      'name':name,
      'id':id,
      'createdDate':createdDate,
      'image':image,
      'isDeleted':isDeleted

    };
  }


}
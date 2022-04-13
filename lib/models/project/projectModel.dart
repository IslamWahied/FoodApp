// @dart = 2.9
class Project{

  String name;
  int id;
  String adminMobile;
  String createdDate;
  String image;
  String projectMobile;
  bool isActive;
  Project({
    this.name,
    this.id,
    this.adminMobile,
    this.createdDate,
    this.image,
    this.projectMobile,
    this.isActive,

  });

  Project.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    id = json['id'];
    createdDate = json['createdDate'];
    adminMobile = json['adminMobile'];
    image = json['image'];
    projectMobile = json['projectMobile'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'id':id,
      'createdDate':createdDate,
      'adminMobile':adminMobile,
      'image':image,
      'projectMobile':projectMobile,
      'isActive':isActive,
    };
  }


}
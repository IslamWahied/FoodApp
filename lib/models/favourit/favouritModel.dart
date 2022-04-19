// @dart=2.9
class FavouritModel
{
  String UesrMobile;
  int ItemId;
  bool isFavourit;
  int projectId;



  FavouritModel({
    this.UesrMobile,
    this.ItemId,
    this.isFavourit,
    this.projectId

  });

  FavouritModel.fromJson(Map<String, dynamic> json)
  {
    UesrMobile = json['UesrMobile'];
    ItemId = json['ItemId'];
    isFavourit = json['isFavourit'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'UesrMobile':UesrMobile,
      'ItemId':ItemId,
      'isFavourit':isFavourit,
      'projectId':projectId,
    };
  }
}
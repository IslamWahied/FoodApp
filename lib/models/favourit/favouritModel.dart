// @dart=2.9
class FavouritModel
{
  String UesrMobile;
  int ItemId;
  bool isFavourit;



  FavouritModel({
    this.UesrMobile,
    this.ItemId,
    this.isFavourit,

  });

  FavouritModel.fromJson(Map<String, dynamic> json)
  {
    UesrMobile = json['UesrMobile'];
    ItemId = json['ItemId'];
    isFavourit = json['isFavourit'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'UesrMobile':UesrMobile,
      'ItemId':ItemId,
      'isFavourit':isFavourit,
    };
  }
}
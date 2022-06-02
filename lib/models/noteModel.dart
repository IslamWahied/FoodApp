// @dart=2.9
class NoteModel
{



  String senderMobile;
  String fireBaseToken;
  int projectId;
  String noteText;
  String createdDate;


  NoteModel({

    this.senderMobile,
    this.projectId,
    this.noteText,
    this.fireBaseToken,
    this.createdDate,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
  {

    senderMobile = json['senderMobile'];
    projectId = json['projectId'];
    noteText = json['noteText'];
    fireBaseToken = json['fireBaseToken']??'';
    createdDate = json['createdDate']??'';

  }

  Map<String, dynamic> toMap()
  {
    return {


      'projectId':projectId??'',
      'fireBaseToken':fireBaseToken??'',
      'senderMobile':senderMobile??'',
      'noteText':noteText??'',
      'createdDate':createdDate,

    };
  }
}
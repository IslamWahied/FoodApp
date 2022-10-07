// @dart=2.9
class NoteModel
{



  String senderMobile;
  String senderName;
  String fireBaseToken;
  int projectId;



  String noteText;
  String createdDate;


  NoteModel({

    this.senderMobile,
    this.senderName,

    this.projectId,
    this.noteText,
    this.fireBaseToken,
    this.createdDate,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
  {


    senderMobile = json['senderMobile'];
    senderName = json['senderName'];
    projectId = json['projectId'];
    noteText = json['noteText'];
    fireBaseToken = json['fireBaseToken']??'';
    createdDate = json['createdDate']??'';

  }

  Map<String, dynamic> toMap()
  {
    return {




      'projectId':projectId??'',
      'senderName':senderName??'',
      'fireBaseToken':fireBaseToken??'',
      'senderMobile':senderMobile??'',
      'noteText':noteText??'',
      'createdDate':createdDate,

    };
  }
}
// @dart=2.9
class AllCasesModel {
  dynamic  errorCode;
  String  errorDescription;
  String  technicalError;
  List<Data>  data;
  dynamic  count;

  AllCasesModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  AllCasesModel.fromJson(Map<dynamic, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorDescription'] = this.errorDescription;
    data['technicalError'] = this.technicalError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Data {
  int  complaintId;
  int caseNumber;
  String subject;
  String submitDate;
  String userName;
  String complaintStatus;
  String lastUpdatedTime;
  String lastUpdatedBy;
  String priority;
  int caseSource;
  String customerName;
  List<int> userIds;
  List<int> roleIds;
  List<int> ouIds;
  List<int> userGroupIds;

  Data(
      {this.complaintId,
        this.caseNumber,
        this.subject,
        this.submitDate,
        this.userName,
        this.complaintStatus,
        this.lastUpdatedTime,
        this.lastUpdatedBy,
        this.priority,
        this.caseSource,
        this.customerName,
        this.userIds,
        this.roleIds,
        this.ouIds,
        this.userGroupIds});

  Data.fromJson(Map<String, dynamic> json) {
    complaintId = json['ComplaintId'];
    caseNumber = json['CaseNumber'];
    subject = json['Subject'];
    submitDate = json['SubmitDate'];
    userName = json['UserName'];
    complaintStatus = json['ComplaintStatus'];
    lastUpdatedTime = json['LastUpdatedTime'];
    lastUpdatedBy = json['LastUpdatedBy'];
    priority = json['Priority'];
    caseSource = json['CaseSource'];
    customerName = json['CustomerName'];
    userIds = json['UserIds'].cast<int>();
    roleIds = json['RoleIds'].cast<int>();
    ouIds = json['OuIds'].cast<int>();
    userGroupIds = json['UserGroupIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComplaintId'] = this.complaintId;
    data['CaseNumber'] = this.caseNumber;
    data['Subject'] = this.subject;
    data['SubmitDate'] = this.submitDate;
    data['UserName'] = this.userName;
    data['ComplaintStatus'] = this.complaintStatus;
    data['LastUpdatedTime'] = this.lastUpdatedTime;
    data['LastUpdatedBy'] = this.lastUpdatedBy;
    data['Priority'] = this.priority;
    data['CaseSource'] = this.caseSource;
    data['CustomerName'] = this.customerName;
    data['UserIds'] = this.userIds;
    data['RoleIds'] = this.roleIds;
    data['OuIds'] = this.ouIds;
    data['UserGroupIds'] = this.userGroupIds;
    return data;
  }
}

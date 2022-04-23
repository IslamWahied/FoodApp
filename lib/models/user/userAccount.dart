// @dart=2.9

class UserAccount {
  int orderId;
  int projectId;
  String customerMobile;
  int debit;
  int credit;
  String createdDate;
  String createdByMobile;
  bool isDeleted;

  UserAccount({
    this.orderId,
    this.projectId,
    this.customerMobile,
    this.debit,
    this.credit,
    this.createdDate,
    this.createdByMobile,
    this.isDeleted,
  });

  UserAccount.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    projectId = json['projectId'];
    customerMobile = json['customerMobile'];
    debit = json['debit'];
    credit = json['credit'];
    createdDate = json['createdDate'];
    createdByMobile = json['createdByMobile'] ?? '';
    isDeleted = json['isDeleted'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'projectId': projectId,
      'customerMobile': customerMobile,
      'debit': debit,
      'credit': credit,
      'createdDate': createdDate ?? '',
      'createdByMobile': createdByMobile,
      'isDeleted': isDeleted,
    };
  }
}

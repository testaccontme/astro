class ChatMessageModel {
  int? id;
  String? userId1;
  String? userId2;
  String? message;
  String? url;
  bool? isRead;
  bool? isActive;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? reqAcceptDecline;
  String? invitationAcceptDecline;
  String? messageId;
  bool? isEndMessage;
  String? replymsg;
  String? attachementPath;
  ChatMessageModel({
    this.id,
    this.reqAcceptDecline,
    this.invitationAcceptDecline,
    this.messageId,
    this.userId1,
    this.userId2,
    this.message,
    this.isActive,
    this.url,
    this.isRead,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.isEndMessage,
    this.replymsg,
    this.attachementPath,
  });
  static ChatMessageModel fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
          userId1: '${json['userId1']}',
          userId2: '${json['userId2']}',
          message: json['message'] ?? "",
          isActive: json['isActive'] ?? false,
          isDelete: json['isDelete'],
          url: json['url'] ?? "",
          isRead: json['isRead'] ?? false,
          createdAt: json['createdAt'].toDate(),
          updatedAt: json['updatedAt'].toDate(),
          reqAcceptDecline: json['reqAcceptDecline'],
          messageId: json['messageId'],
          invitationAcceptDecline: json['invitationAcceptDecline'],
          isEndMessage: json['isEndMessage'],
          replymsg: json['replymsg'] ?? "",
          attachementPath: json['attachementPath'] ?? '');
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId1': userId1,
    'userId2': userId2,
    'message': message,
    'isDelete': isDelete,
    'url': url,
    'isRead': isRead,
    'createdAt': createdAt!,
    'updatedAt': updatedAt,
    "reqAcceptDecline": reqAcceptDecline,
    "messageId": messageId,
    "invitationAcceptDecline": invitationAcceptDecline,
    'isEndMessage': isEndMessage,
    "replymsg": replymsg,
    "attachementPath": attachementPath,
  };
  void reset() {
    id = null;
    userId1 = null;
    userId2 = null;
    message = null;
    url = null;
    isRead = null;
    isActive = null;
    isDelete = null;
    createdAt = null;
    updatedAt = null;
    reqAcceptDecline = null;
    invitationAcceptDecline = null;
    messageId = null;
    isEndMessage = null;
    replymsg = null;
    attachementPath = null;
  }
}

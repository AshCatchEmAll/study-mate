class UserDocument {
  UserDocument(
      {
      required this.email,
       required this.school,
      required this.subjects,
      required this.verified,
     required this.uid,
      this.avatar});
  
  final String email;

  final String school;
  final List<String> subjects;
 final String uid;
  final String? avatar;
final bool verified;

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      verified: json["verified"],
      email: json['email'] as String,
      school: json['school'] as String,
      subjects: (json['subjects'] as List<dynamic>).cast<String>(),
    uid:json["uid"]
,      avatar: json['avatar'] as String?,
    );
  }
}

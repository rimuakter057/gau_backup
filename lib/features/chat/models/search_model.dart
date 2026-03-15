class SearchModel {
  String? id;
  String? profileId;
  String? name;
  String? email;
  String? role;
  String? designation;

  SearchModel(
      {this.id,
        this.profileId,
        this.name,
        this.email,
        this.role,
        this.designation});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    profileId = json['profileId'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['profileId'] = profileId;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['designation'] = designation;
    return data;
  }
}

class SearchModel {
  String? sId;
  String? profileId;
  String? name;
  String? email;
  String? role;
  String? designation;

  SearchModel(
      {this.sId,
        this.profileId,
        this.name,
        this.email,
        this.role,
        this.designation});

  SearchModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileId = json['profileId'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileId'] = this.profileId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['designation'] = this.designation;
    return data;
  }
}

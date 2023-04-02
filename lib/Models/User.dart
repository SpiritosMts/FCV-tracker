class UserModel {
  String? Address;
  String? Email;
  String? Name;
  String? PhoneNumber;
  String? Role;
  String? Speciality;
  String? Age;
  String? Sex;
  int? status;

// receiving data
  UserModel(
      {this.Address,
      this.Email,
      this.Name,
      this.PhoneNumber,
      this.Role,
      this.Speciality,
      this.Age,
      this.Sex,
      this.status});
  factory UserModel.fromMap(map) {
    return UserModel(
        Email: map['Email'],
        Address: map['Address'],
        Role: map['Role'],
        Name: map['Name'],
        PhoneNumber: map['PhoneNumber'],
        Speciality: map['Speciality'],
        Age: map['Age'],
        Sex: map['Sex'],
        status: map["Status"]);
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'Email': Email,
      'Address': Address,
      'Role': Role,
      'Name': Name,
      'PhoneNumber': PhoneNumber,
      'Speciality': Speciality,
      'Age': Age,
      'Sex': Sex,
      'Status': status,
    };
  }
}

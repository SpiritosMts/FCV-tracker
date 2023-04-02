

class FcUser {

  String? id;
  String? email;
  String? name ;
  String? pwd;
  String? sex;
  String? joinDate;
  bool? hasPatients;
  String? role;
  String? number;
  String? address;
  String? age;
  String? speciality;
  Map<String,dynamic> health;
  Map<String,dynamic> appointments;
  Map<String,dynamic> notifications;
  String? doctor;
  bool verified;
  List? patients;




  FcUser({
    this.id = '',
    this.email = 'no-email',
    this.pwd  = 'no-pwd',
    this.name = 'no-name',
    this.joinDate = 'no-join',
    this.hasPatients = false,
    this.role = 'patient',
    this.number = '',
    this.sex = '',
    this.age = '',
    this.health = const {} ,
    this.appointments = const {} ,
    this.notifications = const {} ,
    this.speciality = '',
    this.doctor = '',
    this.address = '',
    this.verified = false,
    this.patients = const [],
  });
}


FcUser FcUserFromMap(userDoc){

  FcUser user =FcUser();



  user.email = userDoc.get('email');
  user.name = userDoc.get('name');
  user.id = userDoc.get('id');
  user.doctor = userDoc.get('doctor');
  user.number = userDoc.get('number');
  user.pwd = userDoc.get('pwd');
  user.age = userDoc.get('age');
  user.sex = userDoc.get('sex');
  user.address = userDoc.get('address');
  user.health = userDoc.get('health');
  user.speciality = userDoc.get('speciality');
  user.role = userDoc.get('role');
  user.verified = userDoc.get('verified');
  user.joinDate = userDoc.get('joinDate');
  user.patients = userDoc.get('patients');
  user.appointments = userDoc.get('appointments');
  user.notifications = userDoc.get('notifications');
  user.hasPatients = user.patients!.isNotEmpty;

  return user;
}

printUser(FcUser user){
  print(
      '#### USER ####'
      'id: ${user.id} \n'
      'role: ${user.role} \n'
      'doctor: ${user.doctor} \n'
      'email: ${user.email} \n'
      'name: ${user.name} \n'
      'pwd: ${user.pwd} \n'
      'number: ${user.number} \n'
      'age: ${user.age} \n'
      'sex: ${user.sex} \n'
      'health: ${user.health} \n'
      'speciality: ${user.speciality} \n'
      'verified: ${user.verified} \n'
      'joinDate: ${user.joinDate} \n'
      'patients: ${user.patients} \n'
      'notifications: ${user.notifications} \n'
      'appointments: ${user.appointments} \n'
      'hasPatients: ${user.hasPatients} \n'
      );
}
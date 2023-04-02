
import 'package:fcv_trucker/Screens/chat/chatRoomCtr.dart';
import 'package:fcv_trucker/Screens/patientList.dat/AllPatientsCtr.dart';
import 'package:fcv_trucker/fireBaseAuth.dart';
import 'package:get/get.dart';

class GetxBinding implements Bindings {
  @override
  void dependencies() {


    ///auth
    Get.put(AuthController());
    Get.lazyPut<AllPatientsCtr>(() => AllPatientsCtr(),fenix: true);
    Get.lazyPut<ChatRoomCtr>(() => ChatRoomCtr(),fenix: true);

    print('## getx dependency injection completed');

  }
}
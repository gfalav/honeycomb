import 'package:get/get.dart';

class UserDataController extends GetxController {
  final firstName = "".obs;
  final lastName = "".obs;
  final urlPhoto = "".obs;
  final phoneNumber = "".obs;
  final address = "".obs;
  final city = "".obs;
  final rrss = <Map<String, String>>[].obs;
  final GMT = "-3 GMT".obs;
  final workingDays = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'].obs;
  final title = "".obs;
  final skils = <String>[].obs;
}

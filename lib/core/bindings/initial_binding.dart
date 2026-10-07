import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Global services and controllers initialized at app start with fenix: true
    // so they are never "dead" upon screen transitions
  }
}

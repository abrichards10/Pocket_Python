import 'package:get_it/get_it.dart';
import 'package:test_project/commons/permissions_handler.dart';
import 'package:test_project/commons/permissions_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<PermissionService>(
      PermissionHandlerPermissionService());
}

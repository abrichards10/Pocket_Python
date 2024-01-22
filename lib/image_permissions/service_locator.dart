import 'package:get_it/get_it.dart';
import 'package:test_project/image_permissions/media_service.dart';
import 'package:test_project/image_permissions/permissions_handler.dart';
import 'package:test_project/image_permissions/permissions_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<PermissionService>(
      PermissionHandlerPermissionService());
  getIt.registerSingleton<MediaServiceInterface>;
  print("registered");
}

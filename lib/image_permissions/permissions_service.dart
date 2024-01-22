import 'package:flutter/material.dart';

abstract class PermissionService {
  // TODO: MOVE>>>
  Future requestPhotosPermission();

  Future<bool> handlePhotosPermission(BuildContext context);

  Future requestCameraPermission();

  Future<bool> handleCameraPermission(BuildContext context);
}

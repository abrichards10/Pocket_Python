// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_project/commons/app_alert_dialog.dart';
import 'package:test_project/commons/permissions_service.dart';

class PermissionHandlerPermissionService implements PermissionService {
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      print(
          '😰 😰 😰 😰 😰 😰 Permission to camera was not granted! 😰 😰 😰 😰 😰 😰');
      await showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          onConfirm: () => openAppSettings(),
          title: 'Camera Permission',
          subtitle:
              'Camera permission should Be granted to use this feature, would you like to go to app settings to give camera permission?',
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      print(
          '😰 😰 😰 😰 😰 😰 Permission to photos not granted! 😰 😰 😰 😰 😰 😰');
      await showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          onConfirm: () => openAppSettings(),
          title: 'Photos Permission',
          subtitle:
              'Photos permission should Be granted to use this feature, would you like to go to app settings to give photos permission?',
        ),
      );
      return false;
    }
    return true;
  }
}

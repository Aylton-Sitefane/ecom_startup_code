import 'package:admin/models/api_response.dart';
import 'package:admin/models/my_notification.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:get/get.dart';

import '../../../models/notification_result.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../services/http_services.dart';


class NotificationProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final sendNotificationFormKey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController imageUrlCtrl = TextEditingController();

  NotificationResult? notificationResult;

  NotificationProvider(this._dataProvider);


  sendNotification() async {
    try {
      Map<String, dynamic> notifications = {
        "title": titleCtrl.text,
        "description": descriptionCtrl.text,
        "imageUrl": imageUrlCtrl.text
      };
      final response = await service.addItem(endpointUrl: 'notification/send-notification', itemData: notifications);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllNotifications();
        } else {
          SnackBarHelper.showErrorSnackBar('Falha ao enviar notificacao ${apiResponse.message}');
        }
      }else{
          SnackBarHelper.showErrorSnackBar('Error ${response.body}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Erro $e');
      rethrow;
    }
  }


  deleteNotification(MyNotification notification) async {
    try {
      Response response = await service.deleteItem(endpointUrl: 'notification/delete-notification', itemId: notification.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Notificacao deletada com sucesso!');
          _dataProvider.getAllNotifications();
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Erro ${response.body}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  //TODO: should complete getNotificationInfo

  clearFields() {
    titleCtrl.clear();
    descriptionCtrl.clear();
    imageUrlCtrl.clear();
  }

  updateUI() {
    notifyListeners();
  }
}

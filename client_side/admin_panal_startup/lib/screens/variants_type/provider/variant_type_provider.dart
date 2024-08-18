import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;

  VariantsTypeProvider(this._dataProvider);

  addVariantType() async {
    try {
      Map<String, dynamic> variantType = {
        'name': variantNameCtrl.text,
        'type': variantTypeCtrl.text
      };
      final response = await service.addItem(endpointUrl: 'variantTypes', itemData: variantType);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('Variant Type added sucessfully');
          _dataProvider.getAllVariantType();
        } else {
          SnackBarHelper.showErrorSnackBar('An error occoured ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
    }
  }

  updateVariantType() async {
    try {
      if (variantTypeForUpdate != null) {
        Map<String, dynamic> variantType = {
          'name': variantNameCtrl.text,
          'type': variantTypeCtrl.text
        };
      final response = await service.updateItem(endpointUrl: 'variantTypes', itemId: variantTypeForUpdate?.sId ?? '', itemData: variantType);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Variant type updated succesfully');
          _dataProvider.getAllVariantType();
        } else {
          SnackBarHelper.showErrorSnackBar('Error occoured ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.statusText}');
      }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
      rethrow;
    }
  }

  submitVariantType() {
    if (variantTypeForUpdate != null) {
      updateVariantType();
    } else {
      addVariantType();
    }

  }

  deleteVariantType(VariantType variantType) async{
    try {
      Response response = await service.deleteItem(endpointUrl: 'variantTypes', itemId: variantType?.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Variant type deleted succesfully');
          _dataProvider.getAllVariantType();
        }else{
          SnackBarHelper.showErrorSnackBar('An error occoured ${apiResponse.message}');
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
      rethrow;
    }
  }

  setDataForUpdateVariantTYpe(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}

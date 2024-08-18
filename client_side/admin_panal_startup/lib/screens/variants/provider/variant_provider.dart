import '../../../models/variant_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addVariantsFormKey = GlobalKey<FormState>();
  TextEditingController variantCtrl = TextEditingController();
  VariantType? selectedVariantType;
  Variant? variantForUpdate;




  VariantsProvider(this._dataProvider);


  addVariant() async{
    try {
      Map<String, dynamic> variant = {
        'name': variantCtrl.text,
        'variantTypeId': selectedVariantType?.sId
      };
      final response = await service.addItem(endpointUrl: 'variants', itemData: variant);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('Variant added succesfully');
          _dataProvider.getAllVariants();

        } else {
          SnackBarHelper.showErrorSnackBar('An error occured ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('An error ocurred ${response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
      rethrow;
    }
  }


  updateVariant() async {
    try {
      if (variantForUpdate != null) {
        Map<String, dynamic> variant = {
          'name': variantCtrl.text,
          'variantTypeId': selectedVariantType?.sId
        };
        final response = await service.updateItem(endpointUrl: 'variants', itemId: variantForUpdate?.sId ?? '', itemData: variant);
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            SnackBarHelper.showSuccessSnackBar('Success ${apiResponse.message}');
            _dataProvider.getAllVariants();
            clearFields();
          } else {
            SnackBarHelper.showErrorSnackBar('Error ${apiResponse.message}');
          }
        }else{
          SnackBarHelper.showErrorSnackBar('Error saving ${response.statusText}');
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
    }
  }


  submitVariant(){
    if (variantForUpdate!= null) {
      updateVariant();
    } else {
      addVariant();
    }
  }



  deleteVariant(Variant variant) async {
    try {
      Response response = await service.deleteItem(endpointUrl: 'variants', itemId: variant.sId?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Variant added succesfully');
          _dataProvider.getAllVariants();
        } else {
          SnackBarHelper.showErrorSnackBar('An error occured saving the variant ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ocurred with the api ${response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
      rethrow;
    }
  }


  setDataForUpdateVariant(Variant? variant) {
    if (variant != null) {
      variantForUpdate = variant;
      variantCtrl.text = variant.name ?? '';
      selectedVariantType =
          _dataProvider.variantTypes.firstWhereOrNull((element) => element.sId == variant.variantTypeId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantCtrl.clear();
    selectedVariantType = null;
    variantForUpdate = null;
  }

  void updateUI() {
    notifyListeners();
  }
}

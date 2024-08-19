import '../../models/api_response.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import '../../utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getALlProduct();
    getAllCategory();
    getAllSubCategory();
    getAllBrands();
    getAllVariantType();
    getAllVariants();
    getAllPosters();
    getAllCoupons();
    getAllOrders();
    getAllNotifications();
  }

//categories
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Category.fromJson(item))
                    .toList());
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
        rethrow;
      }
    }
    return _filteredCategories;
  }

  void filterCategories(String keyWord) {
    if (keyWord.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyWord = keyWord.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyWord);
      }).toList();
    }
    notifyListeners();
  }

  //gSubCategory
  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'subCategories');
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => SubCategory.fromJson(item))
                    .toList());

        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories = List.from(
            _allSubCategories); // intilialize filtered list with all data
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
    }
    return _filteredSubCategories;
  }

  void filterSubCategories(String keyWord) {
    if (keyWord.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyWord = keyWord.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        return (subCategory.name ?? '').toLowerCase().contains(lowerKeyWord);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Brand.fromJson(item))
                    .toList());
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
    }
    return _filteredBrands;
  }

  void filterBrands(String keyWord) {
    if (keyWord.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyWord = keyWord.toLowerCase();
      _filteredBrands = _allBrands.where((brands) {
        return (brands.name ?? '').toLowerCase().contains(lowerKeyWord);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<VariantType>> getAllVariantType({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variantTypes');
      if (response.isOk) {
        ApiResponse<List<VariantType>> apiResponse =
            await ApiResponse<List<VariantType>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => VariantType.fromJson(item))
                    .toList());
        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes = List.from(_allVariantTypes);
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('$e');
      }
    }
    return _filteredVariantTypes;
  }

  void filteredVariantTypes(String keyWord) {
    if (keyWord.isEmpty) {
      _filteredVariantTypes = List.from(_allVariantTypes);
    } else {
      final lowerKeyWord = keyWord.toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((variantTypes) {
        return (variantTypes.name ?? '').toLowerCase().contains(lowerKeyWord);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Variant>> getAllVariants({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variants');
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            await ApiResponse<List<Variant>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Variant.fromJson(item))
                    .toList());
        _allVariants = apiResponse.data ?? [];
        _filteredVariants = List.from(_allVariants);
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('$e');
      }
    }
    return _filteredVariants;
  }

  void filteredVariants(String key) {
    if (key.isEmpty) {
      _filteredVariants = List.from(_allVariants);
    } else {
      final lowerKeyWord = key.toLowerCase();
      _filteredVariants = _allVariants.where((variants) {
        return (variants.name ?? '').toLowerCase().contains(lowerKeyWord);
      }).toList();
    }
  }

  Future<void> getALlProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      ApiResponse<List<Product>> apiResponse =
          ApiResponse<List<Product>>.fromJson(
        response.body,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );
      _allProducts = apiResponse.data ?? [];
      _filteredProducts = List.from(_allProducts);
      notifyListeners();
      if (showSnack) {
        SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('$e');
        rethrow;
      }
    }
  }

  void filteredProduct(String keyWord){
    if (keyWord.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    }else{
      final lowerKeyword = keyWord.toLowerCase();

      _filteredProducts = _allProducts.where((products) {
        final productNameContainKeyword = (products.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryNameContainKeyword = products.proCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;
        final subCategoryContainKeyword = products.proSubCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;

        return productNameContainKeyword || categoryNameContainKeyword || subCategoryContainKeyword;
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Coupon>> getAllCoupons({bool showSnack = false}) async{
    try {
      Response response = await service.getItems(endpointUrl: 'couponCodes');
      ApiResponse<List<Coupon>> apiResponse =
          ApiResponse<List<Coupon>>.fromJson(
        response.body,
        (json) => (json as List).map((item) => Coupon.fromJson(item)).toList(),
      );
      _allCoupons = apiResponse.data ?? [];
      _filteredCoupons = List.from(_allCoupons);
      notifyListeners();
      if (showSnack) {
        SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('$e');
        rethrow;
      }
    }
    return _filteredCoupons;
  }


  void filteredCoupons(String val){
    if (val.isEmpty) {
      _filteredPosters = List.from(_allPosters);

    } else {
      final lowerKeyword = val.toLowerCase();
      _filteredCoupons = _allCoupons.where((coupon) {
        return (coupon.couponCode ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Poster>> getAllPosters({bool showSnack = false}) async{
    try {
      Response response = await service.getItems(endpointUrl: 'posters');
      ApiResponse<List<Poster>> apiResponse =
          ApiResponse<List<Poster>>.fromJson(
        response.body,
        (json) => (json as List).map((item) => Poster.fromJson(item)).toList(),
      );
      _allPosters = apiResponse.data ?? [];
      _filteredPosters = List.from(_allPosters);
      notifyListeners();
      if (showSnack) {
        SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar('$e');
        rethrow;
      }
    }
    return _filteredPosters;
  }

  void filteredPosters(String val){
    if (val.isEmpty) {
      _filteredPosters = List.from(_allPosters);

    } else {
      final lowerKeyword = val.toLowerCase();
      _filteredPosters = _allPosters.where((posters) {
        return (posters.posterName ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  

  Future<List<Order>> getAllOrders({bool showSnack= false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'orders');
      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse = ApiResponse<List<Order>>.fromJson(response.body, (json) => (json as List).map((item) => Order.fromJson(item)).toList(),);
        print(apiResponse.message);
        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else{
        SnackBarHelper.showErrorSnackBar('Problemas com a Api ${response.status}');
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredOrders;
  }

  void filteredOrders(String keyWord){
    if (keyWord.isEmpty) {
      _filteredOrders = List.from(_allOrders);
    } else {
      final lowerKeyword = keyWord.toLowerCase();
      _filteredOrders = _allOrders.where((order) {
        bool nameMatches = (order.userID?.name ?? '').toLowerCase().contains(lowerKeyword);
        bool statusMatches = (order.orderStatus ?? '').toLowerCase().contains(lowerKeyword);
        return nameMatches || statusMatches;
      }).toList();
    }
    notifyListeners();
  }

  int calculateOrdersWithStatus({String? status}) {
    int totalOrders = 0;
    if (status == null) {
      totalOrders = _allOrders.length;
    } else {
      for (Order order in _allOrders) {
        if (order.orderStatus == status) {
          totalOrders +=1;
        }
      }
    }

    return totalOrders;
  }

  void filterProductByQuantity(String prodQunatType){
    if (prodQunatType == 'All Product') {
      _filteredProducts = List.from(_allProducts);
    }else if(prodQunatType == 'Out of Stock'){
      _filteredProducts = _allProducts.where((products) {
        return products.quantity != null && products.quantity == 0;
      }).toList();
    }else if(prodQunatType == 'Limited Stock') {
      _filteredProducts = _allProducts.where((products) {
        return products.quantity != null && products.quantity == 1;
      }).toList();
    }else if(prodQunatType == 'Other Stock') {
      _filteredProducts = _allProducts.where((products) {
        return products.quantity != null && products.quantity != 0 && products.quantity != 1;
      }).toList();
    }else{
      _filteredProducts = List.from(_allProducts);
    }
    notifyListeners();
  }

  int calculateProductWithQuantity(int? quantity){
    int totalProduct = 0;
    if (quantity == null) {
      totalProduct =_allProducts.length;
    } else {
      for (Product product in _allProducts) {
        if (product.quantity != null && product.quantity == quantity) {
          totalProduct +=1;
        }
      }
    }
    return totalProduct;
  }

  Future<List<MyNotification>> getAllNotifications({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'notification/all-notification');
      if (response.isOk) {
        ApiResponse<List<MyNotification>> apiResponse = ApiResponse<List<MyNotification>>.fromJson(response.body, (json) => (json as List).map((item) => MyNotification.fromJson(item)).toList(),);
        _allNotifications = apiResponse.data ?? [];
        _filteredNotifications = List.from(_allNotifications);
        notifyListeners();
        if(showSnack) SnackBarHelper.showErrorSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
    }

    return _filteredNotifications;
  }

  void filteredNotifications(String val) {
    if (val.isEmpty) {
      _filteredNotifications = List.from(_allNotifications);
    } else {
      final lowerWord = val.toLowerCase();
      _filteredNotifications = _allNotifications.where((notification) {
        return (notification.title ?? '').toLowerCase().contains(lowerWord);
      }).toList();
    }
    notifyListeners();
  }
  
}

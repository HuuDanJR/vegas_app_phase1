import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/models/request/cart_request.dart';
import 'package:vegas_club/models/request/order_request.dart';
import 'package:vegas_club/models/response/cart_detail_response.dart';
import 'package:vegas_club/models/response/cart_response.dart';
import 'package:vegas_club/models/response/order_response.dart';
import 'package:vegas_club/models/response/product_category_response.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.widget.dart';

class FoodReservationViewmodel extends ChangeNotifier with BaseFunction {
  List<ProductResponse> listProduct = [];
  List<ProductResponse> listProductByQrCode = [];
  List<CartDetailResponse> listCartDetail = [];
  var repo = Repository();

  int? quantity = 0;
  bool? isCheckAll = true;
  int totalAllPoint = 0;
  bool isCartItemExist = false;
  int? mbsPoint = 0;
  int? indexCategorySelected = 0;
  int categoryId = -1;
  List<ProductCategoryResponse> listCategory = [];

  Future<void> initData() async {
    try {
// await getAllProduct(0);
      listCategory = [];
      listProductByQrCode = [];
      listProduct = [];
      notifyListeners();
      await getListCartDetail(0);
      await getAllCategory();
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
  }

  Future<void> setIndexCategory(
      int index, int categoryIdTmp, int productType, String search) async {
    try {
      indexCategorySelected = index;
      categoryId = categoryIdTmp;
      listProduct = [];
      String? customerLevel = await boxCustomer!.get(customerLevelKey);
      List<ProductResponse> response = await repo.getProductByCategoryId(
          categoryId,
          customerLevel!,
          productType,
          "attachment.product_category",
          search,
          0);
      if (response.isNotEmpty) {
        listProduct.addAll(response);
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getAllProductByCategoryId(int offset, String search) async {
    try {
      if (offset == 0) {
        listProduct = [];
      }
      String? customerLevel = await boxCustomer!.get(customerLevelKey);

      List<ProductResponse> response = await repo.getProductByCategoryId(
          categoryId,
          customerLevel!,
          categoryId,
          "attachment.product_category",
          search,
          offset);
      if (response.isNotEmpty) {
        listProduct.addAll(response);
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getAllCategory() async {
    try {
      String? levelKey = await boxCustomer!.get(customerLevelKey);

      List<ProductCategoryResponse> response =
          await repo.getAllCategoryProduct();
      if (response.isNotEmpty) {
        if (levelKey == "P") {
          listCategory = response
              .where((element) =>
                  element.name == "Snack Menu" || element.name == "Beverage")
              .toList();
          print(listCategory);
        } else if (levelKey == "V" || levelKey == "ONE" || levelKey == "ONE+") {
          listCategory = response;
        } else if (levelKey == "I") {
          listCategory = response
              .where((element) =>
                  element.name == "Snack Menu" ||
                  element.name == "Beverage" ||
                  element.name == "Chinese" ||
                  element.name == "Korea")
              .toList();
        }
        if (listCategory.isNotEmpty) {
          categoryId = listCategory.first.id!;
          setIndexCategory(0, categoryId, 1, "");
        }

        getAllProductByCategoryId(0, "");
        // listCategory = response;
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getProductByCategory() async {
    // List<ProductResponse> response = await repo.getProductByCategoryId(
    //     categoryId, customerLevel, productType);
  }

  Future<void> initDataDetail() async {
    int quantityTmp = 1;
    quantity = quantityTmp;
    notifyListeners();
  }

  Future<void> getListCartDetail(int offset) async {
    try {
      if (offset == 0) {
        listCartDetail = [];
      }
      await getMembershipPoint();

      getTotalPointPrice();
      int? userId = await ProfileUser.getCurrentCustomerId();

      List<CartDetailResponse> response = await repo.getCart(userId, offset);

      if (response.isNotEmpty) {
        for (var itemProduct in response) {
          itemProduct.totalPoint =
              itemProduct.quantity! * itemProduct.product!.pointPrice!;
        }
        listCartDetail.addAll(response);
      }
      getTotalPointPrice();
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getAllProduct(int offset, {String? search}) async {
    List<ProductResponse> response = [];
    if (offset == 0) {
      listProduct = [];
    }
    response = await repo.getProduct(
        search, null, "attachment.product_category", offset);

    // await fetch(() async {
    //   response = await repo.getProduct(
    //       search, null, "attachment.product_category", offset);
    // });
    if (response.isNotEmpty) {
      listProduct.addAll(response);
    }
    await getListCartDetail(0);

    notifyListeners();
  }

  Future<void> getProductByQrCode({String? qrCode}) async {
    List<ProductResponse> response = [];
    await fetch(() async {
      response =
          await repo.getProduct(null, qrCode, "attachment.product_category", 0);
    });
    listProductByQrCode = response;
    if (listProductByQrCode.isNotEmpty) {
      pushNamed(ProductDetailWidget.route,
          arguments: listProductByQrCode.first);
    } else {
      showAlertDialog(
          title: "We do not have this product!",
          typeDialog: TypeDialog.warning);
    }
    notifyListeners();
  }

  Future<void> setQuantityInCart(bool isIncrease, int indexItem) async {
    int quantityTmp = listCartDetail[indexItem].quantity!;
    int idCart = listCartDetail[indexItem].id!;
    if (isIncrease) {
      quantityTmp = quantityTmp + 1;
    } else {
      quantityTmp = quantityTmp - 1;
    }
    if (quantityTmp == 0) {
      listCartDetail.removeAt(indexItem);
    } else {
      listCartDetail[indexItem].quantity = quantityTmp;
    }
    if (quantityTmp > 0) {
      listCartDetail[indexItem].totalPoint =
          listCartDetail[indexItem].quantity! *
              listCartDetail[indexItem].product!.pointPrice!;
    }
    getTotalPointPrice();

    await updateCart(quantityTmp, idCart);

    notifyListeners();
  }

  Future<void> increaseQuantity(int indexProduct) async {
    if ((listProduct[indexProduct].quantity ?? 1) > 0) {
      listProduct[indexProduct].quantity =
          (listProduct[indexProduct].quantity ?? 0) + 1;
    }

    notifyListeners();
  }

  Future<void> decreaseQuantity(int indexProduct) async {
    if ((listProduct[indexProduct].quantity ?? 1) > 0) {
      listProduct[indexProduct].quantity =
          listProduct[indexProduct].quantity! - 1;
    }

    notifyListeners();
  }

  Future<void> setQuantityInDetail(bool isIncrease) async {
    if (isIncrease) {
      quantity = quantity! + 1;
    } else {
      if (quantity! > 0) {
        quantity = quantity! - 1;
      }
    }
    notifyListeners();
  }

  Future<void> updateCart(int quantity, int idCart) async {
    CartResponse? response;
    await fetch(() async {
      response = await repo.updateCart({"quantity": quantity}, idCart);
    });
    listCartDetail.map((element) {
      if (element.id == response?.id) {
        element.quantity = response?.quantity;
      }
    });

    notifyListeners();
  }

  Future<void> addProductToCart(BuildContext context, int productId,
      {VoidCallback? callBack}) async {
    int? userId = await ProfileUser.getCurrentCustomerId();
    CartRequest cartRequest = CartRequest(
        customerId: userId, quantity: quantity, productId: productId);
    CartResponse? response;
    await fetch(() async {
      response = await repo.postCart(cartRequest.toJson());
    });

    if (response?.id != null) {
      isCartItemExist = true;
      showSnackBar(context, 'Added product to cart!');

      if (callBack != null) {
        callBack();
      }
    }
    await getListCartDetail(0);
    notifyListeners();
  }

  Future<void> addSingleProductToCart(
      BuildContext context, int productId, int quantity,
      {VoidCallback? callBack}) async {
    int? userId = await ProfileUser.getCurrentCustomerId();
    CartRequest cartRequest = CartRequest(
        customerId: userId, quantity: quantity, productId: productId);
    CartResponse? response;
    await fetch(() async {
      response = await repo.postCart(cartRequest.toJson());
    });

    if (response?.id != null) {
      isCartItemExist = true;
      showSnackBar(context, 'Added product to cart!');

      if (callBack != null) {
        callBack();
      }
    }
    await getListCartDetail(0);
    notifyListeners();
  }

  void unCheckItem(int index) {
    listCartDetail[index].isChecked = !listCartDetail[index].isChecked!;

    var listChecked =
        listCartDetail.where((e) => e.isChecked == false).toList();
    if (listChecked.isNotEmpty) {
      isCheckAll = false;
    } else {
      isCheckAll = true;
    }
    getTotalPointPrice();
    notifyListeners();
  }

  void clearListCheked(bool val) {
    isCheckAll = val;
    listCartDetail.map((e) => e.isChecked = val).toList();
    getTotalPointPrice();
    notifyListeners();
  }

  void getTotalPointPrice() {
    int sumPrice = 0;
    listCartDetail.map((e) {
      if (e.isChecked == true) {
        sumPrice += e.totalPoint!;
      }
    }).toList();
    totalAllPoint = sumPrice;
    notifyListeners();
  }

  Future<void> checkoutCart({VoidCallback? callback}) async {
    pop();
    int? userId = await ProfileUser.getCurrentCustomerId();

    List<ListOrderRequest> listOrder = [];

    listCartDetail.map((e) {
      if (e.isChecked == true) {
        listOrder.add(ListOrderRequest(e.id));
      }
    }).toList();
    if (listOrder.isNotEmpty) {
      OrderResponse? response;

      await fetch(() async {
        response = await repo.createOrder(
            OrderRequest(customerId: userId, listIdCart: listOrder, status: 1)
                .toJson());
      });
      if (response?.id != null) {
        if (callback != null) {
          callback();
        }
      }
    }
  }

  Future<void> getMembershipPoint() async {
    int customerId = await ProfileUser.getCurrentCustomerId();
    var memberShipPointResponseTmp = await repo.getMembershipPoint(customerId);
    if (memberShipPointResponseTmp != null) {
      mbsPoint = memberShipPointResponseTmp.loyaltyPointCurrent;
    }
    notifyListeners();
  }
}

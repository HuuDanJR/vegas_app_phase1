import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/view_model/food_reservation.viewmodel.dart';

class ProductDetailWidget extends StateFullConsumer {
  const ProductDetailWidget({Key? key, this.productResponse}) : super(key: key);
  final ProductResponse? productResponse;
  static const String route = "./productDetail";
  @override
  StateConsumer<ProductDetailWidget> createState() =>
      _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends StateConsumer<ProductDetailWidget> {
  ProductResponse? _productResponse;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _quantity = 0;
  @override
  void initStateWidget() {
    _productResponse = widget.productResponse;
    Provider.of<FoodReservationViewmodel>(context, listen: false)
        .initDataDetail();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Consumer<FoodReservationViewmodel>(
      builder: (BuildContext context, FoodReservationViewmodel model,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            actions: const [],
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 350.0,
                width: width(context),
                child: SizedBox(
                  child: Hero(
                    tag: _productResponse!.id.toString(),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          Utils.getImageFromId(_productResponse!.attachmentId!),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.grey.shade300,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _productResponse!.name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${_productResponse!.pointPrice!.toDecimal()} point",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      const Expanded(child: SizedBox()),
                      // Row(
                      //   children: [
                      //     quantityButton(model),
                      //     SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     Expanded(
                      //         child: addToCartButton(
                      //             model: model,
                      //             onTap: model.quantity == 0
                      //                 ? null
                      //                 : () {
                      //                     Provider.of<FoodReservationViewmodel>(
                      //                             context,
                      //                             listen: false)
                      //                         .addProductToCart(context,
                      //                             widget.productResponse!.id!,
                      //                             callBack: () {
                      //                       pop();
                      //                     });
                      //                   }))
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // floatingActionButton: Padding(
          //   padding: EdgeInsets.only(bottom: 70.0),
          //   child: FloatingActionButton(
          //     backgroundColor: ColorName.primary,
          //     onPressed: () {
          //       pushNamed(CartScreen.route);
          //     },
          //     child: shoppingBag(model.listCartDetail.length),
          //   ),
          // ),
        );
      },
    );
  }

  Widget quantityButton(FoodReservationViewmodel model) {
    return Container(
      width: 100,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            onTap: () {
              model.setQuantityInDetail(true);
            },
            child: const Icon(Icons.add)),
        Text(model.quantity.toString()),
        InkWell(
            onTap: () {
              model.setQuantityInDetail(false);
            },
            child: const Icon(Icons.remove)),
      ]),
    );
  }

  Widget addToCartButton(
      {FoodReservationViewmodel? model, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: model!.quantity == 0 ? Colors.grey : ColorName.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: const Center(
            child: Text(
          'Add to cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}

Widget shoppingBag({void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Stack(
            children: [
              Image.asset(
                Assets.icons_ic_mycart.path,
                width: 22,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

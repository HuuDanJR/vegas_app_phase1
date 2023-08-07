import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vegas_club/base/base_state_widget.dart';

import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/product_category_response.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/share_widget/input_field.widget.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/cart.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.widget.dart';
import 'package:vegas_club/ui/view/qr-scanner-view/qr_scanner.screen.dart';
import 'package:vegas_club/view_model/food_reservation.viewmodel.dart';

class FoodReservationScreen extends StateFullConsumer {
  const FoodReservationScreen({Key? key}) : super(key: key);

  static const String route = "./foodReservationScreen";
  @override
  StateConsumer<FoodReservationScreen> createState() =>
      _FoodReservationScreenState();
}

class _FoodReservationScreenState extends StateConsumer<FoodReservationScreen>
    with BaseFunction {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  FocusNode? _focusNode;

  final _debouncer = Debounce(milliseconds: 200);

  @override
  void initStateWidget() {
    _focusNode = FocusNode();
    Provider.of<FoodReservationViewmodel>(context, listen: false).initData();
  }

  @override
  void disposeWidget() {
    _focusNode!.unfocus();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Consumer<FoodReservationViewmodel>(
        builder: (BuildContext context, FoodReservationViewmodel model,
            Widget? child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: ColorName.primary2,
              title: const Text(
                "Food Order",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  onChanged: (val) {
                                    _debouncer.run(() {
                                      model.getAllProductByCategoryId(0, val);
                                    });
                                  },
                                  focusNode: _focusNode,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      pushNamed(QrScannerScreen.route);
                                    },
                                    child: const SizedBox(
                                      width: 65,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.qr_code_scanner,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  suffixIconColor: Colors.black,
                                  hintText: "Enter name product...",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _tabCategory(
                          model.listCategory, model.indexCategorySelected!),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: BaseSmartRefress(
                          refreshController: _refreshController,
                          onLoading: () {
                            model.getAllProductByCategoryId(
                                model.listProduct.length, "");
                            _refreshController.loadComplete();
                          },
                          onRefresh: () {
                            model.getAllProductByCategoryId(0, "");
                            _refreshController.refreshCompleted();
                          },
                          child: ListView.builder(
                            itemCount: model.listProduct.length,
                            // padding: EdgeInsets.only(top: 16.0),
                            itemBuilder: (context, index) {
                              return _itemProduct(
                                  model.listProduct[index], index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 45,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        pushNamed(CartScreen.route);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 16.0, vertical: 8),
                          //   decoration: BoxDecoration(
                          //       color: ColorName.yellowBrown,
                          //       borderRadius: BorderRadius.circular(6)),
                          //   child: Row(
                          //     children: [
                          //       shoppingBag(),
                          //       SizedBox(
                          //         width: 4.0,
                          //       ),
                          //       Text(
                          //         "My cart",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Visibility(
                            visible: model.listCartDetail.isNotEmpty,
                            child: Positioned(
                              right: -4,
                              top: -3,
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //   backgroundColor: ColorName.primary,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 10.0),
            //     child: shoppingBag(
            //       model.listCartDetail.length,
            //     ),
            //   ),
            //   onPressed: () {
            //     pushNamed(CartScreen.route).then((value) {
            //       model.getListCartDetail(0);
            //     });
            //   },
            // ),
          );
        },
      ),
    );
  }

  Widget _tabCategory(List<ProductCategoryResponse> list, int indexSelected) {
    return SizedBox(
      width: width(context),
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 0),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<FoodReservationViewmodel>(context, listen: false)
                  .setIndexCategory(
                      index, list[index].id!, list[index].id!, "");
            },
            child: Center(
              child: Container(
                height: 22.0,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: index == indexSelected
                        ? ColorName.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: index == indexSelected
                            ? ColorName.primary
                            : Colors.black,
                        width: 0.8)),
                child: Center(
                    child: Text(
                  list[index].name ?? '',
                  style: TextStyle(
                      color:
                          index == indexSelected ? Colors.white : Colors.black),
                )),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10.0);
        },
      ),
    );
  }

  Widget _itemProduct(ProductResponse productResponse, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Hero(
        tag: productResponse.id.toString(),
        child: Material(
          child: InkWell(
            onTap: () {
              _focusNode!.unfocus();
              pushNamed(ProductDetailWidget.route, arguments: productResponse);
            },
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6.0)),
              // padding: EdgeInsets.all(8.0),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(6.0),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: Offset(0, 3), // changes position of shadow
              //     ),
              //   ],
              // ),
              child: Stack(
                children: [
                  Row(children: [
                    SizedBox(
                      height: 100.0,
                      width: 90.0,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            Utils.getImageFromId(productResponse.attachmentId!),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          productResponse.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "${productResponse.pointPrice!.toDecimal()} point",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )),
                    // GestureDetector(
                    //   onTap: () {
                    //     _dialogQuantity(productResponse, index);
                    //   },
                    //   child: Icon(
                    //     Icons.add_box_outlined,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    const SizedBox(
                      width: 16.0,
                    )
                  ]),
                  Positioned(
                      top: 70,
                      left: 0,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          decoration: const BoxDecoration(
                              color: ColorName.primary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(6.0),
                                  bottomRight: Radius.circular(6.0))),
                          child: Text(
                            productResponse.productCategory?.name ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dialogQuantity(ProductResponse productResponse, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Consumer<FoodReservationViewmodel>(
                    builder: (context, model, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          productResponse.name ?? '',
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Provider.of<FoodReservationViewmodel>(context,
                                          listen: false)
                                      .decreaseQuantity(index);
                                },
                                child: const Icon(Icons.remove_circle_outline)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                model.listProduct[index].quantity == null
                                    ? "0"
                                    : model.listProduct[index].quantity
                                        .toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Provider.of<FoodReservationViewmodel>(context,
                                          listen: false)
                                      .increaseQuantity(index);
                                },
                                child: const Icon(Icons.add_circle_outline_rounded)),
                          ],
                        ),
                      ),
                      buttonView(
                          onPressed: (model.listProduct[index].quantity !=
                                      null &&
                                  model.listProduct[index].quantity! > 0)
                              ? () {
                                  Provider.of<FoodReservationViewmodel>(context,
                                          listen: false)
                                      .addSingleProductToCart(
                                          context,
                                          productResponse.id!,
                                          productResponse.quantity ?? 1,
                                          callBack: () {
                                    pop();
                                  });
                                }
                              : () {},
                          text: "Add to Cart",
                          backgroundColor:
                              (model.listProduct[index].quantity != null &&
                                      model.listProduct[index].quantity! > 0)
                                  ? ColorName.primary
                                  : Colors.grey),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                })),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

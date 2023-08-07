import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/cart_detail_response.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/view_model/food_reservation.viewmodel.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';

class CartScreen extends StateFullConsumer {
  const CartScreen({Key? key}) : super(key: key);
  static const String route = "./cartScreen";
  @override
  StateConsumer<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends StateConsumer<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  @override
  void initStateWidget() {
    Provider.of<FoodReservationViewmodel>(context, listen: false)
        .getListCartDetail(0);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Consumer<FoodReservationViewmodel>(
      builder: (BuildContext context, FoodReservationViewmodel model,
          Widget? child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBarBottomBar(_scaffoldKey,
              context: context, title: "My Cart", actions: [], onClose: () {
            pop();
          }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(ColorName.primary),
                    value: model.isCheckAll,
                    onChanged: (bool? value) {
                      model.clearListCheked(value!);
                    },
                  ),
                  const Text(
                    'Select all product',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: BaseSmartRefress(
                    refreshController: _refreshController,
                    onLoading: () {
                      model.getListCartDetail(model.listCartDetail.length);
                      _refreshController.loadComplete();
                    },
                    onRefresh: () {
                      model.getListCartDetail(0);
                      _refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                        itemCount: model.listCartDetail.length,
                        itemBuilder: (context, index) {
                          return _itemCart(
                              model.listCartDetail[index], model, index);
                        })),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(),
              SizedBox(height: 160.0, child: _checkoutInforCart(model)),
              // SizedBox(
              //   height: 40.0,
              // )
            ],
          ),
        );
      },
    );
  }

  Widget _checkoutInforCart(FoodReservationViewmodel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current point',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  "${model.mbsPoint!.toDecimal()} point",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black45),
                )
              ],
            ),
          ),
          Container(
            // height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total point',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  "${model.totalAllPoint.toDecimal()} point",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black45),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: width(context),
            child: buttonView(
                text: "Check out",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                onPressed: () {
                  if (model.listCartDetail.isEmpty) {
                    showSnackBar(
                        context, 'You have no items in your shopping cart !');
                  } else {
                    showAlertDialog(
                        typeDialog: TypeDialog.warning,
                        title: "Do you want to checkout this cart ?",
                        onSuccess: () {
                          model.checkoutCart(callback: () {
                            Provider.of<NotificationScreenViewModel>(context,
                                    listen: false)
                                .getListNotification(0);
                            Provider.of<FoodReservationViewmodel>(context,
                                    listen: false)
                                .getListCartDetail(0);
                            pop();
                            showAlertDialog(
                                typeDialog: TypeDialog.custom,
                                lottiePath: Assets.lottie_food_order,
                                title: "Your order has been processing!");
                          });
                        });
                  }
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _itemCart(CartDetailResponse cartDetailResponse,
      FoodReservationViewmodel model, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all(ColorName.primary),
            value: cartDetailResponse.isChecked!,
            onChanged: (bool? value) {
              model.unCheckItem(index);
            },
          ),
          SizedBox(
            height: 90.0,
            width: 90.0,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: Utils.getImageFromId(
                  cartDetailResponse.product!.attachmentId!),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.grey.shade300,
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
              Text(
                cartDetailResponse.product?.name ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quantityButton(model, index),
                  Text(
                    "${(cartDetailResponse.getTotalPointPice()).toDecimal()} point",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )),
        ]),
      ),
    );
  }

  Widget _quantityButton(FoodReservationViewmodel model, int indexItem) {
    return Container(
      width: 100,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            onTap: () {
              model.setQuantityInCart(true, indexItem);
            },
            child: const Icon(
              Icons.add,
              size: 18,
            )),
        Text(model.listCartDetail[indexItem].quantity.toString()),
        InkWell(
            onTap: () {
              model.setQuantityInCart(false, indexItem);
            },
            child: const Icon(Icons.remove)),
      ]),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}

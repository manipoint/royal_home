import 'package:flutter/material.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/models/cart.dart';
import 'package:royal_home/widgets/custom_text.dart';
import 'package:royal_home/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Loading(),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: cartItem.picture!,
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.only(left: 14),
                child: CustomText(
                  text: cartItem.name,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      cartController.decreaseQuantity(cartItem);
                    }),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomText(
                    text: cartItem.quantity.toString(),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      cartController.increaseQuantity(cartItem);
                    }),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
            text: "${cartController.getCost(cartItem)}",
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/models/product.dart';
import 'package:royal_home/widgets/custom_text.dart';
import 'package:royal_home/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({Key? key, required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
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
                          image: product.picture!,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width / 2.4,
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                      ),
                    ],
                  ),),
          ),
          CustomText(
            text: product.name,
            size: 18,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "${product.price}",
                  size: 22,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProductToCart(product);
                  })
            ],
          )
        ],
      ),
    );
  }
}

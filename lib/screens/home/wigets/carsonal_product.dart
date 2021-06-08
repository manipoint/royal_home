import 'package:flutter/material.dart';
import 'package:royal_home/models/feature.dart';


class CarsonalProductWidget extends StatelessWidget {
  final FeatureModel feature;

  const CarsonalProductWidget({Key? key, required this.feature})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: Stack(
              children: <Widget>[
                Image.network(feature.picture!,
                    fit: BoxFit.fitHeight,
                    width: MediaQuery.of(context).size.width),
                // Positioned(
                //   bottom: 140,
                //   left: 40.0,
                //   right: 0.0,
                //   child: Row(
                //     children: [
                //       Text(
                //         ' ${feature.name}',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 20.0,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //  Positioned(
                //   bottom: 0.0,
                //   left: 40.0,
                //   right: 0.0,
                //   child: Row(
                //     children: [
                //       Text(
                //         ' Rs ${feature.price}',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 20.0,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )));
  }
}

//Container(
    //   decoration: BoxDecoration(
    //       color: Theme.of(context).backgroundColor,
    //       borderRadius: BorderRadius.circular(15),
    //       boxShadow: [
    //         BoxShadow(
    //             color: Colors.grey.withOpacity(.5),
    //             offset: Offset(3, 2),
    //             blurRadius: 7)
    //       ]),
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ClipRRect(
    //             borderRadius: BorderRadius.circular(10),
    //               child: Stack(
    //                 children: <Widget>[
    //                   Positioned.fill(
    //                       child: Align(
    //                     alignment: Alignment.center,
    //                     child: Loading(),
    //                   )),
    //                   Center(
    //                     child: FadeInImage.memoryNetwork(
    //                       placeholder: kTransparentImage,
    //                       image: product.picture!,
    //                       fit: BoxFit.cover,
    //                       height: MediaQuery.of(context).size.width / 2.4,
    //                       width: MediaQuery.of(context).size.width / 1.5,
    //                     ),
    //                   ),
    //                 ],
    //               ),),
    //       ),
    //       CustomText(
    //         text: product.name,
    //         size: 18,
    //         weight: FontWeight.bold,
    //       ),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 8.0),
    //             child: CustomText(
    //               text: "${product.price}",
    //               size: 22,
    //               weight: FontWeight.bold,
    //             ),
    //           ),
    //           SizedBox(
    //             width: 30,
    //           ),
    //           IconButton(
    //               icon: Icon(Icons.add_shopping_cart),
    //               onPressed: () {
    //                 cartController.addProductToCart(product);
    //               })
    //         ],
    //       )
    //     ],
    //   ),
    // )
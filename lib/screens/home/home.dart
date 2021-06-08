import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/screens/home/wigets/carsonal_widget.dart';
import 'package:royal_home/screens/home/wigets/products_widget.dart';
import 'package:royal_home/screens/home/wigets/shopping_cart.dart';
import 'package:royal_home/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(() => UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(authController.userModel.value.name ?? ""),
                  accountEmail:
                      Text(authController.userModel.value.email ?? ""))),
              ListTile(
                leading: Icon(Icons.book),
                title: CustomText(
                  text: "Payments History",
                ),
                onTap: () async {
                  paymentController.getPaymentHistory();
                },
              ),
              ListTile(
                onTap: () {
                  authController.signOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
              )
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              Container(
                child: SliverAppBar(
                  elevation: 2,
                  pinned: true,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  title: CustomText(
                    text: "Royal Home",
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          showBarModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              color: Colors.white,
                              child: ShoppingCartWidget(),
                            ),
                          );
                        })
                  ],
                  centerTitle: true,
                  expandedHeight: MediaQuery.of(context).size.width / 2,
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: ImageSlider())),
                ),
              ),
            ];
          },
          body: ProductsWidget(),
        ));
  }
}

// ignore_for_file: file_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:e_comm/screens/user-panel/all-flash-sale-products.dart';
import 'package:e_comm/screens/user-panel/all-products-screen.dart';
import 'package:e_comm/screens/user-panel/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../services/get_server_key.dart';
import '../../services/notification_service.dart';
import '../../utils/app-constant.dart';
import '../../widgets/all-products-widget.dart';
import '../../widgets/banner-widget.dart';
import '../../widgets/category-widget.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import '../../widgets/heading-widget.dart';
import 'all-categories-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationService notificationService = NotificationService();
  final GetServerKey _getServerKey = GetServerKey();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    getServiceToken();
  }

  Future<void> getServiceToken() async {
    // String serverToken = await _getServerKey.getServerKeyToken();
    // print("Server Token => $serverToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[700],
            statusBarIconBrightness: Brightness.light),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
        actions: [
          GestureDetector(
            // onTap: () => Get.to(() => CartScreen()),
            onTap: () async {
              // EasyLoading.show();
              // await SendNotificationService.sendNotificationUsingApi(
              //   token:
              //       "eUn8RwbTSwK3bv9j3rKQu8:APA91bHYEje64oVDk6dsLNI77jELGjmh59RB_yPNmlZXzqMoJB76HF7l6qMCPFSez5SqsDKoIdt6k8RDzDRt2IVTchgIigmRD_QmJIxZ1MkSscXknbOmPsZkYsUGToaFZQvvb1c-JFec",
              //   title: "notification  title",
              //   body: "notification body",
              //   data: {
              //     "screen": "cart",
              //   },
              // );
              // EasyLoading.dismiss();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          GestureDetector(
              onTap: () => Get.to(() => NotificationScreen()),
              // child: Icon(Icons.message)),

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Icon(Icons.message),
              )),
          GestureDetector(
              onTap: () => Get.to(() => NotificationScreen()),
              // child: Icon(Icons.notifications)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Icon(Icons.notifications),
              )),
          GestureDetector(
            onTap: () => Get.to(() => NotificationScreen()),
            // child: Text("Sell")),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Container(
                  width: 45, // Width of the rectangle
                  height: 30, // Height of the rectangle
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), // Top left radius
                      bottomLeft: Radius.circular(15), // Bottom left radius
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'sell',
                      style: TextStyle(
                        fontSize:
                            18, // Adjust font size as needed to fit the rectangle
                        color: Colors.deepPurple[700], // Text color
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  children: [
                    GridItem(
                      icon: Icons.location_on,
                      title: 'Near Me',
                      subtitle: 'Store pickup is available',
                    ),
                    GridItem(
                      icon: Icons.shopping_basket,
                      title: 'Order Again',
                      subtitle: 'In just few clicks',
                    ),
                    GridItem(
                      icon: Icons.thumb_up,
                      title: 'Power Shops',
                      subtitle: 'Discover now',
                    ),
                    GridItem(
                      icon: Icons.storefront,
                      title: 'New Shops',
                      subtitle: 'Check them out now',
                    ),
                  ],
                ),
              ),

              
              //banners
              BannerWidget(),

              HeadingWidget(
                headingTitle: "Latest Offer",
                headingSubTitle: "",
                onTap: () => Get.to(() => AllCategoriesScreen()),
                buttonText: "See More >",
              ),
              FlashSaleWidget(),

              //heading
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllCategoriesScreen()),
                buttonText: "See More >",
              ),

              CategoriesWidget(),

              //heading
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllFlashSaleProductScreen()),
                buttonText: "See More >",
              ),
              FlashSaleWidget(),

              //heading
              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllProductsScreen()),
                buttonText: "See More >",
              ),

              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const GridItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

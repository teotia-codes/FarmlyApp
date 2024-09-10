import 'package:agriculture/pages/cart_page.dart';
import 'package:agriculture/pages/explore_page.dart';
import 'package:agriculture/pages/products_view.dart';
import 'package:agriculture/pages/profile_page.dart';
import 'package:agriculture/pages/service_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final pages = [
    const ExplorePage(),
    // const ServicePage(),
    const ProductsView()
,    const CartPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Image.asset('farmhouse.png'),
      appBar: AppBar(
        leading: Image.asset('assets/farmhouse.png'),
        centerTitle: false,
        title: Text(
          "Farmly",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.left,
          
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton.filledTonal(
              onPressed: () {},
              icon: badges.Badge(
                badgeContent: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.green),
                position: badges.BadgePosition.topEnd(top: -15, end: -12),
                child: const Icon(IconlyBroken.notification),
              ),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      
      bottomNavigationBar: 
      CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: currentIndex,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(IconlyLight.bag, size: 30),
            Icon(IconlyBold.buy, size: 30),
            Icon(IconlyBold.profile, size: 30),
          ],
          color: Colors.green,
          buttonBackgroundColor: Colors.green[200]!,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration:const  Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      // BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(IconlyLight.home),
      //       activeIcon: Icon(IconlyBold.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(IconlyLight.call),
      //       activeIcon: Icon(IconlyBold.call),
      //       label: 'Service',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(IconlyLight.buy),
      //       activeIcon: Icon(IconlyBold.buy),
      //       label: 'Cart',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(IconlyLight.profile),
      //       activeIcon: Icon(IconlyBold.profile),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}

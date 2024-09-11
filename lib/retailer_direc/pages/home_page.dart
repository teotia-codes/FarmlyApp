
import 'package:app/retailer_direc/pages/cart_page.dart';
import 'package:app/retailer_direc/pages/explore_page.dart';
import 'package:app/retailer_direc/pages/products_view.dart';
import 'package:app/retailer_direc/pages/profile_page.dart';
import 'package:app/utils/appcolors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Image.asset('farmhouse.png'),
      appBar: AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: size.height * 0.1,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: size.height * 0.175,
              width: size.width * 0.175,
              child: Image.asset(
                "assets/farmhouse.png",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              )),
          SizedBox(
            width: 2.5,
          ),
          Text(
            "FARMLY",
            textAlign: TextAlign.center,
            style: GoogleFonts.teko(
                color: Color(0xff046a38),
                fontSize: 28,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
            color: AppColors.kBrandColor,
            iconSize: 25,
          ),
        )
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

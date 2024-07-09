import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_go/common/constants.dart';
import 'package:food_go/common/toast.dart';
import 'package:food_go/pages/favorite_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_methods.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  List<String> image_url = [
    "assets/burger/burger_1.png",
    "assets/burger/burger_2.png",
    "assets/burger/burger_3.png",
    "assets/burger/burger_4.png",
    "assets/burger/burger_5.png",
    "assets/burger/burger_6.png",
    "assets/burger/burger_7.png",
    "assets/burger/burger_8.png",
  ];
  List<String> title = [
    "CheeseBurger",
    "Hamburger",
    "Hamburger",
    "Hamburger",
    "CheeseBurger",
    "CheeseBurger",
    "Hamburger",
    "Hamburger",
  ];
  List<String> sub_title = [
    "Wendy's Burger",
    "Veggie Burger",
    "Chicken Burger",
    "Fried Chicken Burger",
    "Double CheeseBurger",
    "Double CheeseBurger",
    "Fried Chicken Burger",
    "Wendy's Burger",
  ];
  List<String> rating = [
    "4.9",
    "4.8",
    "4.6",
    "4.5",
    "4.6",
    "4.9",
    "4.9",
    "5.0",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Foodgo',
                style: TextStyle(
                    color: constants.title_color,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lobster().fontFamily),
              ),
            ),
            shadowColor: Colors.white,
            foregroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      show_toast(message: "message");
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset(
                      "assets/profile_logo/profile_logo.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: title.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 240),
                  itemBuilder: ((context, index) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: 185,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    image_url[index],
                                    width: 120,
                                    height: 120,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                GoogleFonts.roboto().fontFamily,
                                            color: constants.title_color),
                                      ),
                                      Text(
                                        sub_title[index],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                GoogleFonts.roboto().fontFamily,
                                            color: constants.sub_title_color),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            rating[index],
                                            style: TextStyle(
                                                color: constants.title_color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts.roboto()
                                                    .fontFamily),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      FavoriteButton(
                                        isFavorite: false,
                                        iconSize: 40,
                                        iconColor: constants.my_primary,
                                        valueChanged: (_isFavorite) async{
                                          if(_isFavorite == true){

                                            String id = randomAlphaNumeric(10);
                                            Map<String, dynamic> favorite_info = {
                                              "image_url": image_url[index],
                                              "title": title[index],
                                              "sub_title": sub_title[index],
                                              "rating": rating[index],
                                              "id": id,
                                            };
                                            DatabaseMethods()
                                                .add_favorite_details(favorite_info, id)
                                                .then((value) {
                                              show_toast(message: "Add Favorite");
                                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                              //     favorite_page()), (Route<dynamic> route) => false);
                                            });
                                          }else{

                                          }

                                          print('Is Favorite : $_isFavorite');
                                        },
                                      ),
                                      // FavoriteButton(
                                      //   isFavorite: false,
                                      //   iconSize: 40,
                                      //   iconColor:constants.my_primary,
                                      //   valueChanged: (_isFavorite) {
                                      //     if(_isFavorite == true){
                                      //       String id = randomAlphaNumeric(10);
                                      //       Map<String, dynamic> favoriteInfoMap = {
                                      //         "Id": id,
                                      //       };
                                      //       DatabaseMethods()
                                      //           .addFavorite(favoriteInfoMap, id)
                                      //           .then((value) {
                                      //         FocusScope.of(context).unfocus();
                                      //         show_toast(message: "add favorite has been uploaded successfully");
                                      //         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      //         //     home()), (Route<dynamic> route) => false);
                                      //       });
                                      //     print('Is Favorite : $_isFavorite');
                                      //     }else{
                                      //     print('Is Favorite : $_isFavorite');
                                      //     }
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        )
        //   favoriteDataList.isEmpty
        // ? const Center(
        // child: Text(
        //   'There are no favorites yet!',
        //   style: TextStyle(color: Colors.black),
        // ),
        // )
        // :
        //         // Scrollbar(
        //         //   thumbVisibility: true,
        //         //   trackVisibility: true,
        //         //   controller: _scrollControllerVertical,
        //         //   child: SingleChildScrollView(
        //         //     controller: _scrollControllerVertical,
        //         //     scrollDirection: Axis.vertical,
        //         //     child: Scrollbar(
        //         //       thumbVisibility: true,
        //         //       trackVisibility: true,
        //         //       controller: _scrollControllerHorizontal,
        //         //       child: SingleChildScrollView(
        //         //         controller: _scrollControllerHorizontal,
        //         //         scrollDirection: Axis.horizontal,
        //         //         child: Wrap(
        //         //           direction: Axis.vertical,
        //         //           children: List.generate(
        //         //             40,
        //         //             (index) => Container(
        //         //               width: 400,
        //         //               height: 100,
        //         //               color: Colors.blue,
        //         //               margin: EdgeInsets.all(4),
        //         //               child: Text("oke ${index}"),
        //         //             ),
        //         //           ),
        //         //         ),
        //         //       ),
        //         //     ),
        //         //   ),
        //         // )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

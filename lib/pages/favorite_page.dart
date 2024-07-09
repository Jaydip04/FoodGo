import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/constants.dart';
import '../common/toast.dart';
import '../database/database_methods.dart';

class favorite_page extends StatefulWidget {
  const favorite_page({super.key});

  @override
  State<favorite_page> createState() => _favorite_pageState();
}

class _favorite_pageState extends State<favorite_page> {
  Stream? FavoriteStream;

  getontheload() async {
    FavoriteStream = await DatabaseMethods().get_favorite_details();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

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
              'Favorite',
              style: TextStyle(
                  color: constants.title_color,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lobster().fontFamily),
            ),
          ),
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              StreamBuilder(
                  stream: FavoriteStream,
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? GridView.builder(
                            padding: EdgeInsets.all(8.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    mainAxisExtent: 240),
                            itemBuilder: ((context, index) {
                              DocumentSnapshot ds = snapshot.data.docs[index];
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
                                              ds["image_url"],
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
                                                  ds["title"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: GoogleFonts.roboto()
                                                          .fontFamily,
                                                      color: constants.title_color),
                                                ),
                                                Text(
                                                  ds["sub_title"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: GoogleFonts.roboto()
                                                          .fontFamily,
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
                                                      ds["rating"],
                                                      style: TextStyle(
                                                          color: constants.title_color,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              GoogleFonts.roboto()
                                                                  .fontFamily),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () async{
                                                      await DatabaseMethods().delete_favorite_details(ds["id"]);
                                                      show_toast(message: "Remove Favorite");
                                                    },
                                                    child: Image.asset(
                                                      "assets/burger/heart_2.png",
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }))
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
    //   Scaffold(
    //   body: SingleChildScrollView(
    //     child: Container(
    //       color: Colors.white,
    //       child: Column(
    //         children: [
    //           GridView.builder(
    //             padding: EdgeInsets.all(8.0),
    //             physics: const NeverScrollableScrollPhysics(),
    //             shrinkWrap: true,
    //             itemCount: title.length,
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2,
    //                 crossAxisSpacing: 5,
    //                 mainAxisSpacing: 5,
    //                 mainAxisExtent: 240),
    //             itemBuilder: ((context, index) {
    //               return Card(
    //                 elevation: 5,
    //                 color: Colors.white,
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(20)),
    //                 child: Container(
    //                   width: 185,
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 10),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Image.asset(
    //                               image_url[index],
    //                               width: 120,
    //                               height: 120,
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Row(
    //                           children: [
    //                             Column(
    //                               crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                   title[index],
    //                                   style: TextStyle(
    //                                       fontSize: 16,
    //                                       fontWeight: FontWeight.bold,
    //                                       fontFamily:
    //                                       GoogleFonts.roboto().fontFamily,
    //                                       color: constants.title_color),
    //                                 ),
    //                                 Text(
    //                                   sub_title[index],
    //                                   style: TextStyle(
    //                                       fontSize: 14,
    //                                       fontFamily:
    //                                       GoogleFonts.roboto().fontFamily,
    //                                       color: constants.sub_title_color),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment:
    //                           MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Column(
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Icon(
    //                                       Icons.star,
    //                                       color: Colors.orange,
    //                                     ),
    //                                     SizedBox(
    //                                       width: 5,
    //                                     ),
    //                                     Text(
    //                                       rating[index],
    //                                       style: TextStyle(
    //                                           color: constants.title_color,
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.bold,
    //                                           fontFamily: GoogleFonts.roboto()
    //                                               .fontFamily),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                             Column(
    //                               children: [
    //                                 Padding(
    //                                   padding: const EdgeInsets.all(8.0),
    //                                   child: GestureDetector(
    //
    //                                     onTap: () {
    //                                       String id = randomAlphaNumeric(10);
    //                                       Map<String, dynamic> favorite_info = {
    //                                         "image_url": image_url[index],
    //                                         "title": title[index],
    //                                         "sub_title": sub_title[index],
    //                                         "rating": rating[index],
    //                                         "id": id,
    //                                       };
    //                                       DatabaseMethods()
    //                                           .add_favorite_details(favorite_info, id)
    //                                           .then((value) {
    //                                         show_toast(message: "Favorite successfully");
    //                                         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //                                         //     home()), (Route<dynamic> route) => false);
    //                                       });
    //                                       show_toast(message: image_url[index]);
    //                                     },
    //                                     child: Image.asset(
    //                                       "assets/burger/heart.png",
    //                                       width: 24,
    //                                       height: 24,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 // FavoriteButton(
    //                                 //   isFavorite: false,
    //                                 //   iconSize: 40,
    //                                 //   iconColor:constants.my_primary,
    //                                 //   valueChanged: (_isFavorite) {
    //                                 //     if(_isFavorite == true){
    //                                 //       String id = randomAlphaNumeric(10);
    //                                 //       Map<String, dynamic> favoriteInfoMap = {
    //                                 //         "Id": id,
    //                                 //       };
    //                                 //       DatabaseMethods()
    //                                 //           .addFavorite(favoriteInfoMap, id)
    //                                 //           .then((value) {
    //                                 //         FocusScope.of(context).unfocus();
    //                                 //         show_toast(message: "add favorite has been uploaded successfully");
    //                                 //         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //                                 //         //     home()), (Route<dynamic> route) => false);
    //                                 //       });
    //                                 //     print('Is Favorite : $_isFavorite');
    //                                 //     }else{
    //                                 //     print('Is Favorite : $_isFavorite');
    //                                 //     }
    //                                 //   },
    //                                 // ),
    //                               ],
    //                             ),
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

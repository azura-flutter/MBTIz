import 'package:flutter/material.dart';
import 'package:trafit/screens/all_spot.dart';
import 'package:trafit/widgets/grid_product.dart';
import 'package:trafit/widgets/home_category.dart';
import 'package:trafit/widgets/slider_item.dart';
import 'package:trafit/util/const.dart';
import 'package:trafit/util/travel_spots.dart';
import 'package:trafit/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "지금 뜨는 MBTIz",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                InkWell(
                  child: Text(
                    "더보기",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            CarouselSlider(
              height: MediaQuery.of(context).size.height / 2.8,
              items: map<Widget>(
                travel_spots,
                (index, i) {
                  Map travel_spot = travel_spots[index];
                  return SliderItem(
                    img: travel_spot['img'],
                    isFav: false,
                    name: travel_spot['name'],
                    category: travel_spot['category'],
                    rating: 5.0,
                    raters: 23,
                  );
                },
              ).toList(),
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              viewportFraction: 1.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            // SizedBox(height: 10.0),
            // Text(
            //   "찰떡궁합 MBTI",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.w800,
            //   ),
            // ),
            // SizedBox(height: 10.0),

            // Container(
            //   height: 60.0,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     shrinkWrap: true,
            //     itemCount: categories == null ? 0 : categories.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       Map cat = categories[index];
            //       return HomeCategory(
            //         icon: cat['icon'],
            //         title: cat['name'],
            //         items: cat['items'].toString(),
            //         category_num: cat['category_num'],
            //         img: cat['img'],
            //         isHome: true,
            //       );
            //     },
            //   ),
            // ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "모든 MBTI 찾기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height) /
                    1.6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: travel_spots == null ? 0 : travel_spots.length,
              itemBuilder: (BuildContext context, int index) {
                Map travel_spot = travel_spots[index];
                return GridProduct(
                  img: travel_spot['img'],
                  isFav: false,
                  name: travel_spot['name'],
                  category: travel_spot['category'],
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

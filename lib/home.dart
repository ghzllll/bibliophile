import 'package:bibliophile/AllBooks.dart';
import 'package:bibliophile/MostRequested.dart';
import 'package:bibliophile/TopSellers.dart';
import 'package:bibliophile/curvedlist.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}
Color c3=Color(0xffbda989);
Color c2=Color(0xffc2b090);
Color c1=Color(0xffc5b699);
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
       backgroundColor: Color(0xffeae4e2),
    appBar: AppBar(
    centerTitle: true,
    backgroundColor: Color(0xff988763),
    title: Text(
    'Bibliophile',
    style:TextStyle(
    fontSize: 35,
    fontFamily: "ShadowsIntoLight",
    fontStyle: FontStyle.italic,
    ),
  ),),
        //لعرض الصور المتحركة
        body : ListView(
          padding: EdgeInsets.only(top: 40),
        children: [
          InkWell(
            child: Container(
              height: 250,
              child: CarouselSlider(
                items: [
                  Image(
                    image: AssetImage("images/book1.bmp"),
                    fit: BoxFit.contain,
                    width: 300,
                    height: 10,
                  ), Image(
                    image: AssetImage("images/book6.bmp"),
                    fit: BoxFit.contain,
                    width: 300,
                    height: 10,
                  ), Image(
                    image: AssetImage("images/book5.bmp"),
                    fit: BoxFit.contain,
                    width: 300,
                    height: 10,
                  ),
                  Image(
                      image: AssetImage("images/book2.bmp"),
                      fit: BoxFit.contain,
                      width: 300,
                  height: 5,),
                  Image(
                      image: AssetImage("images/book3.bmp"),
                      fit: BoxFit.contain,
                    height:  5,
                      width: 100)
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.3,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  initialPage: 2,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          //لعرض كل الكتب
          InkWell(
            child: CurvedListItem(
              title: 'All Books ',
              time: '',
              color: c1,
              nextColor: c2,

            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return AllBooksPage();
              }));

            },
          ),
          //لعرض الكتب الاكثر مبيعا
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return TopSellers();
              }));
            },
            child: CurvedListItem(
              title: 'Top Sellers',
              time: '',
              color: c2,
              nextColor: c3,
            ),
          ),
          //لعرض الكتب الاكثر طلبا
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return MostRequested();
              }));
            },
            child: CurvedListItem(
              //backgroundImage: 'images/b.bmp',
              title: '  Most Requested ',
              time: '',
              color: c3,
              nextColor: Color(0xffeae4e2),
            ),
          ),

        ],
        ),
      ),

    );
  }
}

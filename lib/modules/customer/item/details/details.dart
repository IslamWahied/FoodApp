//@dart=2.9
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/modules/customer/item/Models/Item.dart';
import 'package:elomda/modules/customer/item/components/app_bar.dart';
import 'package:elomda/modules/customer/item/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';




import 'components/ingredients.dart';
import 'components/price_and_buy.dart';
import 'components/qty_counter.dart';
import 'components/title.dart';
import 'components/vitamins.dart';

class DetailsScreen extends StatelessWidget {
  final ItemModel item;

  const DetailsScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: buildAppBar(
        context,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg'),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        title: 'Detail',
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/icons/dots.svg'),
            onPressed: () {}
          )
        ]
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.2),
            padding: EdgeInsets.only(top: size.height * 0.2),
            height: size.height * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding * 5),
                topRight: Radius.circular(kDefaultPadding * 5),
              ),
              color:  Color(0xFFFFE3E3)
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleBar(item: item),

                    SizedBox(height: kDefaultPadding),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detail',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),

                        QtyCounter(),
                      ],
                    ),

                    SizedBox(height: kDefaultPadding),

                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),

                    SizedBox(height: kDefaultPadding),

                  //  Vitamins(item: item),

                    SizedBox(height: kDefaultPadding),

                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                    SizedBox(height: kDefaultPadding),

                  //  Ingredients(item: item),

                    SizedBox(height: kDefaultPadding * 2),

                    PriceAndBuy(item: item),

                  ],
                ),
              ),
            ),
          ),

          Hero(
            tag: item.itemId,
            child:

            Image.network(
    item.image,
    height: size.height * 0.4,
    fit: BoxFit.fitHeight,
    )
    //
    //
    //         Image.asset(
    //           "assets/images/1.png",
    //           height: size.height * 0.4,
    //           fit: BoxFit.fitHeight,
    //         )
          ),
        ],
      ),
    );
  }
}
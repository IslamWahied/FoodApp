//@dart=2.9
import 'package:elomda/models/category/itemModel.dart';
import 'package:flutter/material.dart';
import 'package:elomda/modules/customer/item/Models/Item.dart';

import 'package:elomda/modules/customer/item/constants.dart';
import 'buy_button.dart';

class PriceAndBuy extends StatelessWidget {
  const PriceAndBuy({
    Key key,
    @required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                        color: kRedColor,
                        fontSize: 22
                      )
                    ),
                    TextSpan(
                      text: item.price.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22
                      )
                    )
                  ]
                ),
              )
            ],
          )
        ),

        Spacer(),

        Expanded(
          flex: 4,
          child: BuyButton(tap: () {})
        ),
      ],
    );
  }
}
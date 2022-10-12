//@dart=2.9
import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/modules/customer/item/Models/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:elomda/modules/customer/item/Models/Item.dart';

import 'package:elomda/modules/customer/item/constants.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key key,
    @required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
               item.itemTitle,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: kDefaultPadding * 0.8,
                  ),

                  SizedBox(width: kDefaultPadding * 0.5),

                  Text(
                    '${5} (${50})'
                  )
              ],
            )
          ],
        ),

        IconButton(
          icon: SvgPicture.asset('assets/icons/heart.svg'),
          onPressed: () {}
        )
      ],
    );
  }
}
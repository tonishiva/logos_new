import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AdditionalLoadingsList extends StatelessWidget {
  const AdditionalLoadingsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _additionalLoadings =
        Provider.of<OrdersSearchProvider>(context).additionalLoadings;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/illustrations/choose-role.svg',
                    width: 133,
                    height: 133,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    LocaleKeys.order_search_no_additional_loadings_title,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ).tr(),
                  Text(
                    LocaleKeys.order_search_no_additional_loadings_text,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 14,
                    ),
                  ).tr(),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

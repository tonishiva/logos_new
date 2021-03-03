import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';

import '../style.dart';

class AddCommentToOrder extends StatefulWidget {
  const AddCommentToOrder({
    Key key,
  }) : super(key: key);

  @override
  _AddCommentToOrderState createState() => _AddCommentToOrderState();
}

class _AddCommentToOrderState extends State<AddCommentToOrder> {
  TextEditingController _commentController;

  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: Color.fromRGBO(236, 236, 236, 0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 14,
                    color: Color(0xffE0E0E0),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    LocaleKeys.create_order_add_comment,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ).tr()
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.name,
              controller: _commentController,
              style: TextStyle(
                color: Style.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              cursorColor: Style.primaryColor,
              decoration: InputDecoration(
                counterText: '',
                fillColor: Color(0xffF9F9F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

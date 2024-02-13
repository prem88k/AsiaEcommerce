import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:toast/toast.dart';

class CAllBackOfOrderSortingSelection {
  void orderFilterType(String sType) {}
}

class OrderFilterBottomSheetDialog extends StatefulWidget {
  static const routeName = '/OrderFilterBottomSheetDialog';

  CAllBackOfOrderSortingSelection _callbackOfSortingSelection;
  String _radioValue; //Initial definition of radio button value

  OrderFilterBottomSheetDialog(this._callbackOfSortingSelection, this._radioValue);

  //  OrderFilterBottomSheetDialog({Key key}) : super(key: key);

  @override
  SortingBottomSheetDialogState createState() =>
      SortingBottomSheetDialogState();
}

class SortingBottomSheetDialogState extends State<OrderFilterBottomSheetDialog> {
  String sortingType = '';
  String choice;

  Widget RadioBtnRow(String text, String value) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Radio(
                value: value,
                groupValue: widget._radioValue,
                onChanged: radioButtonChanges,
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        radioButtonChanges(value);
      },
    );
  }

  void radioButtonChanges(String value) {
    setState(() {
      widget._radioValue = value;
      switch (value) {

        case 'on_delivery':
          sortingType = 'on_delivery';
          widget._callbackOfSortingSelection.orderFilterType(sortingType);
          choice = value;
          Navigator.of(context).pop();
          break;

        case 'completed':
          sortingType = 'completed';
          widget._callbackOfSortingSelection.orderFilterType(sortingType);
          choice = value;
          Navigator.of(context).pop();
          break;

        case 'pending':
          sortingType = 'pending';
          widget._callbackOfSortingSelection.orderFilterType(sortingType);
          choice = value;
          Navigator.of(context).pop();
          break;

        case 'processing':
          sortingType = 'processing';
          widget._callbackOfSortingSelection.orderFilterType(sortingType);
          choice = value;
          Navigator.of(context).pop();
          break;

        case 'declined':
          sortingType = 'declined';
          widget._callbackOfSortingSelection.orderFilterType(sortingType);
          choice = value;
          Navigator.of(context).pop();
          break;

        default:
          choice = null;
      }

      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Column(
                    children: [
                      Text(
                        'FILTER BY',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: CommonWidget.customdivider(context, 1),
                ),
                RadioBtnRow("Pending", "pending"),
                RadioBtnRow("Processing", "processing"),
                RadioBtnRow("On Delivery", "on_delivery"),
                RadioBtnRow("Completed", "completed"),
                RadioBtnRow("Declined", "declined"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:relative_layout/relative_layout.dart';

class MemberDisplayHeader extends StatefulWidget {
  final int vipLevel;
  final String userName;
  final Function onRefresh;

  MemberDisplayHeader({
    Key key,
    @required this.userName,
    @required this.vipLevel,
    @required this.onRefresh,
  })  : assert(onRefresh != null),
        super(key: key);

  @override
  MemberDisplayHeaderState createState() => MemberDisplayHeaderState();
}

class MemberDisplayHeaderState extends State<MemberDisplayHeader> {
  String _credit;

  set updateCredit(String credit) {
    String newCredit;
    if (credit.startsWith(creditSymbol))
      newCredit = credit;
    else
      newCredit = formatValue(credit, creditSign: true, floorIfInt: true);
    debugPrint('current credit: $_credit, new: $newCredit');
    if (newCredit != _credit)
      setState(() {
        _credit = newCredit;
      });
  }

  @override
  void initState() {
    _credit = formatValue('0', creditSign: true, floorIfInt: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Image.asset(
            'assets/images/vip/user_vip_${widget.vipLevel}.png',
            scale: 0.95,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            widget.userName,
            style: TextStyle(
              fontSize: FontSize.MESSAGE.value,
              color: themeColor.buttonTextPrimaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: FontSize.LARGE.value,
              minWidth: FontSize.LARGE.value * 1.5,
              maxWidth: Global.device.width * 0.8,
            ),
            child: RelativeLayout(
              children: <Widget>[
                LayoutId(
                  id: RelativeId('credit'),
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Text(
                      _credit,
                      style: TextStyle(
                        fontSize: FontSize.XLARGE.value,
                        fontWeight: FontWeight.w500,
                        color: themeColor.buttonTextPrimaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                LayoutId(
                  id: RelativeId(
                    'btn',
                    toRightOf: 'credit',
                    alignment: Alignment.center,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: GestureDetector(
                      onTap: () => widget.onRefresh(),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: FontSize.NORMAL.value * 2.5,
                          maxWidth: FontSize.NORMAL.value * 3,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(Icons.refresh,
                            color: themeColor.defaultAppbarColor),
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: themeColor.buttonBorderColor,
                        //     width: 2.0,
                        //     style: BorderStyle.solid,
                        //   ),
                        //   borderRadius: BorderRadius.circular(14.0),
                        //   color: themeColor.memberLinearColor3,
                        // ),
                        // alignment: Alignment.center,
                        // child: Text(
                        //   localeStr.btnRefresh,
                        //   style: TextStyle(
                        //       color: themeColor.buttonTextPrimaryColor),
                        //   textAlign: TextAlign.center,
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

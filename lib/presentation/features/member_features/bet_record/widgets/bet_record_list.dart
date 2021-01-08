import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_platform_data.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';

class BetRecordList extends StatelessWidget {
  final List dataList;
  final bool isAllData;

  BetRecordList({
    Key key,
    @required this.dataList,
    this.isAllData = false,
  }) : super(key: key);

  final List<String> _headerTexts = [
    localeStr.tableHeaderDate,
    localeStr.tableHeaderId,
    localeStr.tableHeaderPlatform,
    localeStr.tableHeaderGame,
    localeStr.tableHeaderAmount,
    localeStr.tableHeaderValidBet,
    localeStr.tableHeaderBonus,
  ];

  final List<String> _platformHeaderRowTexts = [
    localeStr.tableHeaderPlatform,
    localeStr.tableHeaderAmount,
    localeStr.tableHeaderValidBet,
    localeStr.tableHeaderBonus,
  ];

  final BorderSide _borderSide =
      BorderSide(color: themeColor.defaultBorderColor, width: 1.5);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        var data = dataList[index];
        bool isSumData = false;
        List<dynamic> dataTexts;
        if (data is BetRecordPlatformData) {
          isSumData = data.isSumData();
          dataTexts = [
            (isSumData) ? localeStr.tableHeaderSum : data.key,
            ValueUtil.toCreditFormat(data.bet),
            ValueUtil.toCreditFormat(data.valid),
            ValueUtil.toCreditFormat(data.payout),
          ];
        } else if (data is BetRecordData) {
          if (data.isSumData()) {
            isSumData = data.isSumData();
            dataTexts = [
              localeStr.tableHeaderSum,
              '',
              '',
              '',
              data.bet ?? ValueUtil.format(0, addCreditSign: true),
              data.validBet ?? ValueUtil.format(0, addCreditSign: true),
              data.payout ?? ValueUtil.format(0, addCreditSign: true),
            ];
          } else {
            dataTexts = [
              data.startTime,
              '${data.betNo}',
              data.site,
              data.type,
              data.bet,
              data.validBet,
              data.payout,
            ];
          }
        }
        return Container(
          decoration: new BoxDecoration(
            color: (index % 2 == 1)
                ? themeColor.defaultCardColor
                : themeColor.chartBgColor,
            border: (index % 2 == 1)
                ? null
                : Border.symmetric(vertical: _borderSide),
          ),
          child: Column(
            children: (!isAllData)
                ? List.generate(_headerTexts.length, (rowIndex) {
                    return _buildRow(
                      _headerTexts[rowIndex],
                      dataTexts[rowIndex],
                      isSumData && rowIndex == 0,
                    );
                  })
                : List.generate(_platformHeaderRowTexts.length, (rowIndex) {
                    return _buildRow(
                      _platformHeaderRowTexts[rowIndex],
                      dataTexts[rowIndex],
                      isSumData && rowIndex == 0,
                    );
                  }),
          ),
        );
      },
    );
  }

  Widget _buildRow(String title, dynamic content, bool isSum) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              (isSum) ? localeStr.tableHeaderSum : '$title',
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              '$content',
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

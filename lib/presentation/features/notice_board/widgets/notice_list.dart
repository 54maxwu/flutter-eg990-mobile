import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/domain/sector/notice_board/notice_data.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'notice_list_item.dart';

class NoticeList extends StatefulWidget {
  final List<NoticeData> list;

  NoticeList({Key key, @required this.list}) : super(key: key);

  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  Widget _sliver;
  int _total;

  @override
  void initState() {
    _total = widget.list.length;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NoticeList oldWidget) {
    if (oldWidget.list != widget.list) {
      _total = widget.list.length;
      _sliver = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Image.asset(Res.img_no_data),
      );
    }
    _sliver ??= SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => NoticeListItem(
          data: widget.list[index],
          isLast: index == _total - 1,
        ),
        childCount: _total,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [_sliver],
      ),
    );
  }
}

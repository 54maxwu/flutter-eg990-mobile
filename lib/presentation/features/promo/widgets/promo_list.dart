import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/domain/sector/promo/promo_entity.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'promo_list_item.dart';

class PromoList extends StatefulWidget {
  final List<PromoEntity> promos;

  PromoList({Key key, @required this.promos}) : super(key: key);

  @override
  _PromoListState createState() => _PromoListState();
}

class _PromoListState extends State<PromoList> {
  Widget _sliver;

  @override
  void didUpdateWidget(covariant PromoList oldWidget) {
    if (oldWidget.promos != widget.promos) _sliver = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promos.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Image.asset(Res.img_no_data),
      );
    }
    _sliver ??= SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => PromoListItem(promo: widget.promos[index]),
        childCount: widget.promos.length,
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

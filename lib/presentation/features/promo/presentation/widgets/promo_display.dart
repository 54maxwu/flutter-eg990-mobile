import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';

class PromoDisplay extends StatefulWidget {
  // final List<Promo> promos;
  // final PromoStore store;
  //
  // PromoDisplay({
  //   Key key,
  //   @required this.store,
  //   @required this.promos,
  // }) : super(key: key);

  @override
  _PromoDisplayState createState() => _PromoDisplayState();
}

class _PromoDisplayState extends State<PromoDisplay>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController.index;
    //   });
    //   debugPrint("Selected Index: " + _tabController.index.toString());
    // });
  }

  @override
  void dispose() {
    // try {
    //   if (_tabController != null) _tabController.dispose();
    // } catch (e) {
    //   MyLogger.debug(
    //     msg:
    //         'dispose games tab controller (${widget.promos.className}) has exception: $e',
    //     tag: "PromoDisplay",
    //   );
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(localeStr.workInProgress));
  }
}

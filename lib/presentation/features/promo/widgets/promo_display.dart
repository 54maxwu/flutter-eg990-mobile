import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/promo/promo_entity.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/features/promo/data/promo_category.dart';
import 'package:flutter_eg990_mobile/presentation/features/promo/state/promo_store.dart';

class PromoDisplay extends StatefulWidget {
  final List<PromoEntity> promos;
  final PromoStore store;

  PromoDisplay({
    Key key,
    @required this.store,
    @required this.promos,
  }) : super(key: key);

  @override
  _PromoDisplayState createState() => _PromoDisplayState();
}

class _PromoDisplayState extends State<PromoDisplay>
    with SingleTickerProviderStateMixin {
  List<PromoCategoryEnum> _categories;
  TabController _tabController;

  @override
  void initState() {
    _categories = PromoCategoryEnum.filteredList(
        widget.promos.map((e) => e.categoryStr).toList());
    debugPrint('Promo categories: ${_categories.map((e) => e.value).toList()}');
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
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose promo tab controller has exception: $e',
        tag: "PromoDisplay",
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.defaultLayeredBackgroundColor,
      appBar: AppBar(
        leadingWidth: 0.0,
        title: TabBar(
          onTap: (index) {},
          controller: _tabController,
          unselectedLabelColor: themeColor.defaultHintColor,
          labelColor: themeColor.defaultTextColor,
          labelStyle: TextStyle(fontSize: FontSize.MESSAGE.value),
          indicatorColor: themeColor.defaultAccentColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: List.generate(_categories.length,
              (index) => Tab(text: _categories[index].label)),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _categories.length,
          (index) => Container(
            child: Text('${_categories[index].value}'),
          ),
        ),
      ),
    );
  }
}

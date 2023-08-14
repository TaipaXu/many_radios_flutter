import 'package:flutter/material.dart';
import 'package:x_responsive/x_responsive.dart';
import '/generated/l10n.dart';
import '/pages/tops.dart' as page;
import '/pages/search.dart' as page;
import '/pages/favorites.dart' as page;
import '/widgets/sidebar.dart' as widget;
import '/widgets/blur.dart' as widget;
import '/widgets/playControl.dart' as widget;
import '/stores/radio.dart' as store;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    store.radio.addListener(_checkRadioStore);
  }

  @override
  void dispose() {
    _animationController.dispose();
    store.radio.removeListener(_checkRadioStore);

    super.dispose();
  }

  void _checkRadioStore() {
    if (store.radio.showPlayControl) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, 'settings');
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Responsive(
            condition: Condition.screenUp(Breakpoint.md),
            child: widget.Sidebar(
              activeIndex: _currentIndex,
              onActive: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                page.Tops(),
                page.Search(),
                page.Favorites(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  50 * (1 - _animationController.value).toDouble(),
                ),
                child: const widget.Blur(
                  child: widget.PlayControl(),
                ),
              );
            },
          ),
          Responsive(
            condition: Condition.screenDown(Breakpoint.md),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.radar_outlined),
                  activeIcon: Icon(
                    Icons.radar_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: S.of(context).tops,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  activeIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: S.of(context).search,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_outline),
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: S.of(context).favorites,
                ),
              ],
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

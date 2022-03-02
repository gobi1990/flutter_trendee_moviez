import 'package:flutter/material.dart';
import 'package:trendee_moviez/constants/font_family.dart';
import 'package:trendee_moviez/views/widgets/tab_indication_painter.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _TabBarState createState() => _TabBarState();

  final ValueChanged<int>? onChanged;
  final String? pageOneTitle;
  final String? pageTwoTitle;
  final Widget? pageOne;
  final Widget? pageTwo;
  final Duration? duration;
  CustomTabBar({
    Key? key,
    @required this.pageOneTitle,
    @required this.pageTwoTitle,
    @required this.pageOne,
    @required this.pageTwo,
    @required this.onChanged,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);
}

class _TabBarState extends State<CustomTabBar> {
  final ValueNotifier<int> _tabNotifier = ValueNotifier(0);
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildTabBar(), _buildTabContainer()],
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleOnChanged(int val) {
    _tabNotifier.value = val;
    widget.onChanged!(val);
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(201, 201, 208, 0.2)),
      child: CustomPaint(
        painter: TabIndicationPainter(
            pageController: _pageController,
            width: (MediaQuery.of(context).size.width - 30) / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: InkWell(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: widget.duration!, curve: Curves.easeIn);
                  },
                  child: ValueListenableBuilder<int>(
                    valueListenable: _tabNotifier,
                    builder: (context, value, child) {
                      return Text(
                        widget.pageOneTitle!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontWeight: value == 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                            color: value == 0 ? Colors.black : Colors.grey,
                            fontSize: 16),
                      );
                    },
                  )),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: widget.duration!, curve: Curves.easeIn);
                },
                child: ValueListenableBuilder<int>(
                  valueListenable: _tabNotifier,
                  builder: (context, value, child) {
                    return Text(
                      widget.pageTwoTitle!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontWeight:
                              value == 1 ? FontWeight.w500 : FontWeight.normal,
                          color: value == 0 ? Colors.grey : Colors.black,
                          fontSize: 16),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContainer() {
    return Flexible(
      child: PageView(
        controller: _pageController,
        onPageChanged: (i) {
          _handleOnChanged(i);
        },
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: widget.pageOne),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: widget.pageTwo),
        ],
      ),
    );
  }
}

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../themes/dimensions.dart';
import 'icon_and_text.dart';

class MenuCarousel extends StatefulWidget {
  const MenuCarousel({Key? key}) : super(key: key);

  @override
  State<MenuCarousel> createState() => _MenuCarouselState();
}

class _MenuCarouselState extends State<MenuCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  var _currenPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currenPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height_30),
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _carouselView(position);
              }),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currenPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  Widget _carouselView(int position) {
    Matrix4 matrix = Matrix4.identity();

    if (position == _currenPageValue.floor()) {
      var currScale = 1 - (_currenPageValue - position) * (1 - _scaleFactor);
      var currTransform = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTransform, 0);
    } else if (position == _currenPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currenPageValue - position + 1) * (1 - _scaleFactor);
      var currTransform = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTransform, 0);
    } else if (position == _currenPageValue.floor() - 1) {
      var currScale = 1 - (_currenPageValue - position) * (1 - _scaleFactor);
      var currTransform = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTransform, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius_30),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1604632910793-c0601f361b34?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width_30,
                  right: Dimensions.width_30,
                  bottom: Dimensions.height_20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius_20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 7.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.height_15,
                  top: Dimensions.height_10,
                  right: Dimensions.height_15,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mie Goreng',
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: Dimensions.height_10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18.0,
                              );
                            }),
                          ),
                          const SizedBox(width: 10.0),
                          Text('4.8',
                              style: Theme.of(context).textTheme.subtitle1),
                          const SizedBox(width: 10.0),
                          Text('100K',
                              style: Theme.of(context).textTheme.subtitle2),
                          const SizedBox(width: 7.0),
                          Text(
                            'Users',
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height_15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          IconAndTextWidget(
                              icon: Icons.circle_sharp,
                              text: "Normal",
                              iconColor: Colors.orangeAccent),
                          IconAndTextWidget(
                              icon: Icons.location_on,
                              text: "1.4km",
                              iconColor: Colors.blueAccent),
                          IconAndTextWidget(
                              icon: Icons.access_time_rounded,
                              text: "16min",
                              iconColor: Colors.redAccent)
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

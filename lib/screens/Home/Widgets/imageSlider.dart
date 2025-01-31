import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> _banners = [
    'assets/images/1.png',
    'assets/images/2.png',
  ]; // Add your images here
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int currentIndex = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: currentIndex == index ? 20 : 10,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.3), // Adjust shadow color and opacity
            spreadRadius: 1, // Spread the shadow
            blurRadius: 5, // Blur radius for softer edges
            offset: const Offset(0, 3), // Offset for shadow position
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            print("banner selected");
          },
          child: CarouselSlider(
            items: _banners
                .map(
                  (e) => Image.asset(
                    e,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                )
                .toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              aspectRatio: 3,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 15.0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (int index) => _buildDots(
                index: index,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

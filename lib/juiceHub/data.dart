import 'dart:core';
import 'package:flutter/material.dart';

List fav = [];
List buy = [];

class cocktailItems {
  final String image;
  final String name;
  final Color color;
  bool fav;
  final int price;

  cocktailItems({
    required this.image,
    required this.name,
    required this.color,
    required this.fav,
    required this.price,
  });
}

List<cocktailItems> cocktailItem = [
  cocktailItems(
      image: "assets/images/wyne.png",
      name: "Wyne \n alchol \n \$100",
      color: Colors.white54,
      fav: false,
      price: 100),
  cocktailItems(
      image: "assets/images/vodka.png",
      name: "Vodka  \n alchol \n \$200",
      color: Colors.white54,
      fav: false,
      price: 200),
  cocktailItems(
      image: "assets/images/fiz.png",
      name: "Fiz \n drink \n \$75",
      color: Colors.white54,
      fav: false,
      price: 75),
  cocktailItems(
      image: "assets/images/dew.png",
      name: "Coco \n cola \n \$20",
      color: Colors.white54,
      fav: false,
      price: 20),
  cocktailItems(
      image: "assets/images/beer.png",
      name: "Beer \n alchol \n \$80",
      color: Colors.white54,
      fav: false,
      price: 80),
  cocktailItems(
      image: "assets/images/redbull.png",
      name: "Red  \n bull \n \$45",
      color: Colors.white54,
      fav: false,
      price: 45),
];

class shakeitems {
  final String image;
  final String name;
  final Color color;
  bool fav;
  final int price;

  shakeitems({
    required this.image,
    required this.name,
    required this.color,
    required this.fav,
    required this.price,
  });
}

List<shakeitems> shakeitem = [
  shakeitems(
      image: "assets/images/jooce.png",
      name: "Mango \n smoothie\n \$15",
      color: Colors.grey.shade50,
      fav: false,
      price: 15),
  shakeitems(
      image: "assets/images/im1.png",
      name: "Mixed Mango \n smoothie\n \$20",
      color: Colors.grey.shade50,
      fav: false,
      price: 20),
  shakeitems(
      image: "assets/images/grrape.png",
      name: "Grape \n smoothie\n \$15",
      color: Colors.grey.shade50,
      fav: false,
      price: 15),
  shakeitems(
      image: "assets/images/watermelon.png",
      name: "Watermelone \n smoothie\n \$15",
      color: Colors.grey.shade50,
      fav: false,
      price: 15),
  shakeitems(
      image: "assets/images/smoothie.png",
      name: "Mixed stwabery \n smoothie\n \$30",
      color: Colors.grey.shade50,
      fav: false,
      price: 30),
  shakeitems(
      image: "assets/images/chicku.png",
      name: "Chicku \n smoothie\n\$20 ",
      color: Colors.grey.shade50,
      fav: false,
      price: 20),
];

class coffeeitems {
  final String image;
  final String name;
  final Color color;
  bool fav;
  final int price;

  coffeeitems({
    required this.image,
    required this.name,
    required this.color,
    required this.fav,
    required this.price,
  });
}

List<coffeeitems> coffeeitem = [
  coffeeitems(
    image: "assets/images/capicino.png",
    name: "Capichino \n smoothie \n \$20",
    color: Colors.brown.shade100,
    fav: false,
    price: 20,
  ),
  coffeeitems(
    image: "assets/images/coldcofe.png",
    name: "Sp coffee \n smoothie \n \$30",
    color: Colors.brown.shade100,
    fav: false,
    price: 30,
  ),
  coffeeitems(
    image: "assets/images/coffee smoothie.png",
    name: "Coffee \n smoothie \n \$25",
    color: Colors.brown.shade100,
    fav: false,
    price: 25,
  ),
  coffeeitems(
    image: "assets/images/mint tea.png",
    name: "Mint tea \n hot \n \$15",
    color: Colors.brown.shade100,
    fav: false,
    price: 15,
  ),
  coffeeitems(
    image: "assets/images/tea.png",
    name: "Tea \n hot \n \$10",
    color: Colors.brown.shade100,
    fav: false,
    price: 10,
  ),
  coffeeitems(
    image: "assets/images/pista.png",
    name: "Pistha \n smoothie \n \$35",
    color: Colors.brown.shade100,
    fav: false,
    price: 35,
  ),
];

class MocktailItems {
  final String image;
  final String name;
  final Color color;
  bool fav;
  final int price;

  MocktailItems({
    required this.image,
    required this.name,
    required this.color,
    required this.fav,
    required this.price,
  });
}

List<MocktailItems> mocktailItems = [
  MocktailItems(
    image: "assets/images/blue.png",
    name: "Bery \n mojito \n \$50",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 50,
  ),
  MocktailItems(
    image: "assets/images/red.png",
    name: "Strwabery  \n mojito \n \$60",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 60,
  ),
  MocktailItems(
    image: "assets/images/violet.png",
    name: "verity \n mojito \n \$75",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 75,
  ),
  MocktailItems(
    image: "assets/images/white.png",
    name: "Soda \n mojito \n \$20",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 20,
  ),
  MocktailItems(
    image: "assets/images/yellow.png",
    name: "Pinaple \n mojito \n \$30",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 30,
  ),
  MocktailItems(
    image: "assets/images/white lemon.png",
    name: "Lemon \n mojito \n \$15",
    color: Colors.blueGrey.shade100,
    fav: false,
    price: 15,
  ),
];

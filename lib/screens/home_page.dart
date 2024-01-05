

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;

import '../model/api_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getPhotosByCategory();
  }

  WallpaperDataModel? wallpaperDataModel;

  getPhotosByCategory() async {
    var apiKey = " 4hr0Tx3LN1DmxG9CyQF2sLA4bDVGjG21Q4vvo8MiKAvuc3A3S47yW2mZ";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=furniture');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var rowData = jsonDecode(response.body);
      wallpaperDataModel = WallpaperDataModel.fromJson(rowData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: wallpaperDataModel != null && wallpaperDataModel!.photos!.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchTextField(),
                  bestofMonthTitle(),
                  bestofMonthView(),
                  theColorToneTitle(),
                  theColorTone(),
                  categoryTitle(),
                  categoryView()
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Padding categoryTitle() {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Text('Categories',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w900)),
    );
  }

  SingleChildScrollView categoryView() {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: wallpaperDataModel!.photos!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade200,
                  image: DecorationImage(
                      image: NetworkImage(wallpaperDataModel!
                          .photos![index].src!.landscape
                          .toString()),
                      fit: BoxFit.cover)),
              height: 120,
            ),
          );
        },
      ),
    );
  }

  Container bestofMonthView() {
    return Container(
      // width: 200,
      height: 220,
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: wallpaperDataModel!.photos!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.9 / 1.19,
              crossAxisCount: 1),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${wallpaperDataModel!.photos![index].src!.portrait}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12)),
            );
          },
        ),
      ),
    );
  }

  Padding theColorToneTitle() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'The color Tone',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: Colors.black),
      ),
    );
  }

  Padding bestofMonthTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        'Best of the month',
        style: TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w900),
      ),
    );
  }

  Padding searchTextField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.transparent,
          border: InputBorder.none,
          filled: true,
          suffixIcon: const Icon(CupertinoIcons.search),
          hintText: "Find Wallpaper..." ,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  SizedBox theColorTone() {
    return SizedBox(
        height: 65,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: Colors.accents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                    width: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.primaries[index])),
              );
            },
          ),
        ));
  }

  SingleChildScrollView BestOFTheMonth() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: wallpaperDataModel!.photos!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.9 / 1.19,
              crossAxisCount: 1),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${wallpaperDataModel!.photos![index].src!.portrait}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12)),
            );
          },
        ),
      ),
    );
  }

  GridView bestOFMonthGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: wallpaperDataModel!.photos!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.9 / 1.19,
          crossAxisCount: 1),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              image: DecorationImage(
                  image: NetworkImage(
                      '${wallpaperDataModel!.photos![index].src!.portrait}'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12)),
        );
      },
    );
  }
}


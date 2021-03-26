import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vpec/utils/theme_helper.dart';

class CabinetsMapScreen extends StatefulWidget {
  @override
  _CabinetsMapScreenState createState() => _CabinetsMapScreenState();
}

class _CabinetsMapScreenState extends State<CabinetsMapScreen> {
  String nowImageUrl = '';
  String firstMap = '';
  String secondMap = '';
  String thirdMap = '';
  var photoController = PhotoViewController();
  bool isLoadingComplete = false;
  String appBarScaleText = ''; // used for debugging (delete later)

  @override
  void initState() {
    loadMaps();
    photoController = photoController..outputStateStream.listen(listener);
    super.initState();
  }

  @override
  void dispose() {
    photoController.dispose();
    super.dispose();
  }

  Future<void> loadMaps() async {
    firstMap = await getMap('map_01');
    secondMap = await getMap('map_02');
    thirdMap = await getMap('map_03');
    if (firstMap.isNotEmpty && secondMap.isNotEmpty && thirdMap.isNotEmpty) {
      isLoadingComplete = true;
    }
    setState(() {
      nowImageUrl = firstMap;
    });
  }

  Future<String> getMap(String docID) async {
    DocumentSnapshot cabMap = await FirebaseFirestore.instance
        .collection('cabinets_map')
        .doc(docID)
        .get();
    return cabMap['imageUrl'].toString();
  }

  void listener(PhotoViewControllerValue value) {
    bool needUpdate = false;
    appBarScaleText = value.scale.toString();
    if (isLoadingComplete) {
      if (value.scale < 2.0) {
        needUpdate = true;
        nowImageUrl = firstMap;
      }
      if (value.scale > 2.0) {
        needUpdate = true;
        nowImageUrl = secondMap;
      }
      if (value.scale > 3.0) {
        needUpdate = true;
        nowImageUrl = thirdMap;
      }
      if (needUpdate) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, isTransparent: true);
    return Scaffold(
      appBar: AppBar(
          title: Text('$appBarScaleText'), // TODO: Change title when maps is done
      ),
      body: Center(
          child: nowImageUrl.isEmpty
              ? CircularProgressIndicator()
              : PhotoView.customChild(
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                  controller: photoController,
                  child: CachedNetworkImage(
                    imageUrl: nowImageUrl,
                    errorWidget: (context, url, error) => Text(
                      "Ошибка загрузки:\n$error",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )),
    );
  }
}

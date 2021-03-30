import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../../utils/theme_helper.dart';

import 'cabinets_map_logic.dart';
import 'cabinets_map_ui.dart';

class CabinetsMapScreen extends StatefulWidget {
  @override
  _CabinetsMapScreenState createState() => _CabinetsMapScreenState();
}

class _CabinetsMapScreenState extends State<CabinetsMapScreen> {
  var floorStorage = Get.put(FloorStorage());
  String nowImageUrl = '';

  var photoController = PhotoViewController();
  bool isLoadingComplete = false;
  String appBarScaleText = ''; // used for debugging (delete later)

  @override
  void initState() {
    init();
    photoController = photoController..outputStateStream.listen(listener);
    super.initState();
  }

  @override
  void dispose() {
    photoController.dispose();
    super.dispose();
  }

  Future<void> init() async {
    nowImageUrl = await floorStorage.getScaledImage();
    setState(() {});
  }

  Future<void> listener(PhotoViewControllerValue value) async {
    if (value.scale < 2.0) {
      floorStorage.setScale(1);
      floorStorage.getScaledImage().then((url) {
        nowImageUrl = url;
        setState(() {
          appBarScaleText = value.scale.toString();
        });
      });
    }
    if (value.scale > 2.0 && value.scale < 3.0) {
      floorStorage.setScale(2);
      floorStorage.getScaledImage().then((url) {
        nowImageUrl = url;
        setState(() {
          appBarScaleText = value.scale.toString();
        });
      });
    }
    if (value.scale > 3.0 && value.scale < 4.0) {
      floorStorage.setScale(3);
      floorStorage.getScaledImage().then((url) {
        nowImageUrl = url;
        setState(() {
          appBarScaleText = value.scale.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarScaleText'), // TODO: Change title when maps is done
      ),
      body: nowImageUrl.isEmpty
          ? buildLoadingIndicator()
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                buildMapImage(nowImageUrl, photoController),
                BuildChips(
                  updateScreen: () {
                    floorStorage.getScaledImage().then((value) {
                      setState(() {
                        nowImageUrl = value;
                      });
                    });
                  },
                ),
              ],
            ),
    );
  }

  void updateScreen() {
    setState(() {});
  }
}

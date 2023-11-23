import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Components/ExitConfirmationDialog.dart';
import 'Components/RibbonShape.dart';
import 'SizeConfig.dart';
import 'dart:io';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  bool isLoadButtonSelected = true;
  List<bool> isCheckedList = List.filled(5, false);
  int count = 0;
  List<int> countsList = [];
  List<int> itemCounts = List.filled(10, 0);

  @override
  void initState() {
    super.initState();
    countsList = List.filled(5, 0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return await ExitConfirmationDialog.show(context) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Container(
                  height: SizeConfig.blockSizeVertical! * 6.0,
                  width: SizeConfig.blockSizeHorizontal! * 6.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: SizeConfig.blockSizeVertical! * 2.0,
                    color: Colors.blue.shade900,
                  ),
                ),
                onPressed: () async {
                  bool exit =
                      await ExitConfirmationDialog.show(context) ?? false;
                  if (exit) {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                textAlign: TextAlign.center,
                'Trip',
                style: TextStyle(fontFamily: 'Ultima', fontSize: 23),
              ),
            ],
          ),
          backgroundColor: Colors.blue.shade900,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeVertical! * 2.0,
                  ),
                  Text(
                    'Trip No. ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ultima',
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Text(
                    'NL01RA4589',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ultima',
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeVertical! * 2.0,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal! * 20,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoadButtonSelected = true;
                        });
                      },
                      style: ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isLoadButtonSelected
                                ? Colors.blue.shade900
                                : Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            isLoadButtonSelected
                                ? Colors.white
                                : Colors.blue.shade900),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Text('Load',
                          style: TextStyle(
                              fontFamily: 'Ultima',
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: SizeConfig.blockSizeHorizontal! * 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoadButtonSelected = false;
                        });
                      },
                      style: ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isLoadButtonSelected
                                ? Colors.white
                                : Colors.blue.shade900),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            isLoadButtonSelected
                                ? Colors.blue.shade900
                                : Colors.white),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Text('Unload',
                          style: TextStyle(
                              fontFamily: 'Ultima',
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
              isLoadButtonSelected
                  ? buildExpansionTiles('Load', 3)
                  : buildExpansionTiles('Unload', 3),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: SizeConfig.blockSizeVertical! * 25,
                  margin: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: isCheckedList.contains(false)
                        ? () {
                            _showOptionsBottomSheet(context);
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isCheckedList.contains(false)
                              ? Colors.blue.shade900
                              : Colors.grey),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Ultima',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExpansionTiles(String heading, int count) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Positioned(
              top: SizeConfig.blockSizeHorizontal! * 6.5,
              right: 0,
              left: SizeConfig.blockSizeHorizontal! * 3.5,
              child: RibbonShape(
                heading: '$heading',
                starIcon: Icons.access_time,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: SizeConfig.blockSizeVertical! * 2.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade900),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    initiallyExpanded: index == 0,
                    title: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Consignment No. ',
                          style: TextStyle(
                            fontFamily: 'Ultima',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal! * 4,
                          ),
                        ),
                        Text(
                          'NL01RA4589',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ultima',
                            fontSize: SizeConfig.blockSizeHorizontal! * 4,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Divider(
                        color: Colors.blue.shade900,
                        thickness: 2.0,
                        height: 10.0,
                      ),
                      buildRow(
                        col1: 'Edible Oil',
                        col2: '20 Packed Unit',
                        checkIcon: Icons.check_box_outlined,
                        iconColor: Colors.green,
                        iconSize: SizeConfig.blockSizeHorizontal! * 8,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Ultima',
                        ),
                        index: 0,
                      ),
                      buildRow(
                        col1: 'Real Juice',
                        col2: '15 BOX',
                        checkIcon: Icons.check_box_outlined,
                        iconColor: Colors.green,
                        iconSize: SizeConfig.blockSizeHorizontal! * 8,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Ultima',
                        ),
                        index: 1,
                      ),
                      buildRow(
                        col1: 'Soaps',
                        col2: '30 Packed Unit',
                        checkIcon: Icons.check_box_outlined,
                        iconColor: Colors.green,
                        iconSize: SizeConfig.blockSizeHorizontal! * 8,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Ultima',
                        ),
                        index: 2,
                      ),
                      buildRow(
                        col1: 'Detergents',
                        col2: '1̶0̶0̶ \n 90 Unit',
                        checkIcon: Icons.check_box_outlined,
                        iconColor: Colors.green,
                        iconSize: SizeConfig.blockSizeHorizontal! * 8,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ultima',
                        ),
                        index: 3,
                      ),
                      buildRow(
                        col1: 'Ketchup',
                        col2: '1̶5̶0̶ \n 130 Packed Unit',
                        checkIcon: Icons.check_box_outlined,
                        iconColor: Colors.green,
                        iconSize: SizeConfig.blockSizeHorizontal! * 8,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Ultima',
                        ),
                        index: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildRow({
    required String col1,
    required String col2,
    required IconData? checkIcon,
    required Color? iconColor,
    required double? iconSize,
    required TextStyle? textStyle,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                col1,
                style: textStyle,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                col2,
                style: textStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isCheckedList[index] = !isCheckedList[index];
                });
              },
              child: Icon(
                isCheckedList[index]
                    ? Icons.check_box_outline_blank
                    : Icons.check_box_outlined,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report Issue',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  buildOptionButton('Damages', 'assets/courier.png'),
                  buildOptionButton('Pilferage', 'assets/thief.png'),
                  buildOptionButton('Excess', 'assets/excess.png'),
                  buildOptionButton('Shortage', 'assets/mystery.png'),
                  buildOptionButton('Spillage', 'assets/drop.png'),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'Ultima',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildOptionButton(String text, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: () {
          _showDamagesBottomSheet(context, text);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                imagePath,
                width: SizeConfig.blockSizeHorizontal! * 12,
                height: SizeConfig.blockSizeVertical! * 6,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Ultima',
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  void _showDamagesBottomSheet(BuildContext context, text) {
    Navigator.pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        '$text',
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Ultima'),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                buildExpansionTile(
                  'Consignment No.',
                  'NL01RA4589',
                  'Edible Oil',
                  'assets/camera.png',
                  'Real Juice',
                  'assets/camera.png',
                  'Soaps',
                  'assets/camera.png',
                  'Detergents',
                  'assets/camera.png',
                  'Ketchup',
                  'assets/camera.png',
                ),
                SizedBox(height: 16.0),
                buildExpansionTile(
                  'Consignment No.',
                  'NL01RA4589',
                  'Edible Oil',
                  'assets/camera.png',
                  'Real Juice',
                  'assets/camera.png',
                  'Soaps',
                  'assets/camera.png',
                  'Detergents',
                  'assets/camera.png',
                  'Ketchup',
                  'assets/camera.png',
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Back button clicked in Damages bottom sheet');
                        Navigator.pop(context);
                        _showOptionsBottomSheet(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Ultima',
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade900),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Ultima',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildExpansionTile(
    String consignmentText,
    String consignmentValue,
    String itemName1,
    String cameraImagePath1,
    String itemName2,
    String cameraImagePath2,
    String itemName3,
    String cameraImagePath3,
    String itemName4,
    String cameraImagePath4,
    String itemName5,
    String cameraImagePath5,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade900),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  consignmentText,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ultima'),
                ),
                Text(
                  consignmentValue,
                  style: TextStyle(
                      fontFamily: 'Ultima',
                      fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            children: <Widget>[
              Divider(
                color: Colors.blue.shade900,
                thickness: 2.0,
                height: 10.0,
              ),
              buildContent(itemName1, cameraImagePath1, 0),
              buildContent(itemName2, cameraImagePath2, 1),
              buildContent(itemName3, cameraImagePath3, 2),
              buildContent(itemName4, cameraImagePath4, 3),
              buildContent(itemName5, cameraImagePath5, 4),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal! * 1.7),
                child: Text(
                  'Description of Damage',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ultima'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildContent(String itemName, String cameraImagePath, int index) {
    File? capturedImage = null;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                itemName,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 4,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ultima'),
              ),
              Spacer(),
              if (itemCounts[index] == 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      itemCounts[index]++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade100,
                  ),
                  child: Row(
                    children: [
                      Text('Add',
                          style: TextStyle(color: Colors.blue.shade900)),
                    ],
                  ),
                ),
              if (itemCounts[index] != 0)
                Container(
                  height: SizeConfig.blockSizeVertical! * 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.blue.shade900),
                        onPressed: () {
                          setState(() {
                            if (itemCounts[index] > 0) {
                              itemCounts[index]--;
                            }
                          });
                        },
                      ),
                      Text('${itemCounts[index]}'),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.blue.shade900),
                        onPressed: () {
                          setState(() {
                            itemCounts[index]++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: () async {
                  if (capturedImage != null) {
                    _showImageDialog(context, capturedImage!);
                  } else {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        capturedImage = File(pickedFile.path);
                      });
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: capturedImage != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(capturedImage!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://illustoon.com/photo/7267.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                  child: Icon(
                    color: capturedImage != null ? Colors.grey : Colors.blue,
                    capturedImage != null
                        ? Icons.remove_red_eye_outlined
                        : Icons.photo_camera_outlined,
                    size: SizeConfig.blockSizeHorizontal! * 6,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(imageFile),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CountButton extends StatelessWidget {
  final VoidCallback? onPressedAdd;
  final VoidCallback? onPressedSubtract;
  final int count;

  CountButton({
    Key? key,
    this.onPressedAdd,
    this.onPressedSubtract,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onPressedSubtract,
        ),
        ElevatedButton(
          onPressed: onPressedAdd,
          child: Row(
            children: [
              Text(''),
              SizedBox(width: 8.0),
              Text('$count'),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onPressedAdd,
        ),
      ],
    );
  }
}

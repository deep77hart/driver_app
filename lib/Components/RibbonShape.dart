import 'package:flutter/material.dart';

import '../SizeConfig.dart';

class RibbonShape extends StatelessWidget {
  final String heading;

  IconData starIcon;
  RibbonShape({required this.heading, required this.starIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0, // Adjust the width of the ribbon as needed
      height: 50.0, // Adjust the height of the ribbon as needed
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              width: SizeConfig.blockSizeHorizontal! * 19,
              height: SizeConfig.blockSizeVertical! * 3.5,
              padding: EdgeInsets.all(4.0), // Adjust the padding as needed
              color: Colors.blue.shade500,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(starIcon, size: 15, color: Colors.white),
                    Text(
                      heading,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.blockSizeVertical! * 3.4,
            child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 4.0, // Adjust the width of the triangle as needed
                height: 5.0, // Adjust the height of the triangle as needed
                color: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(5.0, 0.0); // Adjusted the starting point

    var firstControlPoint = Offset(2.5, 0.5); // Adjusted the control point
    var firstPoint = Offset(1.25, 1.25); // Adjusted the first point
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(0.5, 2.5); // Adjusted the control point
    var secondPoint = Offset(0.0, 5.0); // Adjusted the second point
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 5.0, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

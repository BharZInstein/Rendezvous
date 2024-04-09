import 'package:flutter/material.dart';


class navigationMenu extends StatefulWidget{
  @override
  _navigationMenu  createState() =>  _navigationMenu();
}

  class _navigationMenu extends State<navigationMenu> {
    @override
    Widget build(BuildContext context) {
      final Size size = MediaQuery
          .of(context)
          .size;
      return Scaffold(
          backgroundColor: Colors.white10,
          body: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                        width: size.width,
                        height: 80,
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: Size(size.width, 80),
                              painter: BNBCustomPainter(),
                            ),
                            Center(
                              heightFactor : 0.6,
                              child: FloatingActionButton(onPressed: (){},
                                backgroundColor: Colors.orange,
                                child: Icon(Icons.add),elevation: 0.1,),
                              ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(Icons.home),
                          onPressed: (){}),
                        IconButton(icon: Icon(Icons.settings),
                            onPressed: (){}),
                      ],
                    ),


                            )

                          ],
                        )
                    )
                )
              ]
          )
      );
    }
  }
class BNBCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path  path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.20,0,size.width*0.35,0);
    path.quadraticBezierTo(size.width*0.40,0,size.width*0.40,20);
    path.arcToPoint(Offset(size.width*0.60,20),
      radius: Radius.circular(10.0),clockwise: false);
    path.quadraticBezierTo(size.width*0.60,0,size.width*0.65,0);
    path.quadraticBezierTo(size.width*0.80,0,size.width,20);
    path.lineTo(size.width,size.height);
    path.lineTo(0,size.height);
    path.close();
    canvas.drawShadow(path,Colors.black,5,true);
    canvas.drawPath(path,paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}
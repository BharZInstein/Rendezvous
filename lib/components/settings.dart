
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rendezvous/Screen/spash_screen.dart';

import 'Bookingsite.dart';
import 'homepage.dart';
class AccountPage extends StatefulWidget {
  final User user;
  const AccountPage ( {Key, required this.user}) ;

  @override
  _AccountPageState createState() => _AccountPageState();
}
class _AccountPageState extends State<AccountPage> {
  bool light = true;
  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(user: widget.user)))
            }, icon: Icon(Icons.home)
            ),
            IconButton(onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(user: widget.user)))
            }, icon: Icon(Icons.add)),
            IconButton(onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(user: widget.user)))
            }, icon: Icon(Icons.face, color: Theme.of(context).colorScheme.primary))
          ],
        ),
      ),
      //this represents the background colour , can change
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 35),
          userTile(),
          SizedBox(height: 35),
          colorTiles(),
          SizedBox(height: 35),
          DarkTile(),
          SizedBox(height: 35),
          divider(),
          SizedBox(height: 35),
          Logout(),
          //bwTiles(),
        ],
      ),
    );
  }
  Widget userTile(){
    String url = widget.user.photoURL!;

    return Center(
      child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url),
      ),
      //txt
    ));
  }

  Widget divider(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),

    );
  }


  Widget colorTiles(){
    return Column(
      children: [
        colorTile(Icons.person_outline,Colors.deepPurple,"${widget.user.displayName}"),
        SizedBox(height: 35),
        colorTile(Icons.mail,Colors.blue,"${widget.user.email}"),
        SizedBox(height: 35),
        colorTile(Icons.tag,Colors.pink,"RegNo"),
        //colorTile(Icons.dark_mode,Colors.orange,"Theme")

      ],
    );
  }

  Widget colorTile(IconData icon,Color color,String text){
    return ListTile(
      leading: Container(
        child: Icon(icon,color:color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color:color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      //trailing: //Icon(Icons.arrow_forward_ios,color:Colors.black,size:20),
    );
  }

   Widget DarkTile() {
     return ListTile(
         leading: Container(
           child: Icon(Icons.dark_mode, color: Colors.grey),
           height: 45,
           width: 45,
           decoration: BoxDecoration(
             color: Colors.grey.withOpacity(0.09),
             borderRadius: BorderRadius.circular(18),
           ),
         ),
         title: Text("Dark Mode",
           style: Theme
               .of(context)
               .textTheme
               .bodyLarge,
         ),
         trailing:
          Switch(
         // This bool value toggles the switch.
         value: light,
         activeColor: Colors.red,
         onChanged: (bool value) {
           // This is called when the user toggles the switch.
           setState(() {
             light = value;
           });
         }
     ));
   }
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn.games().signOut();
      print('User signed out successfully.');
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Widget Logout(){
    return ElevatedButton(onPressed: () => {
      signOut(),
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MySplashScreen()),
      )
    }, child: Text("Logout"));
  }
}
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage ( {Key}) ;

  @override
  _AccountPageState createState() => _AccountPageState();
}
class _AccountPageState extends State<AccountPage> {
  bool light = true;
  @override
  Widget build(BuildContext context ) {
    return Material(
      color: Color(0xffffffff),
      //this represents the background colour , can change
      child: ListView(
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
    String url = "https://cdn.pixabay.com/photo/2020/08/29/16/08/pikachu-5527377_1280.jpg";
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
        colorTile(Icons.person_outline,Colors.deepPurple,"Name"),
        SizedBox(height: 35),
        colorTile(Icons.mail,Colors.blue,"Email"),
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
  Widget Logout(){
    return ElevatedButton(onPressed: () => {}, child: Text("Logout"));
  }
}
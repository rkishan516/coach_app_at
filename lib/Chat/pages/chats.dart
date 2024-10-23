//import 'package:Ui/view/ChatScreen.dart';
// import 'package:Ui/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/chat_screen.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';
//import 'package:coach_app/Chat/all_users_screen.dart';

class Chats extends StatefulWidget {
  final String cat;
  final CurrUser currentUser;

  Chats({required this.cat, required this.currentUser});

  @override
  State<StatefulWidget> createState() {
    return new ChatState(cat, currentUser);
  }
}

class ChatState extends State<Chats> {
  final String cat;
  final CurrUser currentUser;

  ChatState(this.cat, this.currentUser);

  late CollectionReference _collectionReference;
  List<DocumentSnapshot> userlist = [];

  void giveback() {
    _collectionReference = FirebaseFirestore.instance.collection(cat);
  }

  @override
  void initState() {
    super.initState();
    //giveback();
    _collectionReference = FirebaseFirestore.instance.collection(cat);
    _collectionReference
        .where('code', isEqualTo: currentUser.code)
        .orderBy('name')
        .snapshots()
        .listen((datasnapshot) {
      setState(() {
        userlist = datasnapshot.docs;

        for (int i = 0; i < userlist.length; i++) {
          if ((userlist[i].data as Map)['uid'] == currentUser.uid) {
            userlist.removeAt(i);
            break;
          }
        }
        print("Users List ${userlist.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return userlist.length < 1
        ? Center(child: Text("No User in this category"))
        : ListView.builder(
            itemCount: userlist.length,
            itemBuilder: (context, index) => new Column(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: Column(
                    children: [
                      ListTile(
                          leading: new CircleAvatar(
                            backgroundImage: NetworkImage(
                                (userlist[index].data as Map)['photoUrl']),
                          ),
                          title: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  (userlist[index].data as Map)['name'],
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 242, 108, 37),
                                      fontSize: SizeConfig.b * 4.5),
                                ),
                                new Text(
                                  'No Time',
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: SizeConfig.b * 3.56),
                                ),
                              ],
                            ),
                          ),
                          subtitle: new Container(
                            padding: EdgeInsets.only(top: SizeConfig.v * 0.67),
                            child: new Text('No Subtitle',
                                style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.b * 3.31)),
                          ),
                          onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (context) {
                                return new ChatScreen(
                                    name:
                                        ((userlist[index].data as Map))['name'],
                                    photoUrl: (userlist[index].data
                                        as Map)['photoUrl'],
                                    receiverUid:
                                        (userlist[index].data as Map)['uid'],
                                    role:
                                        (userlist[index].data as Map)['role']);
                              }))),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

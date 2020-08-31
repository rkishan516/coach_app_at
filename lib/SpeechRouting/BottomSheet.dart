// import 'package:flutter/material.dart';

// import 'package:speech_recognition/speech_recognition.dart';

// class ShowBottomSheet {
//   BuildContext context;
//   ShowBottomSheet({@required this.context});

//   showBottomSheet() {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) => Scaffold(
//               body: SingleChildScrollView(
//                 child: StatefulBuilder(builder: (context, setState) {
//                    SpeechRecognition speechRecognition;
//                     bool isAvailable = false;
//                     bool isListening = false;
//                     String resulttext = "";
//                     speechRecognition = new SpeechRecognition();
//                     speechRecognition.setAvailabilityHandler((result)=>setState(()=>isAvailable = result));
//                     speechRecognition.setRecognitionStartedHandler(()=>setState(()=> isListening = true));
//                     speechRecognition.setRecognitionCompleteHandler(()=>setState(()=> isListening = false));
//                     speechRecognition.setRecognitionResultHandler((text)=>setState(()=> resulttext= text));
//                     speechRecognition.activate().then((value) => setState(()=> isAvailable= value));
//                   return Container(
//                     height: 200.0,
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FloatingActionButton(
//                               mini: true,
//                               onPressed: (){

//                               },
//                             ),
//                             FloatingActionButton(

//                               onPressed: (){

//                               },
//                             ),
//                             FloatingActionButton(
//                               mini: true,
//                               onPressed: (){

//                               },
//                             )

//                           ],
//                         )
//                       ],
//                     )
//                   );
//                 }),
//               ),
//             ));
//   }
// }

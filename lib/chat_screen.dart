

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  SpeechToText speechToText = SpeechToText();

  var text="Hold the button and start speaking";
  bool isListening= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton: AvatarGlow(
       endRadius: 75,
       animate: isListening,
       duration: Duration(milliseconds: 2000),
       glowColor: Colors.teal,
       repeat: true,
       repeatPauseDuration: Duration(milliseconds: 100),
       showTwoGlows: true,

       child: GestureDetector(
         child: CircleAvatar(
           radius: 35,
           backgroundColor: Colors.teal,
           child: isListening? Icon(Icons.mic,color: Colors.white,):Icon(Icons.mic_none,color: Colors.white,),
         ),
         onTapDown: (details) async{
          if(!isListening){
            var availble = await speechToText.initialize();
            if(availble){
              setState(() {
                isListening= true;
                 speechToText.listen(
                   onResult: (result){
                     setState(() {
                       text= result.recognizedWords;
                     });
                   }
                 );
              });
            }

          }
         },
         onTapUp: (details){
           setState(() {
             isListening=false;
           });
           speechToText.stop();
         },
       )
     ),
      appBar: AppBar(
        leading: Icon(Icons.sort_rounded,color: Colors.white,),
        title: Text("CHATGPT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        margin: EdgeInsets.only(bottom: 150),
         child: Text(
           text,
           style: TextStyle(
             fontSize: 24,
             color: Colors.black,
             fontWeight: FontWeight.bold,
           ),
         ),
      ) ,
    );
  }
}

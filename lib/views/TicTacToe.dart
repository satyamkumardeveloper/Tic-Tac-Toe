import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Tictactoe extends StatefulWidget {
   Tictactoe({super.key});

  @override
  State<Tictactoe> createState() => _TictactoeState();
}

class _TictactoeState extends State<Tictactoe> {
  int O_Wins=0;

  int X_Wins=0;

  int filled=0;

  String currentPlayer='O';

  List highlightedIndex=[];

  List values=["*","*","*","*","*","*","*","*","*"];

  setValue(index){
    values[index]=currentPlayer;
    setState((){});
    var result=checkWin();
    if(result){
        Get.snackbar("Yay player ${currentPlayer}"," You won this round", icon:Icon(Icons.celebration_rounded),shouldIconPulse: true,snackPosition: SnackPosition.BOTTOM );
        currentPlayer=='O'?O_Wins++:X_Wins++;
        Future.delayed(Duration(milliseconds: 3500),(){
          reset();
        });
    }
    else{
      filled++;
      currentPlayer=currentPlayer=='O'?'X':'O';

      if(filled==9){
        Get.snackbar("Round Draw", "Start new one",icon: Icon(Icons.restart_alt,),snackPosition:SnackPosition.BOTTOM);
        reset();
      }
    }
      
    
  }

  reset(){
    currentPlayer="O";
    filled=0;
    values=["*","*","*","*","*","*","*","*","*"];
    highlightedIndex=[];
    setState(() {
      
    });
  }

  checkWin(){
    if(checkplaces(0,1,2)|| checkplaces(3,4,5)||checkplaces(6,7,8) || checkplaces(0,3,6)||checkplaces(1,4,7) || checkplaces(2,5,8)||checkplaces(0,4,8)||checkplaces(2,4,6)){
      return true;
    }
    else return false;
  }

  checkplaces(a,b,c){
    if(values[a]!="*" && values[a]==values[b] && values[b]==values[c]  ){
      highlightedIndex.addAll([a,b,c]);
      return true;
      
    }
    else  return false;

  }
  resetAll(){
    X_Wins=0;
    O_Wins=0;
    currentPlayer="O";
    filled=0;
    values=["*","*","*","*","*","*","*","*","*"];
    highlightedIndex=[];
    setState(() {
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Text("Tic Tac Toe",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
            
            fontSize: 70,fontFamily: 'mayorpersonal'),),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("O Wins : ${O_Wins}",style: TextStyle(color: Colors.black,
                fontSize: 20,fontWeight: FontWeight.bold,fontFamily:  'bottomless'),),
                Text("X Wins : ${X_Wins}",style: TextStyle(color: Colors.black,
                fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'bottomless'),)
              ],
            ),SizedBox(height: 20,),
            Center(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
               shrinkWrap: true,
               itemCount: 9,
               itemBuilder: (context, index) {
                 return GestureDetector(
                  onTap: () {
                    if(values[index]=="*"){
                      setValue(index);
                    }
                  },
                  child: Padding(padding: EdgeInsets.all(20),
                  child: ClayContainer(color: Color.fromARGB(255, 221, 233, 243),
                    borderRadius: 10,
                    child: Stack(children: [
                      Center(
                        child: Text(
                          "${values[index]}",style: TextStyle( fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'mayorpersonal'
                            
                          ),),
                      ),
                      highlightedIndex.contains(index)?SpinKitCircle(color: Colors.red,):Container()
                    ],),
                  ),
                  ),

                 );
               },
               ),
            ),
            SizedBox(height: 20,),
            
            
            
            
            
            Padding(padding: EdgeInsets.all( 10),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                highlightedIndex.isNotEmpty?ClayContainer(
              height: 65,
              width: 65,
              color: Color.fromARGB(255, 215, 229, 241),
              borderRadius: 60,
              curveType: CurveType.concave,
              child: SpinKitRipple(itemBuilder: (context, index) {
                return Icon(FontAwesomeIcons.heart,color: Colors.red,size: 40) ;
              },),
            ):Container(),


            Align(
              alignment: AlignmentDirectional.bottomEnd,
             child:  GestureDetector(
              onTap: () {
                resetAll();
              },
               child: ClayContainer(
                height: 65,
                width: 65,
                borderRadius: 40,
                color: Color.fromARGB(255, 215, 229, 241),
                child: Icon(Icons.restart_alt),
                
                           ),
             )
            )
              ],
            ),)
            
          ],
        ),
      )
    );
}
}
import 'package:flutter/material.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/floating_action_bubble.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart';

class CustomFloatingButtons extends StatelessWidget {

  final AnimationController animationController;
  final Animation animation;

  const CustomFloatingButtons({
    super.key, 
    required this.animationController, 
    required this.animation
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[

        // Floating action menu item
        Bubble(
          title:"Hábito",
          iconColor :Colors.white,
          bubbleColor : Colors.blue,
          icon:Icons.settings,
          titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
          onPress: () {
            animationController.reverse();
          },
        ),
        // Floating action menu item
        Bubble(
          title:"Actividad",
          iconColor :Colors.white,
          bubbleColor : Colors.blue,
          icon:Icons.people,
          titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
          onPress: () {
            animationController.reverse();
          },
        ),
        
        // Bubble(
        //   title:"Actividad",
        //   iconColor :Colors.white,
        //   bubbleColor : Colors.blue,
        //   icon:Icons.people,
        //   titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
        //   onPress: () {
        //     animationController.reverse();
        //   },
        // ),
        

      ],

      // animation controller
      animation: animation,

      // On pressed change animation state
      onPress: () => animationController.isCompleted
            ? animationController.reverse()
            : animationController.forward(),
      
      // Floating Action button Icon color
      iconColor: Colors.white,

      // Flaoting Action button Icon 
      iconData: Icons.add, 
      backGroundColor: AppTheme.primary,
    );
  }
}
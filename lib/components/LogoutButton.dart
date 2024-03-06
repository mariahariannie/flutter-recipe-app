import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const LogoutButton({
    super.key, 
    required this.text, 
    required this.iconData, 
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 17),)
        ],
      ));
  }
}





























// import 'package:flutter/material.dart';

// class Logout extends StatelessWidget {
//   final String text;
//   final IconData iconData;

//   const Logout({super.key, 
//     required this.text,
//     required this.iconData
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(iconData),
//           const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
//           Text(text, style: const TextStyle(fontSize: 17),)
//         ],
//       ),
//     );
//   }
// }
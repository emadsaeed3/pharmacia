import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 35),
//       height: 75,
//       width: double.infinity,
//       // double.infinity means it cove the available width
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -7),
//             blurRadius: 33,
//             color: Color(0xFF6DAED9).withOpacity(0.11),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           IconButton(
//             icon: SvgPicture.asset("icons/home.svg"),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: SvgPicture.asset("icons/Following.svg"),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: SvgPicture.asset("icons/Glyph.svg"),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: SvgPicture.asset("icons/person.svg"),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }


class NavbarKey{
  NavbarKey._();

  static final GlobalKey _key = GlobalKey();

  static GlobalKey getKey() => _key;
}

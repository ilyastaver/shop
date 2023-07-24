import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theshop/pages/order_page/order_list_page.dart';

import '../../widgets/fill_button.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  SvgPicture.asset(
          'lib/assets/Logo.svg',

        ),

        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Container(
              color: Colors.black,
              child: OpenContainer(
                transitionType: ContainerTransitionType.fade,
                openBuilder: (context, _) => const OrderListPage(),
                closedElevation: 0,
                closedColor: Colors.black,
                closedShape: const RoundedRectangleBorder(),
                closedBuilder: (context, VoidCallback openContainer) {
                  return FillButton(
                    onPressed: openContainer,
                    buttonName: 'ИСТОРИЯ ЗАКАЗОВ',
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

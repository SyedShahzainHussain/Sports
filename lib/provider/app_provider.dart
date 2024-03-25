import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/features/authentication/view/modules/organization/viewModel/cricket_organization_view_model.dart';
import 'package:sports/features/authentication/view/modules/organization/viewModel/swimming_organization_view_model.dart';
import 'package:sports/features/authentication/view/modules/player/viewModel/cricket_player_view_model.dart';
import 'package:sports/features/authentication/view/modules/player/viewModel/swimming_player_view_model.dart';
import 'package:sports/services/user_view_model.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CricketOrganizationViewModel()),
        ChangeNotifierProvider(
            create: (context) => SwimmingOrganizationViewModel()),
        ChangeNotifierProvider(create: (context) => CricketPlayerViewModel()),
        ChangeNotifierProvider(create: (context) => SwimmingPlayerViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      child: child,
    );
  }
}

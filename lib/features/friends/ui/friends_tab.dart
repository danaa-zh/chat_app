import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.tabFriends)),
      body: Center(child: Text(loc.emptyTitle)),
    );
  }
}

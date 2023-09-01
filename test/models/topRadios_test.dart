import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:many_radios/generated/l10n.dart';
import 'package:many_radios/models/topRadios.dart';

void main() {
  testWidgets('should return the correct name for each TopRadiosType',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expect(TopRadiosType.byClicks.name(context),
                S.of(context).clicksTitle);
            expect(
                TopRadiosType.byVotes.name(context), S.of(context).votesTitle);
            expect(TopRadiosType.byRecentClick.name(context),
                S.of(context).recentClicksTitle);
            expect(TopRadiosType.byRecentlyChange.name(context),
                S.of(context).recentlyChangeTitle);
            return const SizedBox();
          },
        ),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [S.delegate],
      ),
    );
  });
}

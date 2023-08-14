import 'package:flutter/material.dart';
import '/generated/l10n.dart';

enum TopRadiosType {
  byClicks,
  byVotes,
  byRecentClick,
  byRecentlyChange,
}

extension TopRadiosTypeExtension on TopRadiosType {
  String name(BuildContext context) {
    switch (this) {
      case TopRadiosType.byClicks:
        return S.of(context).clicksTitle;
      case TopRadiosType.byVotes:
        return S.of(context).votesTitle;
      case TopRadiosType.byRecentClick:
        return S.of(context).recentClicksTitle;
      case TopRadiosType.byRecentlyChange:
        return S.of(context).recentlyChangeTitle;
    }
  }
}

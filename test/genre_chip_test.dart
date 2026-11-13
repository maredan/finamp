import 'package:finamp/components/PlayerScreen/genre_chip.dart';
import 'package:finamp/models/finamp_models.dart';
import 'package:finamp/models/jellyfin_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('deduplicates repeated genre ids', (tester) async {
    const genreId = BaseItemId('pop-rock');
    final duplicateGenres = [
      NameLongIdPair(name: 'Pop/Rock', id: genreId),
      NameLongIdPair(name: 'Pop/Rock', id: genreId),
    ];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: GenreChips(
              parentType: BaseItemDtoType.playlist,
              genres: duplicateGenres,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(GenreChip), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

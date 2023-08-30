import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:many_radios/storages/radio.dart';
import 'package:many_radios/models/radio.dart' as model;

void main() {
  group('Radio', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('should add a favorite radio', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      await radioStorage.addFavoriteRadio(radio);
      final List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 1);
      expect(radios[0].name, 'name');
      expect(radios[0].favicon, 'favicon');
      expect(radios[0].url, 'url');
    });

    test('should not add a favorite radio if it already exists', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      await radioStorage.addFavoriteRadio(radio);
      await radioStorage.addFavoriteRadio(radio);
      final List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 1);
      expect(radios[0].name, 'name');
      expect(radios[0].favicon, 'favicon');
      expect(radios[0].url, 'url');
    });

    test('should remove a favorite radio', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      await radioStorage.addFavoriteRadio(radio);
      List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 1);
      await radioStorage.removeFavoriteRadio(radio);
      radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 0);
    });

    test('should not remove a favorite radio if it does not exist', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name2',
        favicon: 'favicon2',
        url: 'url2',
      );
      await radioStorage.removeFavoriteRadio(radio2);
      List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios, null);
      await radioStorage.addFavoriteRadio(radio);
      await radioStorage.removeFavoriteRadio(radio2);
      radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 1);
      expect(radios[0].name, 'name');
      expect(radios[0].favicon, 'favicon');
      expect(radios[0].url, 'url');
    });

    test('should check if a radio is a favorite', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      await radioStorage.addFavoriteRadio(radio);
      final bool isFavorite = await radioStorage.isFavoriteRadio(radio);
      expect(isFavorite, true);
    });

    test('should check if a radio is not a favorite', () async {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final bool isFavorite = await radioStorage.isFavoriteRadio(radio);
      expect(isFavorite, false);
    });

    test('should get favorite radios', () async {
      final model.Radio radio1 = model.Radio(
        name: 'name1',
        favicon: 'favicon1',
        url: 'url1',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name2',
        favicon: 'favicon2',
        url: 'url2',
      );
      await radioStorage.addFavoriteRadio(radio1);
      await radioStorage.addFavoriteRadio(radio2);
      final List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 2);
      expect(radios[0].name, 'name1');
      expect(radios[0].favicon, 'favicon1');
      expect(radios[0].url, 'url1');
      expect(radios[1].name, 'name2');
      expect(radios[1].favicon, 'favicon2');
      expect(radios[1].url, 'url2');
    });

    test('should get null if there are no favorite radios', () async {
      final List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios, null);
    });

    test('should get favorite radios in the same order as added', () async {
      final model.Radio radio1 = model.Radio(
        name: 'name1',
        favicon: 'favicon1',
        url: 'url1',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name2',
        favicon: 'favicon2',
        url: 'url2',
      );
      await radioStorage.addFavoriteRadio(radio1);
      await radioStorage.addFavoriteRadio(radio2);
      final List<model.Radio>? radios = await radioStorage.getFavoriteRadios();
      expect(radios!.length, 2);
      expect(radios[0].name, 'name1');
      expect(radios[0].favicon, 'favicon1');
      expect(radios[0].url, 'url1');
      expect(radios[1].name, 'name2');
      expect(radios[1].favicon, 'favicon2');
      expect(radios[1].url, 'url2');
    });
  });
}

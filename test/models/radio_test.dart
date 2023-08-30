import 'package:flutter_test/flutter_test.dart';
import 'package:many_radios/models/radio.dart' as model;

void main() {
  group('Radio', () {
    test('should return a Radio object', () {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      expect(radio.name, 'name');
      expect(radio.favicon, 'favicon');
      expect(radio.url, 'url');
    });

    test('should return true if two radios are equal', () {
      final model.Radio radio1 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      expect(radio1 == radio2, true);
    });

    test('should return false if two radios are not equal', () {
      final model.Radio radio1 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url2',
      );
      expect(radio1 == radio2, false);
    });

    test('should return the same hashcode if two radios are equal', () {
      final model.Radio radio1 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      expect(radio1.hashCode, radio2.hashCode);
    });

    test('should return the same hashcode if two radios are not equal', () {
      final model.Radio radio1 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final model.Radio radio2 = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url2',
      );
      expect(radio1.hashCode, isNot(radio2.hashCode));
    });

    test('should return a Radio object from json', () {
      final Map<String, dynamic> json = {
        'name': 'name',
        'favicon': 'favicon',
        'url': 'url',
      };
      final model.Radio radio = model.Radio.fromJson(json);
      expect(radio.name, 'name');
      expect(radio.favicon, 'favicon');
      expect(radio.url, 'url');
    });

    test('should return a json from Radio object', () {
      final model.Radio radio = model.Radio(
        name: 'name',
        favicon: 'favicon',
        url: 'url',
      );
      final Map<String, dynamic> json = radio.toJson();
      expect(json['name'], 'name');
      expect(json['favicon'], 'favicon');
      expect(json['url'], 'url');
    });
  });
}

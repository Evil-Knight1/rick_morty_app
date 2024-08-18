import '../models/pages_model.dart';

import '../models/character_model.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  final String _charactersBase = 'https://rickandmortyapi.com/api/character/';
  final Dio _dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  Future<PagesModel> getPagesModel() async {
    Response data = await _dio.get(_charactersBase);
    var jsonData = data.data['info'];
    return PagesModel.fromJson(jsonData);
  }

  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response data = await _dio.get(_charactersBase);
      var jsonData = data.data;
      int pages = jsonData['info']['pages'] as int;
      List<CharacterModel> characters = [];
      for (var character in jsonData['results']) {
        characters.add(CharacterModel.fromJson(character));
      }
      return {'pages': pages, 'characters': characters};
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getPageCharacters(int page) async {
    try {
      Response data = await _dio.get('$_charactersBase?page=$page');
      var jsonData = data.data;
      List<CharacterModel> characters = [];
      int pages = jsonData['info']['pages'] as int;
      for (var character in jsonData['results']) {
        characters.add(CharacterModel.fromJson(character));
      }
      return {'pages': pages, 'characters': characters};
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> filterCharacters(
      String characterSearchedFor) async {
    try {
      Response response =
          await _dio.get('$_charactersBase?name=$characterSearchedFor');
      List<CharacterModel> characters = [];
      var jsonData = response.data;
      int pages = jsonData['info']['pages'] as int;
      for (var character in jsonData['results']) {
        characters.add(CharacterModel.fromJson(character));
      }
      return {'pages': pages, 'characters': characters};
    } catch (e) {
      return {'pages': 0, 'characters': []};
    }
  }
}

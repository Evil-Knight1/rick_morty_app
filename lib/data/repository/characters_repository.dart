import '../services/characters_web_services.dart';

class CharactersRepository {
  CharacterWebServices characterWebServices = CharacterWebServices();

  Future<Map<String,dynamic>> getAllCharacters() async {
    return await characterWebServices.getAllCharacters();
  }

  Future<Map<String,dynamic>> getPageCharacters(int page) async {
    return await characterWebServices.getPageCharacters(page);
  }
  Future<Map<String,dynamic>> filterCharacters(String characterSearchedFor) async{
    return await characterWebServices.filterCharacters(characterSearchedFor);
  }
}

import 'package:json_annotation/json_annotation.dart';
part 'cats.g.dart';

/*
Breeds API result
{
    "adaptability": 5,
    "affection_level": 5,
    "alt_names": "",
    "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
    "child_friendly": 3,
    "country_code": "EG",
    "country_codes": "EG",
    "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
    "dog_friendly": 4,
    "energy_level": 5,
    "experimental": 0,
    "grooming": 1,
    "hairless": 0,
    "health_issues": 2,
    "hypoallergenic": 0,
    "id": "abys",
    "indoor": 0,
    "intelligence": 5,
    "lap": 1,
    "life_span": "14 - 15",
    "name": "Abyssinian",
    "natural": 1,
    "origin": "Egypt",
    "rare": 0,
    "rex": 0,
    "shedding_level": 2,
    "short_legs": 0,
    "social_needs": 5,
    "stranger_friendly": 5,
    "suppressed_tail": 0,
    "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
    "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
    "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
    "vocalisation": 1,
    "weight": {
      "imperial": "7  -  10",
      "metric": "3 - 5"
    },
    "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
  },
 */
@JsonSerializable()
class Breed {
  String id;
  String name;
  String description;
  String temperament;

  Breed({this.id, this.name, this.description, this.temperament});
  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
  Map<String, dynamic> toJson() => _$BreedToJson(this);
}
@JsonSerializable()
class BreedList {
  List<Breed> breeds;
  BreedList({this.breeds});

  factory BreedList.fromJson(List<dynamic> json) {
    return BreedList(
        breeds: json
            .map((e) => Breed.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
@JsonSerializable()
class Cat {
  String name;
  String description;
  String life_span;

  Cat({this.name, this.description, this.life_span});

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
  Map<String, dynamic> toJson() => _$CatToJson(this);
}
@JsonSerializable()
class CatBreed {
  String id;
  String url;
  int width;
  int height;
  List<Cat> breeds;

  CatBreed({this.id, this.url, this.width, this.height, this.breeds});

  factory CatBreed.fromJson(Map<String, dynamic> json) =>
      _$CatBreedFromJson(json);
  Map<String, dynamic> toJson() => _$CatBreedToJson(this);
}
@JsonSerializable()
class CatList {
  List<CatBreed> breeds;

  CatList({this.breeds});

  factory CatList.fromJson(List<dynamic> json) {
    return CatList(
        breeds: json
            .map((e) => CatBreed.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

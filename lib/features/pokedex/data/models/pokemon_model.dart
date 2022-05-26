import 'dart:convert';

import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required this.baseExperience,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.name,
    required this.weight,
    required this.abilities,
    required this.types,
  }) : super(
            baseExperience: baseExperience,
            height: height,
            heldItems: heldItems,
            id: id,
            isDefault: isDefault,
            name: name,
            weight: weight,
            abilities: abilities,
            types: types);

  final int baseExperience;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String name;
  final int weight;
  final List<AbilityElementModel> abilities;
  final List<TypeModel> types;

  factory PokemonModel.fromJson(String str) =>
      PokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        baseExperience: json["base_experience"],
        height: json["height"],
        heldItems: List<dynamic>.from(json["held_items"].map((x) => x)),
        id: json["id"],
        isDefault: json["is_default"],
        name: json["name"],
        weight: json["weight"],
        abilities: List<AbilityElementModel>.from(
            json["abilities"].map((x) => AbilityElementModel.fromMap(x))),
        types: List<TypeModel>.from(
            json["types"].map((x) => TypeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "base_experience": baseExperience,
        "height": height,
        "held_items": List<dynamic>.from(heldItems.map((x) => x)),
        "id": id,
        "is_default": isDefault,
        "name": name,
        "weight": weight,
        "abilities": List<dynamic>.from(abilities.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
      };
}

class AbilityElementModel extends AbilityElement {
  AbilityElementModel({
    required this.ability,
    required this.isHidden,
    required this.slot,
  }) : super(ability: ability, isHidden: isHidden, slot: slot);

  final TypeClassModel ability;
  final bool isHidden;
  final int slot;

  factory AbilityElementModel.fromJson(String str) =>
      AbilityElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbilityElementModel.fromMap(Map<String, dynamic> json) =>
      AbilityElementModel(
        ability: TypeClassModel.fromMap(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability.toMap(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class TypeClassModel extends TypeClass {
  TypeClassModel({
    required this.name,
    required this.url,
  }) : super(name: name, url: url);

  final String name;
  final String url;

  factory TypeClassModel.fromJson(String str) =>
      TypeClassModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeClassModel.fromMap(Map<String, dynamic> json) => TypeClassModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class TypeModel extends Type {
  TypeModel({
    required this.slot,
    required this.type,
  }) : super(slot: slot, type: type);

  final int slot;
  final TypeClassModel type;

  factory TypeModel.fromJson(String str) => TypeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeModel.fromMap(Map<String, dynamic> json) => TypeModel(
        slot: json["slot"],
        type: TypeClassModel.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
      };
}

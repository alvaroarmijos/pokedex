import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  Pokemon({
    required this.baseExperience,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.name,
    required this.weight,
    required this.abilities,
    required this.types,
  });

  final int baseExperience;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String name;
  final int weight;
  final List<AbilityElement> abilities;
  final List<Type> types;

  @override
  List<Object?> get props => [
        [
          baseExperience,
          height,
          heldItems,
          id,
          isDefault,
          name,
          weight,
          abilities,
          types
        ]
      ];
}

class AbilityElement extends Equatable {
  AbilityElement({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final TypeClass ability;
  final bool isHidden;
  final int slot;

  @override
  List<Object?> get props => [
        [ability, isHidden, slot]
      ];
}

class TypeClass extends Equatable {
  TypeClass({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  @override
  List<Object?> get props => [
        [name, url]
      ];
}

class Type extends Equatable {
  Type({
    required this.slot,
    required this.type,
  });

  final int slot;
  final TypeClass type;

  @override
  List<Object?> get props => [
        [slot, type]
      ];
}

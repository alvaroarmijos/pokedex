import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  Pokemon({
    this.baseExperience,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.name,
    this.weight,
    this.abilities,
    this.types,
  }) : super([
          baseExperience,
          height,
          heldItems,
          id,
          isDefault,
          name,
          weight,
          abilities,
          types
        ]);

  final int baseExperience;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String name;
  final int weight;
  final List<AbilityElement> abilities;
  final List<Type> types;
}

class AbilityElement extends Equatable {
  AbilityElement({
    this.ability,
    this.isHidden,
    this.slot,
  }) : super([ability, isHidden, slot]);

  final TypeClass ability;
  final bool isHidden;
  final int slot;
}

class TypeClass extends Equatable {
  TypeClass({
    this.name,
    this.url,
  }) : super([name, url]);

  final String name;
  final String url;
}

class Type extends Equatable {
  Type({
    this.slot,
    this.type,
  }) : super([slot, type]);

  final int slot;
  final TypeClass type;
}

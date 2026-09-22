import 'package:command_runner/command_runner.dart';

enum OptionType {flag, option}

class Option extends CliElement {
  Option(
    this.name, {
    required this.type,
    this.help,
    this.abbr,
    this.defaultValue,
    this.valueHelp,
  });


  // final String name;
  // final OptionType type; 
  // final String? help; 
  // final String? abbr;
  // final Object? defaultValue; 
  // final String? valueHelp; 

  @override
  final String name; 

  final OptionType type; 

  @override
  final String? help; 

  final String? abbr; 

  @override 
  final Object? defaultValue; 

  @override
  final String? valueHelp; 

  @override 
  String get usage {
    if (abbr != null) {
      return '-$abbr,--$name: $help';
    }

    return '--$name: $help'; 
  }

}

class ArgResults {
  String? command; 
  String? commandArg; 
  Map<Option, Object?> options = {}; 

  // Returns true if the flag exists and is true
  bool flag(String name) {
    for (var option in options.keys.where((option) => option.type == OptionType.flag,
    )) {
      if (option.name == name) {
        return options[option] as bool;
      }
    }
    return false; 
  }

  bool hasOption(String name) {
    return options.keys.any((option) => option.name == name); 
  }

  ({Option option, Object? input}) getOption(String name) {
    var mapEntry = options.entries.firstWhere(
      (entry) => entry.key.name == name || entry.key.abbr == name, 
    );
    return (option: mapEntry.key, input: mapEntry.value); 
  }
}

abstract class CliElement {
  String get name; 
  String? get help;

  // In the case of flags, the default value is a bool. 
  // In other options and commands, the default value is a String. 
  // NB: flags are just Option objects that don't take arguments. 

  Object? get defaultValue; 
  String? get valueHelp; 

  String get usage; 
}

abstract class Command extends CliElement {
  @override
  String get name; 

  String get description; 

  bool get requiresArgument => false; 

  late CommandRunner runner; 

  @override
  String? help; 

  @override
  String? defaultValue; 

  @override
  String? valueHelp; 

}
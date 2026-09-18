enum OptionType {flag, option}

class Option {
  Option(
    this.name, {
    required this.type,
    this.help,
    this.abbr,
    this.defaultValue,
    this.valueHelp,
  });


  final String name;
  final OptionType type; 
  final String? help; 
  final String? abbr;
  final Object? defaultValue; 
  final String? valueHelp; 

  String get usage {
    if (abbr != null) {
      return '-$abbr,--$name: $help';
    }

    return '--$name: $help'; 
  }
  
}
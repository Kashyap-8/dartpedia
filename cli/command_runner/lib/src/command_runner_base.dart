
class CommandRunner {
  // runs the commmand-line application logic with the give arguments. 
  Future<void> run(List<String> input) async {
    print('CommandRunner received arguments: $input');
  }
}


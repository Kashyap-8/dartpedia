import 'dart:io'; 
import 'package:http/http.dart' as http; 
import 'package:command_runner/command_runner.dart';


// const version = '0.0.1';
// void main(List<String> arguments) {
//   if (arguments.isEmpty || arguments.first  == 'help'){
//     printUsage();
//   } else if (arguments.first == 'version') {
//     print('Dartpedia CLI version $version');
//   } else if (arguments.first == 'wikipedia') { // Changed to 'wikipedia'
//     // Pass all arguments *after* 'wikipedia' to searchWikipedia 
//     final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
//     searchWikipedia(inputArgs); // call searchWikipedia (no await nedded for main)
//   } else {
//     printUsage();
//   }
// }    
//Replace above with:

void main(List<String> arguments) async {
  var runner = CommandRunner(); 
  await runner.run(arguments);
}





void searchWikipedia(List<String>? arguments) async { 
  final String articleTitle; 
  // If the user didn't pass in argumets, request an article title. 
  if (arguments == null || arguments.isEmpty){
    print('Please provide an article title.'); 
    // Read input without the ?? '' fallback 
    final inputFromStdin = stdin.readLineSync(); 
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.'); 
      return; // Exit the function if there's no valid input 
    }

    // Await input and provide a default empty string if the input is null. 
    articleTitle =  inputFromStdin; 

}else {
  // Otherwise, join the arguments into a single string. 
  articleTitle = arguments.join(' ');
}
  print('Looking up articles about "$articleTitle". Please wait.');

  // Call the API and await the result 
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent); // Print the full article response (raw JSON for now)
}



void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}



// getwikipediaArticle that handles fetching datat from an external API 
Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.Wikipedia.org', // Wikipedia API domain
    '/api/rest_v1/page/summary/$articleTitle', // API path for article summary
  );
  final response = await http.get(url); // Make the HTTP request 

  if (response.statusCode == 200) {
    return response.body; // Return the response body if successful 
  }

  // Return an error message if the request failed 
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
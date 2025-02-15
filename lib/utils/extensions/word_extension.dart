extension WordExtension on String{
  String getFirstWord(){
    List<String> wordList = split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return "";
    }
  }

  String getFirstLetter(){
    String word = getFirstWord();
    if(word.isNotEmpty) {
      return word[0];
    } else {
      return "";
    }
  }
}
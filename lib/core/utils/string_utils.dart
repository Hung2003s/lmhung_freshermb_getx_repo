class StringUtils {
  static String removeAccents(String input) {
    const accents = 'áàảãạăắằẳẵặâấầẩẫậđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ';
    const noAccents = 'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy';

    final buffer = StringBuffer();
    for (final char in input.toLowerCase().split('')) {
      final index = accents.indexOf(char);
      if (index != -1) {
        buffer.write(noAccents[index]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  static bool containsIgnoreAccents(String source, String query) {
    final normalizedSource = removeAccents(source);
    final normalizedQuery = removeAccents(query);
    return normalizedSource.contains(normalizedQuery);
  }
}
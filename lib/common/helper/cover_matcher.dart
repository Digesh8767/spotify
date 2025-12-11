class CoverMatcher {
  static String matchCoverUrl(
    String title,
    String artist,
    Map<String, String> coverUrls,
  ) {
    // Try exact match first
    String exactMatch = '$artist , $title';
    if (coverUrls.containsKey(exactMatch)) {
      return coverUrls[exactMatch]!;
    }

    // Try partial matches
    for (String key in coverUrls.keys) {
      if (key.toLowerCase().contains(title.toLowerCase()) &&
          key.toLowerCase().contains(artist.toLowerCase())) {
        return coverUrls[key]!;
      }
    }

    return '';
  }
}

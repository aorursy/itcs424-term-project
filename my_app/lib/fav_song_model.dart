class FavSong {
  FavSong({
    required this.favSongs,
  });

  FavSong.fromJson(Map<String, Object?> json)
      : this(
          favSongs: (json['favSongs']! as List).cast<Map<String, String>>(),
        );

  final List<Map<String, String>> favSongs;

  Map<String, Object?> toJson() {
    return {
      'favSongs': favSongs,
    };
  }
}

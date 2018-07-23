
class Stat {
  final String url;
  final String name;

  Stat(this.url, this.name);

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
        json['url'],
        json['name']
    );
  }
}

class Stats {
  final Stat stat;
  final int effort;
  final int baseStat;

  Stats(this.stat, this.effort, this.baseStat);

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
        Stat.fromJson(json),
        json['effort'],
        json['baseStat']
    );
  }
}

class LineUp {
  List<Media>? media;

  LineUp({this.media});

  LineUp.fromJson(Map<String, dynamic> json) {
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  String? map;
  String? agent;
  String? ability;
  String? title;
  String? type;
  String? id;
  String? side;
  String? position;
  bool? isFree;
  int? addedAt;
  String? cdn;
  String? source;
  List<Thumbnails>? thumbnails;
  Author? author;

  Media(
      {this.map,
        this.agent,
        this.ability,
        this.title,
        this.type,
        this.id,
        this.side,
        this.position,
        this.isFree,
        this.addedAt,
        this.cdn,
        this.source,
        this.thumbnails,
        this.author});

  Media.fromJson(Map<String, dynamic> json) {
    map = json['map'];
    agent = json['agent'];
    ability = json['ability'];
    title = json['title'];
    type = json['type'];
    id = json['id'];
    side = json['side'];
    position = json['position'];
    isFree = json['isFree'];
    addedAt = json['addedAt'];
    cdn = json['cdn'];
    source = json['source'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['map'] = map;
    data['agent'] = agent;
    data['ability'] = ability;
    data['title'] = title;
    data['type'] = type;
    data['id'] = id;
    data['side'] = side;
    data['position'] = position;
    data['isFree'] = isFree;
    data['addedAt'] = addedAt;
    data['cdn'] = cdn;
    data['source'] = source;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}

class Thumbnails {
  String? size;
  String? source;

  Thumbnails({this.size, this.source});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['source'] = source;
    return data;
  }
}

class Author {
  String? name;
  dynamic link;
  dynamic linkType;

  Author({this.name, this.link, this.linkType});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    linkType = json['linkType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['link'] = link;
    data['linkType'] = linkType;
    return data;
  }
}
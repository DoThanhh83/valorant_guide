
class PlayerCard {
  String? uuid;
  String? displayName;
  bool? isHiddenIfNotOwned;
  dynamic themeUuid;
  String? displayIcon;
  String? smallArt;
  String? wideArt;
  String? largeArt;
  String? assetPath;

  PlayerCard({this.uuid, this.displayName, this.isHiddenIfNotOwned, this.themeUuid, this.displayIcon, this.smallArt, this.wideArt, this.largeArt, this.assetPath});

  PlayerCard.fromJson(Map<String, dynamic> json) {
    uuid = json["uuid"];
    displayName = json["displayName"];
    isHiddenIfNotOwned = json["isHiddenIfNotOwned"];
    themeUuid = json["themeUuid"];
    displayIcon = json["displayIcon"];
    smallArt = json["smallArt"];
    wideArt = json["wideArt"];
    largeArt = json["largeArt"];
    assetPath = json["assetPath"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uuid"] = uuid;
    _data["displayName"] = displayName;
    _data["isHiddenIfNotOwned"] = isHiddenIfNotOwned;
    _data["themeUuid"] = themeUuid;
    _data["displayIcon"] = displayIcon;
    _data["smallArt"] = smallArt;
    _data["wideArt"] = wideArt;
    _data["largeArt"] = largeArt;
    _data["assetPath"] = assetPath;
    return _data;
  }
}
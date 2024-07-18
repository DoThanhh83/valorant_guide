
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["uuid"] = uuid;
    data["displayName"] = displayName;
    data["isHiddenIfNotOwned"] = isHiddenIfNotOwned;
    data["themeUuid"] = themeUuid;
    data["displayIcon"] = displayIcon;
    data["smallArt"] = smallArt;
    data["wideArt"] = wideArt;
    data["largeArt"] = largeArt;
    data["assetPath"] = assetPath;
    return data;
  }
}
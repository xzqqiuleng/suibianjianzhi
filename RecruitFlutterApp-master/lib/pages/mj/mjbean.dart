class MjBean {
  String adImgUrl;
  String webUrl;
  String startAdStatus;
  String adUrl;
  String startAdUrl;
  String forceUpdateUrl;
  String startAdImgUrl;
  String startAdGoType;
  String appId;
  String adGoType;
  String status;
  String adStatus;

  MjBean(
      {this.adImgUrl,
        this.webUrl,
        this.startAdStatus,
        this.adUrl,
        this.startAdUrl,
        this.forceUpdateUrl,
        this.startAdImgUrl,
        this.startAdGoType,
        this.appId,
        this.adGoType,
        this.status,
        this.adStatus});

  MjBean.fromJson(Map<String, dynamic> json) {
    adImgUrl = json['ad_img_url'];
    webUrl = json['web_url'];
    startAdStatus = json['start_ad_status'];
    adUrl = json['ad_url'];
    startAdUrl = json['start_ad_url'];
    forceUpdateUrl = json['force_update_url'];
    startAdImgUrl = json['start_ad_img_url'];
    startAdGoType = json['start_ad_go_type'];
    appId = json['app_id'];
    adGoType = json['ad_go_type'];
    status = json['status'];
    adStatus = json['ad_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad_img_url'] = this.adImgUrl;
    data['web_url'] = this.webUrl;
    data['start_ad_status'] = this.startAdStatus;
    data['ad_url'] = this.adUrl;
    data['start_ad_url'] = this.startAdUrl;
    data['force_update_url'] = this.forceUpdateUrl;
    data['start_ad_img_url'] = this.startAdImgUrl;
    data['start_ad_go_type'] = this.startAdGoType;
    data['app_id'] = this.appId;
    data['ad_go_type'] = this.adGoType;
    data['status'] = this.status;
    data['ad_status'] = this.adStatus;
    return data;
  }
}
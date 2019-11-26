class RegionEntity {
	String region;

	RegionEntity({this.region});

	RegionEntity.fromJson(Map<String, dynamic> json) {
		region = json['region'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['region'] = this.region;
		return data;
	}
}

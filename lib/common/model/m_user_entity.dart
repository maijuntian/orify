class MUserEntity {
	String birthday;
	String gender;
	double scores;
	String icon;
	String uuid;
	dynamic platform;
	double points;
	String registeredTime;
	String phone;
	MUserGrade grade;
	String name;
	String nickname;
	int shippingAddressDefaultId;
	String region;
	String email;

	MUserEntity({this.birthday, this.gender, this.scores, this.icon, this.uuid, this.platform, this.points, this.registeredTime, this.phone, this.grade, this.name, this.nickname, this.shippingAddressDefaultId, this.region, this.email});

	MUserEntity.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		gender = json['gender'];
		scores = json['scores'];
		icon = json['icon'];
		uuid = json['uuid'];
		platform = json['platform'];
		points = json['points'];
		registeredTime = json['registeredTime'];
		phone = json['phone'];
		grade = json['grade'] != null ? new MUserGrade.fromJson(json['grade']) : null;
		name = json['name'];
		nickname = json['nickname'];
		shippingAddressDefaultId = json['shippingAddressDefaultId'];
		region = json['region'];
		email = json['email'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['gender'] = this.gender;
		data['scores'] = this.scores;
		data['icon'] = this.icon;
		data['uuid'] = this.uuid;
		data['platform'] = this.platform;
		data['points'] = this.points;
		data['registeredTime'] = this.registeredTime;
		data['phone'] = this.phone;
		if (this.grade != null) {
      data['grade'] = this.grade.toJson();
    }
		data['name'] = this.name;
		data['nickname'] = this.nickname;
		data['shippingAddressDefaultId'] = this.shippingAddressDefaultId;
		data['region'] = this.region;
		data['email'] = this.email;
		return data;
	}

	// 命名构造函数
	MUserEntity.empty();
}

class MUserGrade {
	String gradeName;
	String gradeIcon;
	int rebate;
	int startScore;
	int endScore;

	MUserGrade({this.gradeName, this.gradeIcon, this.rebate, this.startScore, this.endScore});

	MUserGrade.fromJson(Map<String, dynamic> json) {
		gradeName = json['gradeName'];
		gradeIcon = json['gradeIcon'];
		rebate = json['rebate'];
		startScore = json['startScore'];
		endScore = json['endScore'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gradeName'] = this.gradeName;
		data['gradeIcon'] = this.gradeIcon;
		data['rebate'] = this.rebate;
		data['startScore'] = this.startScore;
		data['endScore'] = this.endScore;
		return data;
	}

}

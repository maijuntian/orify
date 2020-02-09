class RecordEntity {
	int startRow;
	List<int> navigatepageNums;
	int prePage;
	bool hasNextPage;
	int nextPage;
	int pageSize;
	int endRow;
	List<RecordList> xList;
	int pageNum;
	int navigatePages;
	int total;
	int navigateFirstPage;
	int pages;
	int size;
	bool isLastPage;
	bool hasPreviousPage;
	int navigateLastPage;
	bool isFirstPage;

	RecordEntity({this.startRow, this.navigatepageNums, this.prePage, this.hasNextPage, this.nextPage, this.pageSize, this.endRow, this.xList, this.pageNum, this.navigatePages, this.total, this.navigateFirstPage, this.pages, this.size, this.isLastPage, this.hasPreviousPage, this.navigateLastPage, this.isFirstPage});

	RecordEntity.fromJson(Map<String, dynamic> json) {
		startRow = json['startRow'];
		navigatepageNums = json['navigatepageNums']?.cast<int>();
		prePage = json['prePage'];
		hasNextPage = json['hasNextPage'];
		nextPage = json['nextPage'];
		pageSize = json['pageSize'];
		endRow = json['endRow'];
		if (json['list'] != null) {
			xList = new List<RecordList>();(json['list'] as List).forEach((v) { xList.add(new RecordList.fromJson(v)); });
		}
		pageNum = json['pageNum'];
		navigatePages = json['navigatePages'];
		total = json['total'];
		navigateFirstPage = json['navigateFirstPage'];
		pages = json['pages'];
		size = json['size'];
		isLastPage = json['isLastPage'];
		hasPreviousPage = json['hasPreviousPage'];
		navigateLastPage = json['navigateLastPage'];
		isFirstPage = json['isFirstPage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['startRow'] = this.startRow;
		data['navigatepageNums'] = this.navigatepageNums;
		data['prePage'] = this.prePage;
		data['hasNextPage'] = this.hasNextPage;
		data['nextPage'] = this.nextPage;
		data['pageSize'] = this.pageSize;
		data['endRow'] = this.endRow;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		data['pageNum'] = this.pageNum;
		data['navigatePages'] = this.navigatePages;
		data['total'] = this.total;
		data['navigateFirstPage'] = this.navigateFirstPage;
		data['pages'] = this.pages;
		data['size'] = this.size;
		data['isLastPage'] = this.isLastPage;
		data['hasPreviousPage'] = this.hasPreviousPage;
		data['navigateLastPage'] = this.navigateLastPage;
		data['isFirstPage'] = this.isFirstPage;
		return data;
	}
}

class RecordList {
	String authCode;
	String manufacturerName;
	String ip;
	String authStatus;
	List<RecordListTracingresult> tracingResults;
	String authTime;
	String sourceManufactureCode;
	String productName;
	String manufacturerIcon;
	String sourceProductCode;
	String productIcon;
	int id;
	String userUUID;
	String region;
	String account;

	RecordList({this.authCode, this.manufacturerName, this.ip, this.authStatus, this.tracingResults, this.authTime, this.sourceManufactureCode, this.productName, this.manufacturerIcon, this.sourceProductCode, this.productIcon, this.id, this.userUUID, this.region, this.account});

	RecordList.fromJson(Map<String, dynamic> json) {
		authCode = json['authCode'];
		manufacturerName = json['manufacturerName'];
		ip = json['ip'];
		authStatus = json['authStatus'];
		if (json['tracingResults'] != null) {
			tracingResults = new List<RecordListTracingresult>();(json['tracingResults'] as List).forEach((v) { tracingResults.add(new RecordListTracingresult.fromJson(v)); });
		}
		authTime = json['authTime'];
		sourceManufactureCode = json['sourceManufactureCode'];
		productName = json['productName'];
		manufacturerIcon = json['manufacturerIcon'];
		sourceProductCode = json['sourceProductCode'];
		productIcon = json['productIcon'];
		id = json['id'];
		userUUID = json['userUUID'];
		region = json['region'];
		account = json['account'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['authCode'] = this.authCode;
		data['manufacturerName'] = this.manufacturerName;
		data['ip'] = this.ip;
		data['authStatus'] = this.authStatus;
		if (this.tracingResults != null) {
      data['tracingResults'] =  this.tracingResults.map((v) => v.toJson()).toList();
    }
		data['authTime'] = this.authTime;
		data['sourceManufactureCode'] = this.sourceManufactureCode;
		data['productName'] = this.productName;
		data['manufacturerIcon'] = this.manufacturerIcon;
		data['sourceProductCode'] = this.sourceProductCode;
		data['productIcon'] = this.productIcon;
		data['id'] = this.id;
		data['userUUID'] = this.userUUID;
		data['region'] = this.region;
		data['account'] = this.account;
		return data;
	}
}

class RecordListTracingresult {
	String imgUrl;
	dynamic gpsData;
	List<RecordListTracingresultsData> data;
	String identity;
	double latitude;
	String name;
	String location;
	String time;
	String behavior;
	double longitude;
	String identityIcon;
  dynamic gpsName;

	RecordListTracingresult({this.imgUrl, this.gpsData, this.data, this.identity, this.latitude, this.name, this.location, this.time, this.behavior, this.longitude, this.identityIcon, this.gpsName});

	RecordListTracingresult.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		gpsData = json['gpsData'];
		if (json['data'] != null) {
			data = new List<RecordListTracingresultsData>();(json['data'] as List).forEach((v) { data.add(new RecordListTracingresultsData.fromJson(v)); });
		}
		identity = json['identity'];
		latitude = json['latitude'];
		name = json['name'];
		location = json['location'];
		time = json['time'];
		behavior = json['behavior'];
		longitude = json['longitude'];
		identityIcon = json['identityIcon'];
		gpsName = json['gpsName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgUrl'] = this.imgUrl;
		data['gpsData'] = this.gpsData;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['identity'] = this.identity;
		data['latitude'] = this.latitude;
		data['name'] = this.name;
		data['location'] = this.location;
		data['time'] = this.time;
		data['behavior'] = this.behavior;
		data['longitude'] = this.longitude;
		data['identityIcon'] = this.identityIcon;
		data['gpsName'] = this.gpsName;
		return data;
	}
}

class RecordListTracingresultsData {
	String value;
	String key;

	RecordListTracingresultsData({this.value, this.key});

	RecordListTracingresultsData.fromJson(Map<String, dynamic> json) {
		value = json['value'];
		key = json['key'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['value'] = this.value;
		data['key'] = this.key;
		return data;
	}
}

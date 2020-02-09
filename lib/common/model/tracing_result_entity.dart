class TracingResultEntity {
	String code;
	List<TracingResultData> data;
	String manufacturerName;
	List<TracingResultSuggestion> suggestion;
	List<TracingResultTraceresultconfig> traceResultConfig;
	String productOrigin;
	List<TracingResultTracingresult> tracingResults;
	String manufacturerCode;
	String productName;
	String points;
	String productDesc;
	String manufacturerIcon;
	String productCode;
	String productionDate;
	String manufacturerDesc;
	String manufacturerFocusImg;
	String requestCode;
	String shortDesc;
	String productIcon;

	TracingResultEntity({this.code, this.data, this.manufacturerName, this.suggestion, this.traceResultConfig, this.productOrigin, this.tracingResults, this.manufacturerCode, this.productName, this.points, this.productDesc, this.manufacturerIcon, this.productCode, this.productionDate, this.manufacturerDesc, this.manufacturerFocusImg, this.requestCode, this.shortDesc, this.productIcon});

	TracingResultEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<TracingResultData>();(json['data'] as List).forEach((v) { data.add(new TracingResultData.fromJson(v)); });
		}
		manufacturerName = json['manufacturerName'];
		if (json['suggestion'] != null) {
			suggestion = new List<TracingResultSuggestion>();(json['suggestion'] as List).forEach((v) { suggestion.add(new TracingResultSuggestion.fromJson(v)); });
		}
		if (json['traceResultConfig'] != null) {
			traceResultConfig = new List<TracingResultTraceresultconfig>();(json['traceResultConfig'] as List).forEach((v) { traceResultConfig.add(new TracingResultTraceresultconfig.fromJson(v)); });
		}
		productOrigin = json['productOrigin'];
		if (json['tracingResults'] != null) {
			tracingResults = new List<TracingResultTracingresult>();(json['tracingResults'] as List).forEach((v) { tracingResults.add(new TracingResultTracingresult.fromJson(v)); });
		}
		manufacturerCode = json['manufacturerCode'];
		productName = json['productName'];
		points = json['points'];
		productDesc = json['productDesc'];
		manufacturerIcon = json['manufacturerIcon'];
		productCode = json['productCode'];
		productionDate = json['productionDate'];
		manufacturerDesc = json['manufacturerDesc'];
		manufacturerFocusImg = json['manufacturerFocusImg'];
		requestCode = json['requestCode'];
		shortDesc = json['shortDesc'];
		productIcon = json['productIcon'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['manufacturerName'] = this.manufacturerName;
		if (this.suggestion != null) {
      data['suggestion'] =  this.suggestion.map((v) => v.toJson()).toList();
    }
		if (this.traceResultConfig != null) {
      data['traceResultConfig'] =  this.traceResultConfig.map((v) => v.toJson()).toList();
    }
		data['productOrigin'] = this.productOrigin;
		if (this.tracingResults != null) {
      data['tracingResults'] =  this.tracingResults.map((v) => v.toJson()).toList();
    }
		data['manufacturerCode'] = this.manufacturerCode;
		data['productName'] = this.productName;
		data['points'] = this.points;
		data['productDesc'] = this.productDesc;
		data['manufacturerIcon'] = this.manufacturerIcon;
		data['productCode'] = this.productCode;
		data['productionDate'] = this.productionDate;
		data['manufacturerDesc'] = this.manufacturerDesc;
		data['manufacturerFocusImg'] = this.manufacturerFocusImg;
		data['requestCode'] = this.requestCode;
		data['shortDesc'] = this.shortDesc;
		data['productIcon'] = this.productIcon;
		return data;
	}
}

class TracingResultData {
	String value;
	String key;

	TracingResultData({this.value, this.key});

	TracingResultData.fromJson(Map<String, dynamic> json) {
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

class TracingResultSuggestion {
	String remake;
	String platformIcon;
	String url;

	TracingResultSuggestion({this.remake, this.platformIcon, this.url});

	TracingResultSuggestion.fromJson(Map<String, dynamic> json) {
		remake = json['remake'];
		platformIcon = json['platformIcon'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['remake'] = this.remake;
		data['platformIcon'] = this.platformIcon;
		data['url'] = this.url;
		return data;
	}
}

class TracingResultTraceresultconfig {
	int index;
	String key;

	TracingResultTraceresultconfig({this.index, this.key});

	TracingResultTraceresultconfig.fromJson(Map<String, dynamic> json) {
		index = json['index'];
		key = json['key'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['index'] = this.index;
		data['key'] = this.key;
		return data;
	}
}

class TracingResultTracingresult {
	String imgUrl;
	dynamic gpsData;
	List<TracingResultTracingresultsData> data;
	String identity;
	double latitude;
	String name;
	String location;
	String time;
	String behavior;
	double longitude;
	String identityIcon;
	dynamic gpsName;

	TracingResultTracingresult({this.imgUrl, this.gpsData, this.data, this.identity, this.latitude, this.name, this.location, this.time, this.behavior, this.longitude, this.identityIcon, this.gpsName});

	TracingResultTracingresult.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		gpsData = json['gpsData'];
		if (json['data'] != null) {
			data = new List<TracingResultTracingresultsData>();(json['data'] as List).forEach((v) { data.add(new TracingResultTracingresultsData.fromJson(v)); });
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

class TracingResultTracingresultsData {
	String value;
	String key;

	TracingResultTracingresultsData({this.value, this.key});

	TracingResultTracingresultsData.fromJson(Map<String, dynamic> json) {
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

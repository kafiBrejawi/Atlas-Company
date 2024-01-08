// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this
class Contract {
  int? count;
  List<Results>? results;

  Contract({this.count, this.results});

  Contract.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? ats;
  Interest? interest;
  String? liftType;
  int? size;
  String? floors;
  String? location;
  List<Notes>? notes;
  List<CurrentPhase>? currentPhase;
  String? villaNo;

  Results(
      {this.id,
      this.ats,
      this.interest,
      this.liftType,
      this.size,
      this.floors,
      this.location,
      this.notes,
      this.currentPhase,
      this.villaNo});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ats = json['ats'];
    interest = json['interest'] != null
        ? new Interest.fromJson(json['interest'])
        : null;
    liftType = json['lift_type'];
    size = json['size'];
    floors = json['floors'];
    location = json['location'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
    if (json['current_phase'] != null) {
      currentPhase = <CurrentPhase>[];
      json['current_phase'].forEach((v) {
        currentPhase!.add(new CurrentPhase.fromJson(v));
      });
    }
    villaNo = json['villa_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ats'] = this.ats;
    if (this.interest != null) {
      data['interest'] = this.interest!.toJson();
    }
    data['lift_type'] = this.liftType;
    data['size'] = this.size;
    data['floors'] = this.floors;
    data['location'] = this.location;
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    if (this.currentPhase != null) {
      data['current_phase'] =
          this.currentPhase!.map((v) => v.toJson()).toList();
    }
    data['villa_no'] = this.villaNo;
    return data;
  }
}

class Interest {
  int? id;
  Client? client;
  bool? inquiry;
  String? companyName;

  Interest({this.id, this.client, this.inquiry, this.companyName});

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    inquiry = json['inquiry'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['inquiry'] = this.inquiry;
    data['company_name'] = this.companyName;
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? mobilePhone;
  String? arabicName;
  String? city;
  String? date;

  Client(
      {this.id,
      this.name,
      this.mobilePhone,
      this.arabicName,
      this.city,
      this.date});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobilePhone = json['mobile_phone'];
    arabicName = json['arabic_name'];
    city = json['city'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_phone'] = this.mobilePhone;
    data['arabic_name'] = this.arabicName;
    data['city'] = this.city;
    data['date'] = this.date;
    return data;
  }
}

class Notes {
  int? id;
  String? note;
  String? attachment;
  String? date;
  int? contract;

  Notes({this.id, this.note, this.attachment, this.date, this.contract});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    attachment = json['attachment'];
    date = json['date'];
    contract = json['contract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['attachment'] = this.attachment;
    data['date'] = this.date;
    data['contract'] = this.contract;
    return data;
  }
}

class CurrentPhase {
  int? id;
  String? name;
  bool? isActive;
  String? startDate;
  String? endDate;
  int? contract;

  CurrentPhase(
      {this.id,
      this.name,
      this.isActive,
      this.startDate,
      this.endDate,
      this.contract});

  CurrentPhase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    isActive = json['isActive'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    contract = json['contract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['isActive'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['contract'] = this.contract;
    return data;
  }
}

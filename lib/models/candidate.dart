class Candidate {
  final String id;
  final String name;
  final String age;
  final String gender;
  final String subCategory; // job
  final String nationality;
  final String experience;
  final String salary;
  final String workerType;
  final String cvUrl;
  final String imageUrl;
  final String maritalStatus;
  final String religion;
  String category;
  String status;

  Candidate({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.subCategory,
    required this.nationality,
    required this.experience,
    required this.salary,
    required this.workerType,
    required this.cvUrl,
    required this.imageUrl,
    required this.maritalStatus,
    required this.religion,
    this.category = '',
    this.status = 'Available',
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    String job = json['job'] ?? '';
    String workerType = json['workerType'] ?? '';
    String cat;
    if (workerType == 'Returned Housemaids') {
      cat = 'Returned';
    } else {
      String jl = job.toLowerCase();
      if (jl.contains('maid') || jl.contains('domestic')) cat = 'House Maids';
      else if (jl.contains('cook')) cat = 'Cooks';
      else if (jl.contains('driver')) cat = 'Drivers';
      else if (jl.contains('nurse')) cat = 'Nurses';
      else if (jl.contains('teacher')) cat = 'Teachers';
      else cat = 'Recruitment';
    }
    return Candidate(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      subCategory: job,
      nationality: json['country'] ?? '',
      experience: json['experience'] ?? '',
      salary: json['salary'] ?? '',
      workerType: workerType,
      cvUrl: json['cv'] ?? '',
      imageUrl: json['pic'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      religion: json['religion'] ?? '',
      category: cat,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'gender': gender,
    'subCategory': subCategory,
    'nationality': nationality,
    'experience': experience,
    'salary': salary,
    'workerType': workerType,
    'cvUrl': cvUrl,
    'imageUrl': imageUrl,
    'maritalStatus': maritalStatus,
    'religion': religion,
    'category': category,
    'status': status,
  };
}
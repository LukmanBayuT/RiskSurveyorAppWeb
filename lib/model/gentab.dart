class GenTab{

  Future<List<String>> GetZone() async {
    return [
      'BEKASI',
      'JAKARTA BARAT',
      'JAKARTA PUSAT',
      'JAKARTA SELATAN',
      'JAKARTA TIMUR',
      'JAKARTA UTARA',
      'SUKABUMI',
      'TANGGERANG KOTA',
      'TANGGERANG SELATAN',
      'TANGGERANG UTARA',
      'VIRTUAL',
    ];
  }

  Future<List<String>> GetRelation() async {
    return [
      'Agent/Sales',
      'Broker',
      'Driver',
      'Family',
      'Garage',
      'Insured',
      'Leasing',
      'Others',
      'Policy Holder',
      'Staff',
    ];
  }

}
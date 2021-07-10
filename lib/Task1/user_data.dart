import 'package:practical_task/Task1/sqlite_Database.dart';

final dbHelper = SQLiteDatabase.instance;

class UserData {
  int id;
  String name;
  String username;
  String email;
  int addressId;
  Address address;
  String phone;
  String website;
  int companyId;
  Company company;

  UserData(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company,
        this.companyId,
        this.addressId
      });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
    companyId = json['idcompany'];
    if(companyId!=null)  fetchCompanyData();
    addressId = json['idaddress'];
    if(addressId!=null)  fetchAddressData();
  }

  fetchCompanyData()async{
    final companyData =await dbHelper.fetchCompanyData(companyId);
    company =Company.fromJson(companyData);
  }

  fetchAddressData()async{
    final addressData =await dbHelper.fetchAddressData(addressId);
    address =Address.fromJson(addressData);
  }

}


//Address class
class Address {
  String street;
  String suite;
  String city;
  String zipcode;

  Address({this.street, this.suite, this.city, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
  }

}

//company class
class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['companyname'];
    catchPhrase = json['catchphrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}

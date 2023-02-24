
class userModel {
  String? id;
  String? name;
  String? birthdate;
  String? email;
  String? image;
  bool? is_owner;
  int? deposit;
  String? phonenumber;
  String? owner_name;
  String? owner_image;
  int? owner_balance;
  String? owner_municipality;
  String? owner_address;
  String? owner_description;

  userModel(
      {this.id,
       this.name,
       this.birthdate,
       this.email,
       this.image,
       this.is_owner,
       this.deposit,
       this.phonenumber,
       this.owner_name,
       this.owner_image,
       this.owner_balance,
       this.owner_municipality,
       this.owner_address,
       this.owner_description
       });

  toJSON() {
    return {
      "name": name,
      "birthdate": birthdate,
      "email": email,
      "image": image,
      "is_owner": is_owner,
      "deposit" : deposit,
      "phone_number": phonenumber,
       "owner_name": owner_name,
       "owner_image": owner_image,
       "owner_balance": owner_balance,
       "owner_municipality": owner_municipality,
       "owner_address": owner_address,
       "owner_description": owner_description
    };
  }
}

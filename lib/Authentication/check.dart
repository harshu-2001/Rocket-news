class Check{
var name ,email,mob;
Check(this.name,this.email,this.mob);

Map<String, dynamic> toJson() {
    return {
      'Name': this.name,
      'Email': this.email,
      'Mobile': this.mob,
    };
  }

}
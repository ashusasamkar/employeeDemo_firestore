class Employee {
  int emp_id;
  String docId;
  String emp_fname;
  String emp_lname;
  String email_id;
  String post;
  String gender;
  String mobile_number;

  Employee(this.emp_id,
      {this.emp_fname,
      this.docId,
      this.emp_lname,
      this.email_id,
      this.post,
      this.gender,
      this.mobile_number});
}

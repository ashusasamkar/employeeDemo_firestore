import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/employee.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;

  static callSendDataService(Employee employee) {
    _firestore
        .collection('employee')
        .add({
          'emp_id': employee.emp_id,
          'emp_fname': employee.emp_fname,
          'emp_lname': employee.emp_lname,
          'email_id': employee.email_id,
          'post': employee.post,
          'gender': employee.gender,
          'mobile_number': employee.mobile_number
        })
        .then((value) => print('Message send firestore'))
        .catchError((error) => print('Failed to add/update data to Firestore'));
  }

  static updateEmployeeData(var docId, Employee emp) {
    _firestore
        .collection('employee')
        .doc(docId)
        .update({
          'emp_fname': emp.emp_fname,
          'emp_lname': emp.emp_lname,
          'gender': emp.gender,
          'email_id': emp.email_id,
          'post': emp.post,
          'mobile_number': emp.mobile_number
        })
        .then((value) => print('emp data updated'))
        .catchError(
            (onError) => print('Failed to update employee data :$onError'));
  }

  static Future<List<Employee>> getEmployeeList() async {
    List<Employee> empList = [];
    return _firestore
        .collection('employee')
        .orderBy('emp_id', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Employee emp = new Employee(doc['emp_id'],
            docId: doc.id,
            post: doc['post'],
            mobile_number: doc['mobile_number'],
            emp_fname: doc['emp_fname'],
            emp_lname: doc['emp_lname'],
            email_id: doc['email_id'],
            gender: doc['gender']);
        empList.add(emp);
      });
      return empList;
    });
  }
}

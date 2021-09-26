import 'package:flutter/material.dart';
import 'package:flutter_app/model/employee.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_app/view/create_update_empdata.dart';

class EmpList extends StatelessWidget {
  static const id = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee List')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUpdateEmpData(
                  isEdit: false),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: FirebaseService.getEmployeeList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Employee> employeeList = snapshot.data;
              return ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Employee employee = employeeList[index];
                  return Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shadowColor: Colors.black,
                    elevation: 10.0,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                          child: Text(employeeList[index].emp_fname[0])),
                      title: Text(
                          '${employeeList[index].emp_fname} ${employeeList[index].emp_lname}',
                          style: Theme.of(context).textTheme.headline3),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${employeeList[index].post}  (ID:${employeeList[index].emp_id})',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(employeeList[index].email_id,
                              style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateUpdateEmpData(
                                  isEdit: true, empData: employeeList[index]),
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateUpdateEmpData(
                                isEdit: true, empData: employeeList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

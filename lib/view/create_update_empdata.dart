import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/employee.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_app/view/emp_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUpdateEmpData extends StatefulWidget {
  static const id = 'createUpdateEmpData';
  final bool isEdit;
  final Employee empData;
  CreateUpdateEmpData({@required this.isEdit, this.empData});
  @override
  _CreateUpdateEmpDataState createState() => _CreateUpdateEmpDataState();
}

class _CreateUpdateEmpDataState extends State<CreateUpdateEmpData> {
  TextEditingController _fnController = TextEditingController();
  TextEditingController _lnController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _postController = TextEditingController();
  TextEditingController _emailIdController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _empIdController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var selected;

  Widget dropDown(List<String> list, String hint,
      {Function(String) onSaveValue}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: Colors.white)),
        fillColor: Theme.of(context).appBarTheme.backgroundColor,
        filled: true,
      ),
      dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
      validator: (value) {
        if (value == null) {
          return 'Please select the require field';
        } else
          return null;
      },
      onSaved: (value) {
        return onSaveValue(value);
      },
      value: selected,
      items: list
          .map((label) => DropdownMenuItem(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() => selected = value);
      },
    );
  }

  @override
  void initState() {
    if (widget.isEdit) {
      _fnController.text = widget.empData.emp_fname;
      _lnController.text = widget.empData.emp_lname;
      _genderController.text = widget.empData.gender;
      selected = widget.empData.post;
      _emailIdController.text = widget.empData.email_id;
      _mobileController.text = widget.empData.mobile_number;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _labelStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .merge(TextStyle(color: Colors.grey, fontSize: 15));

    return WillPopScope (
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, EmpList.id);
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New/Edit Employee'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  widget.isEdit
                      ? Text(
                          'Employee ID: ${widget.empData.emp_id}',
                          style: _labelStyle,
                        )
                      : TextFormField(
                          onSaved: (value) {
                            _empIdController.text = value;
                          },
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: _empIdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Employee ID',
                            labelStyle: _labelStyle,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid Employee ID';
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _fnController.text = value;
                    },
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: _fnController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: _labelStyle,
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 3) {
                        return 'Please enter valid first name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _lnController.text = value;
                    },
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: _lnController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: _labelStyle,
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 3) {
                        return 'Please enter valid last name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _emailIdController.text = value;
                    },
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: _emailIdController,
                    decoration: InputDecoration(
                      labelText: 'Email-ID',
                      labelStyle: _labelStyle,
                    ),
                    validator: (value) {
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter valid Email ID';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _mobileController.text = value;
                    },
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: _labelStyle,
                    ),
                    validator: (value) {
                      if (value.isEmpty ||
                          value.length < 10 ||
                          value.length > 10) {
                        return 'Please enter valid Mobile Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("Select Gender"),
                          content: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                ListTile(
                                  onTap: () {
                                    _genderController.text = "Male";
                                    Navigator.pop(context);
                                  },
                                  tileColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.1),
                                  dense: false,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: const EdgeInsets.all(0.0),
                                  title: Text(
                                    "Male",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                ListTile(
                                  onTap: () {
                                    _genderController.text = "Female";
                                    Navigator.pop(context);
                                  },
                                  tileColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.1),
                                  dense: false,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: const EdgeInsets.all(0.0),
                                  title: Text(
                                    "Female",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                ListTile(
                                  onTap: () {
                                    _genderController.text = "Other";
                                    Navigator.pop(context);
                                  },
                                  tileColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.1),
                                  dense: false,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: const EdgeInsets.all(0.0),
                                  title: Text(
                                    "Other",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        controller: _genderController, //gender
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid Gender';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _genderController.text = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Gender', labelStyle: _labelStyle),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Text(
                      'Designation',
                      style: _labelStyle,
                    ),
                    title: dropDown([
                      'Flutter Developer',
                      'General Manager',
                      'Consultant',
                      'Software Engineer'
                    ], 'Select Designation', onSaveValue: (String value) {
                      _postController.text = value;
                    }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        Fluttertoast.showToast(
                          msg: 'Please enter required fields.',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      } else {
                        _formKey.currentState.save();
                        if (widget.isEdit) {
                          FirebaseService.updateEmployeeData(
                              widget.empData.docId,
                              Employee(widget.empData.emp_id,
                                  email_id: _emailIdController.text,
                                  emp_fname: _fnController.text,
                                  emp_lname: _lnController.text,
                                  gender: _genderController.text,
                                  mobile_number: _mobileController.text,
                                  post: _postController.text));
                        } else {
                          FirebaseService.callSendDataService(Employee(
                              int.parse(_empIdController.text),
                              email_id: _emailIdController.text,
                              emp_fname: _fnController.text,
                              emp_lname: _lnController.text,
                              gender: _genderController.text,
                              mobile_number: _mobileController.text,
                              post: _postController.text));
                        }

                        Fluttertoast.showToast(
                            msg: 'Employee details saved!',
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            gravity: ToastGravity.CENTER);
                        Navigator.pushReplacementNamed(context, EmpList.id);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

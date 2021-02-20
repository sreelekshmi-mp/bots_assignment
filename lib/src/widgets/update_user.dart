import 'package:flutter/material.dart';

class UserUpdateForm extends StatefulWidget {
  static String tag = 'update-page';
  @override
  _UserUpdateFormFormState createState() => new _UserUpdateFormFormState();
}

class _UserUpdateFormFormState extends State<UserUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  int _id = 0;
  String _user_name = '';
  String _name = '';
  String _email = '';
  int _mobile_number = 0;
  String _website = '';
  bool _termsChecked = true;

  void onPressedSubmit() {
    if (_formKey.currentState.validate() && _termsChecked) {
      _formKey.currentState.save();
      print("ID " + _id.toString());
      print("Name " + _name);
      print("Email " + _email);
      print("Mobile Number " + _mobile_number.toString());
      print("Website " + _website);
      print("Termschecked " + _termsChecked.toString());
      Map updateData =
      {
        "id": _id,
        "name": _name,
        "username": _user_name,
        "email": _email,
        "address": {
          "street": "N.A",
          "suite": "N.A",
          "city": "N.A",
          "zipcode": "N.A",
          "geo": {
            "lat": "N.A",
            "lng": "N.A"
          }
        },
        "phone": _mobile_number,
        "website": _website,
        "company": {
          "name": "Sample Company",
          "catchPhrase": "Multi-layered client-server neural-net",
          "bs": "harness real-time e-markets"
        }
      };
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Add/Update User'),
      ),
      body: Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
        decoration: InputDecoration(labelText: 'Enter ID', hintText: 'ID'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a name';
          }
        },
        onSaved: (value) {
          setState(() {
            _id = int.tryParse(value);
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a name';
          }
        },
        onSaved: (value) {
          setState(() {
            _name = value;
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(labelText: 'Enter UserName', hintText: 'UserName'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a username';
          }
        },
        onSaved: (value) {
          setState(() {
            _user_name = value;
          });
        }));
    formWidget.add(new TextFormField(
        decoration:
        InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onSaved: (value) {
          setState(() {
            _email = value;
          });
        }));

    formWidget.add(new TextFormField(
        decoration: InputDecoration(labelText: 'Enter Phone Number', hintText: 'Phone Number'),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter Phone Number';
          }
        },
        onSaved: (value) {
          setState(() {
            _mobile_number = int.tryParse(value);
          });
        }));

    formWidget.add(new TextFormField(
        key: _passKey,
        decoration:
        InputDecoration(labelText: 'Enter Website', hintText: 'Website'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter Website';
          }
        }));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value;
        });
      },
      subtitle: !_termsChecked
          ? Text(
        'Required',
        style: TextStyle(color: Colors.red, fontSize: 12.0),
      )
          : null,
      title: new Text(
        'I agree to add/update user to server.',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Add/Update User'),
        onPressed: onPressedSubmit));

    return formWidget;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter mail';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GuestForm extends StatefulWidget {
  final User user;
  GuestForm(this.user);

  //final Function toggleView;
  //Register({this.toggleView});
  @override
  _GuestFormState createState() => _GuestFormState();
}

class _GuestFormState extends State<GuestForm> {

  final _formKey = GlobalKey<FormState>();//because they are dependence each other (the forms).

/*
  String email = '';
  String password = '';
  String Groom_name = ''; // hatan
  String Bride_name = ''; // kala
  */
  String index = UniqueKey().toString();
  String proximityGroup = '';
  String last_name = '';
  String first_name = '';
  int quantity_invited = 0;
  String phone_number = '';
  String error = " ";

  @override
  Widget build(BuildContext context) {
 //   final user = Provider.of<User>(context);
    return SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key: _formKey, // keep truck to our form, for validate.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Put in Group" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Proximity Group"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      proximityGroup = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Add last name please" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Last Name"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      last_name = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? "Add first name please" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "First name"),
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      first_name = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: numberValidator,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Quantity Invited"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      quantity_invited = num.parse(val);
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator:(val) =>
                  val.isEmpty ? "Add number please" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Phone number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      phone_number = val;
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.pink[52],
                  child: Text(
                    'Add Gueast',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final form = _formKey.currentState;
                    form.save();
                    if (form.validate()) //will check if our from is legit
                    {
                      dynamic result = await DatabaseService(uid: widget.user.uid)
                          .addGuestData(index, proximityGroup, last_name,
                              first_name, quantity_invited,phone_number);
                      Navigator.pop(context);
                      if (result == null) {
                        setState(() => error =
                            'Could not sign in with those credentials'); //TODO check
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String numberValidator(String value) {
  if (value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if (n == null) {
    return '"$value" is not a valid number';
  }
  return null;
}

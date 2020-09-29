import 'package:flutter/material.dart';
import 'package:eventapp/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String Groom_name = ''; // hatan
  String Bride_name = ''; // kala
  int number_of_messages = 0;
  String error = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
            backgroundColor: Colors.blue, //for the appbar
            elevation: 0.0, // elevation from the screen
            title: Text('Sign up'),
            actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text ('Sign in'),
            onPressed: (){
              widget.toggleView(); // this is how we call to the function
            },
    )
    ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context,
                BoxConstraints viewportConstraints) {
              return SingleChildScrollView( // wil help as to scroling down with no issuse
                padding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 22.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Form(
                      key: _formKey, // keep truck to our form, for validate.
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          TextFormField(
                            validator: (val) => val.isEmpty ? "Enter an email" : null,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                labelText: "Enter Email"
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),

                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          new Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            validator: (val) => val.length < 6 ? "Enter password longer then 6" : null,
                            decoration: InputDecoration(

                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                labelText: "Password"
                            ),
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                            obscureText: true, //for password
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          new Padding(padding: EdgeInsets.all(8.0)),
                          TextFormField(
                            validator: (val) => val.length < 2 ? "Enter valied name" : null,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                labelText: "Groom Name"
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),

                            onChanged: (val) {
                              setState(() {
                                Groom_name = val;
                              });
                            },
                          ),
                          new Padding(padding: EdgeInsets.all(8.0)),

                          TextFormField(
                            validator: (val) => val.length < 2 ? "Enter valied name" : null,
                            decoration: InputDecoration(

                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                labelText: "Bride Name"
                            ),
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                            onChanged: (val) {
                              setState(() {
                                Bride_name = val;
                              });
                            },
                          ),

                          RaisedButton(
                            color: Colors.pink[52],
                            child: Text('Register',

                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate())//will check if our from is legit
                                {
                                  dynamic result = await _auth.registerWithEmailAndPassword(email, password, Groom_name, Bride_name,number_of_messages);
                                  if(result == null){
                                      setState(() => error = 'Could not sign in with those credentials');//TODO check
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
                      )
                  ),

                ),
              );
            }
        )
    );
  }
}

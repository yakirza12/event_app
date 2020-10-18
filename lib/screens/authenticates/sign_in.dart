
import 'package:eventapp/services/auth.dart';
import 'package:eventapp/services/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../locator.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //final AuthService _auth  = AuthService();
  final AuthService _auth =  locator<AuthService>();
  final _formKey = GlobalKey<FormState>();// for validation

  //text field states

  String email = '';
  String password = '';
  String error = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /*
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,//for the appbar
        elevation: 0.0, // elevation from the screen
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text ('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],

      ),*/


      body:Column(
        children: <Widget>[
          Expanded(flex: 3,
            child: Container(

              decoration: BoxDecoration(
                
                image: DecorationImage(

                  image: AssetImage("assets/HappyPhoto.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

          ),
          Expanded( 
            flex: 3,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(
                        "SIGN IN",
                        style:Theme.of(context).textTheme.display1,

                        /* TextStyle(
                          color: Color(0xFFEF9A9A),
                          fontSize: 40,

                          fontWeight: FontWeight.w500
                        ),*/
                      ),
                      FlatButton(
                        child: Text ('SIGN UP',style: Theme.of(context).textTheme.button),
                        onPressed: (){
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.alternate_email,
                            color: kPrimaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Color(0xFFB0CBC4)),
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: TextStyle(color: Colors.black12)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16,top: 5),
                        child: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(

                         validator: (val) => val.length < 6 ? "Enter valied password" : null,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          obscureText: true, //for password
                           decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                hintText: 'Enter your Password',
                           // hintStyle: kHintTextStyle,
                           ),

                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Password',
                    //style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    //decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Password',
                        //hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                          child:IconButton(icon:  Icon(Icons.arrow_forward,
                                color: Color(0xFFEFEBE9)
                                ),   onPressed: () async {
                            if (_formKey.currentState.validate()) //will check if our from is legit
                                {
                                  print(email);
                                  print(password);
                              dynamic result = await _auth.sighinWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() =>
                                error =  'please suppp error on register'); //TODO check
                              }
                            }
                          })
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
        ],
      )








      /*Container(

        padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 50.0),

        child: Form(
          key: _formKey, // keep truck to our form, for validate. super importent!!!!!!!
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(23.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    labelText: "Enter Email"
                ),
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),

                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
             new Padding(padding:  EdgeInsets.all(8.0)),
              TextFormField(
                validator: (val) => val.length < 6 ? "Enter valied password" : null,
                decoration: InputDecoration(

                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(23.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    labelText: "Password"
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                obscureText: true, //for password
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              new Padding(padding:  EdgeInsets.all(8.0)),
              RaisedButton(
                color: Colors.pink[52],
                child: Text('Sign in to EEM',

                style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate())//will check if our from is legit
                      {
                      dynamic result = await _auth.sighinWithEmailAndPassword(email, password);

                    if(result == null) {
                      setState(() =>
                      error = 'please suppp error on register'); //TODO check
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

      ),*/
    );
  }
}

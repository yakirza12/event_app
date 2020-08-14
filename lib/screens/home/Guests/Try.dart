
/*
void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
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
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  validator: (val) => val.isEmpty ? "Put in Group" : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                        ),
                                      ),
                                      labelText: "Proximity Group"
                                  ),
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
                                        borderSide: new BorderSide(
                                        ),
                                      ),
                                      labelText: "Last Name"
                                  ),
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
                                  validator: (val) => val.isEmpty ? "Add first name please" : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                        ),
                                      ),
                                      labelText: "First name"
                                  ),
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
                                  validator: numberValidator ,
                                  decoration: InputDecoration(

                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(
                                        ),
                                      ),
                                      labelText: "Quantity Invited"
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters:  <TextInputFormatter>[
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

                                RaisedButton(
                                  color: Colors.pink[52],
                                  child: Text('Add Gueast',

                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if(_formKey.currentState.validate())//will check if our from is legit
                                        {
                                      dynamic result =  await DatabaseService(uid: user.uid).addGuestData(index,proximityGroup , last_name , first_name,quantity_invited);
                                      Navigator.pop(context);
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
                      ],
                    ),
                  );
                });
          },
          child: Text("Open Popup"),
        ),
      ),
    );
  }
}
*/

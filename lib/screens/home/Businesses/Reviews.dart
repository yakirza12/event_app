import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/auth.dart';
import 'package:eventapp/services/database.dart';
import 'package:flutter/material.dart';


class AddReviewForm extends StatefulWidget {
  final User _user;
  final String _name_of_business;
  final String _business_doc_id;
  AddReviewForm(this._user,this._name_of_business,this._business_doc_id);
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReviewForm> {
  AuthService _aute = AuthService();
  final _formKey = GlobalKey<FormState>();//because they are dependence each other (the forms).
  String index = UniqueKey().toString();
  String name_of_business = " ";
  String user_uid = " ";
  String business_doc_id = " ";
  String descreption =  " ";
  DateTime dateTime;
  int rate;

  String error = " ";

  @override
  Widget build(BuildContext context) {
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
                  minLines: 7,
                  maxLines: 12,
                  maxLength: 256,
                  validator: (val) => val.isEmpty ? "Fill it please" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Tap to fill Review Description"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      descreption = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                FormField<int>(
                  initialValue: 0,
                  autovalidate: true,
                  builder: (state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        StarRating(
                          onChanged: (val) {
                            setState(() {
                              rate = val;
                              state.didChange(val);
                            });
                          },
                          value: state.value,
                        ),
                        state.errorText != null
                            ? Text(state.errorText,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Theme.of(context).errorColor))
                            : Container(),
                      ],
                    );
                  },
              validator: (value) => value < 1 ? 'Rating too low' : null,

            ),
                RaisedButton(
                  color: Colors.pink[52],
                  child: Text(
                    'Add Review',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {

                    final form = _formKey.currentState;
                    form.save();
                    if (form.validate()) //will check if our from is legit
                        {
                      dynamic result = await DatabaseService(uid: widget._user.uid)
                          .addPhotographerReviews(index, widget._user.Groom_name,widget._name_of_business ,
                          widget._user.uid,widget._business_doc_id,descreption,DateTime.now(),rate);
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
    );;
  }
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;

  const StarDisplayWidget({
    Key key,
    this.value = 0,
    @required this.filledStar,
    @required this.unfilledStar,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key key, int value = 0})
      : super(
    key: key,
    value: value,
    filledStar: const Icon(Icons.star),
    unfilledStar: const Icon(Icons.star_border),
  );
}

class StarRating extends StatelessWidget {
  final void Function(int index) onChanged;
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;

  const StarRating({
    Key key,
    @required this.onChanged,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: onChanged != null
              ? () {
            onChanged(value == index + 1 ? index : index + 1);
          }
              : null,
          color: index < value ? color : null,
          iconSize: size,
          icon: Icon(
            index < value ? filledStar ?? Icons.star : unfilledStar ?? Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}


/*
class _GuestFormState extends State<GuestForm> {

  final _formKey = GlobalKey<FormState>();//because they are dependence each other (the forms).

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
*/
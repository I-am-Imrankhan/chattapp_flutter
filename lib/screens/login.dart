import 'package:flutter/material.dart';
import '../services/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();

  bool isDisabled = true;
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.addListener(_phoneController);
    _controllerFirstName.text = "";
    _controllerLastName.text = "";
    _controllerUserName.text = "";
  }

  void _phoneController() {
    print("phone number is filled now: ${_controllerPhone.text.length}");
    if (_controllerPhone.text.length == 9) {
      setState(() {
        isDisabled = false;
      });
    } /* else if (_controllerPhone.text.length < 10) {
      setState(() {
        isDisabled = true;
      });
    } */
  }

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _controller.dispose();
    _controllerPhone.dispose();
    _controllerUserName.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    //print("login rendered ******* :");
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
      ),
      body: Form(
        key: _formKey,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2!,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Center(
                            child: Text(
                              'Phone Authentication',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                          ),
                        ),
                        TextFormField(
                          /* validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                _controllerPhone.text.length < 10) {
                              setState(() {
                                print(
                                    "now the validator is working: ****** -ä_ÄÄÄÄÄÄÄÄÄ ");
                                isDisabled = true;
                              });
                              return 'Please provide your phone number!';
                            }
                            return null;
                          }, */
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text('+46'),
                            ),
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: _controllerPhone,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'First Name: ',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(''),
                            ),
                          ),
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          controller: _controllerFirstName,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Last Name?',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(''),
                            ),
                          ),
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          controller: _controllerLastName,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Username?',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(''),
                            ),
                          ),
                          maxLength: 15,
                          keyboardType: TextInputType.text,
                          controller: _controllerUserName,
                        ),
                        /* Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {},
                            child: const Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ), */
                        Container(
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: isDisabled
                                ? const TextButton(
                                    onPressed: null,
                                    child: Text('Must provide phone number'),
                                  )
                                : TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 32, 31, 27),
                                        primary: Colors.white,
                                        onSurface: Colors.red),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OTPScreen(
                                              _controllerPhone.text,
                                              _controllerFirstName.text,
                                              _controllerLastName.text,
                                              _controllerUserName.text,
                                              ),
                                        ),
                                      );
                                    },
                                    child: const Text('Next'),
                                  ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final bool isDisabled;
  final TextEditingController controllerPhone;
  final TextEditingController controllerUserName;
  final TextEditingController controllerFirstName;
  final TextEditingController controllerLastName;
  const NextButton(
      this.isDisabled,
      this.controllerPhone,
      this.controllerUserName,
      this.controllerFirstName,
      this.controllerLastName,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("NextButon $isDisabled");
    return isDisabled
        ? const TextButton(
            onPressed: null,
            child: Text('Must provide phone number'),
          )
        : TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 32, 31, 27),
                primary: Colors.white,
                onSurface: Colors.red),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => OTPScreen({
              //       'firstName': controllerFirstName,
              //       'lastName': controllerLastName,
              //       'userName': controllerUserName,
              //       'phoneNumber': controllerFirstName
              //     }),
              //   ),
              // );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OTPScreen(
                    controllerPhone.text,
                    controllerFirstName.text,
                    controllerLastName.text,
                    controllerUserName.text,
                  ),
                ),
              );
            },
            child: const Text('Next'),
          );
  }
}

/* class LoginModel {
  final String fName;
  final String flName;
  final String userName;
  final int phone;
  const LoginModel(this.fName, this.flName, this.userName, this.phone);
} */
/* 
Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
          ))
TextField(
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text('+46'),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: _controllerPhone,
                    ),
                    TextField(
                          decoration: const InputDecoration(
                            hintText: 'First Name: ',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(''),
                            ),
                          ),
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          controller: _controllerFirstName,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Last Name?',
                            prefix: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(''),
                            ),
                          ),
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          controller: _controllerLastName,
                        ),
                    
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Username?',
                        prefix: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(''),
                        ),
                      ),
                      maxLength: 15,
                      keyboardType: TextInputType.text,
                      controller: _controllerUserName,
                    ),
        
        Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen({
                          'firstName': _controllerFirstName,
                          'lastName': _controllerLastName,
                          'userName': _controllerUserName,
                          'phoneNumber': _controllerFirstName
                        })));
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
 */
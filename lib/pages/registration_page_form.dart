import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/model/user.dart';
import 'package:flutter_application_2/pages/user_info_page.dart';

class RegistrationPageForm extends StatefulWidget {
  @override
  _RegistrationPageFormState createState() => _RegistrationPageFormState();
}

class _RegistrationPageFormState extends State<RegistrationPageForm> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lifeController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  List<String> _countries = ['KAZ', 'RUS', 'UKR', 'GER', 'FRA'];
  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _countryFocus = FocusNode();
  final _lifeFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lifeController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _countryFocus.dispose();
    _lifeFocus.dispose();
    _passFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _fieldfocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldfocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              validator: _validateName,
              onSaved: (value) => newUser.name = value,
              decoration: InputDecoration(
                labelText: 'Your Name *',
                hintText: 'How people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldfocusChange(context, _phoneFocus, _emailFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Your phone number *',
                hintText: 'Where can we reach you',
                helperText: 'Phone format: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _phoneController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d -]{1,15}$'),
                  allow: true,
                ),
                LengthLimitingTextInputFormatter(15),
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Phone number must be entered as (XXX)XXX-XXXX',
              onSaved: (value) => newUser.phone = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _emailFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldfocusChange(context, _emailFocus, _countryFocus);
              },
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter a email address',
                prefixIcon: Icon(Icons.mail),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _emailController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => newUser.email = value,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              focusNode: _countryFocus,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?',
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(child: Text(country), value: country);
              }).toList(),
              onChanged: (data) {
                print(data);
                setState(() {
                  _selectedCountry = data;
                  newUser.country = data;
                });
                _fieldfocusChange(context, _countryFocus, _lifeFocus);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              onSaved: (value) => newUser.story = value,
              focusNode: _lifeFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldfocusChange(context, _lifeFocus, _passFocus);
              },
              controller: _lifeController,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about your life',
                helperText: 'This is just demo',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              maxLines: 2,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldfocusChange(context, _passFocus, _confirmFocus);
              },
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: Icon(
                    _hidePass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                icon: Icon(Icons.security),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _confirmFocus,
              controller: _confirmController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm the password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: Icon(
                    _hidePass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                icon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: _submitForm,
              child: Text('Submit form', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);
      print('Form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email Address: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Life story: ${_lifeController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
    _showValidMessage(message: 'Form is valid! Navigate to next Page!');
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String? input) {
    if (input == null) return false;
    final _PhoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _PhoneExp.hasMatch(input);
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) {
      return '8 characters required password';
    } else if (_confirmController.text != _passController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showValidMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showDialog({String? name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Registration successful',
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            '$name is now a verified register form',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserInfoPage(userInfo: newUser),
                  ),
                );
              },
              child: Text(
                'Verified',
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
            ),
          ],
        );
      },
    );
  }
}

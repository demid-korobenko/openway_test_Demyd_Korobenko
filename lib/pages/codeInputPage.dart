import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:openway_test/models/pinCode.dart';
import 'package:openway_test/widgets/pinDigit.dart';

class CodeInputPage extends StatefulWidget {
  @override
  _CodeInputPageState createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {

  final pinController = TextEditingController();
  FocusNode pinInputFocus = FocusNode();

  _CodeInputPageState() {pinController.addListener(_pinHandler);}

  _pinHandler() {
    print(pinController.text);
    Provider.of<PinCodeModel>(context, listen: false).setValue(pinController.text);
  }


// Pin code visualisation block. Combined into common widget for ease of use, but can be replaced with single widget for each digit
  Widget pinBloc(int length, String pin, double width)  {
    double digitWidth = width/length;
    List<Widget> pinDigits =[];

    for (int i = 0; i < length; i++) {
      if (i < pin.length) {
        pinDigits.add(PinDigit(value: pin[i], width: digitWidth));
      } else
        pinDigits.add(PinDigit(value: '●', width: digitWidth));
    }

    return GestureDetector(
      child: Center(
        child: Container(
//            color: Colors.blue,
            child: Row(children: pinDigits)),
      ),
      onTap: () {
        pinController.text = Provider.of<PinCodeModel>(context, listen: false).getValue();
        // Re-request a keyboard call if it was hidden by 'back' button without losing focus node
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 1), () {FocusScope.of(context).requestFocus(pinInputFocus);});

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Pin code verification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Provider.of<PinCodeModel>(context).isVerified()
              ? Text('Verification complete', style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.green))
              : Text('Enter pin code to verify', style: Theme.of(context).textTheme.headline1,)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // Hide text input field
                  width: 0,
                  // According to the test task, it was required to separate only visualisation widgets,
                  // but if needed - single input field can be easily divided into several separate ones
                  // from which the value of the pin code will be generated
                  child: TextFormField(
                    onEditingComplete: (){
                      Provider.of<PinCodeModel>(context, listen: false).verify(context);
                      FocusScope.of(context).unfocus();
                      },
                    focusNode: pinInputFocus,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    showCursor: false,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                    maxLength: Provider.of<PinCodeModel>(context, listen: false).length(),
                  ),
                ),
                // Pin code visualisation widget. Redirects taps to hidden text input fields
                pinBloc(
                    Provider.of<PinCodeModel>(context).length(),
                    Provider.of<PinCodeModel>(context).getValue(),
                    (MediaQuery.of(context).size.width)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

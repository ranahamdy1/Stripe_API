import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stripe/stripe_payment/payment_manager.dart';

class MyFirstScreen extends StatelessWidget {
  const MyFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: ()async {
                  PaymentManager p = PaymentManager();
                 await p.makePayment(20, "EGP");
                },
                child: Text("Pay ")
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/stripe_payment/stripe_keys.dart';

class PaymentManager{

  Future<void>makePayment(int amount,String currency)async{
    try {
      await Stripe.instance.applySettings();
      var jsonData = await getData((amount).toString());
      // String clientSecret=await _getClientSecret(key , (amount*100).toString(), currency);
      // await _initializePaymentSheet(clientSecret);
      await _initializePaymentSheet2(jsonData);
      // await Stripe.instance.confirmPaymentSheetPayment();
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void>_initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "RANA",
      ),
    );
  }   Future<void>_initializePaymentSheet2(jsonData)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonData['client_secret_key'],
        merchantDisplayName: "RANA",
        customerId: jsonData['customer'],
        customerEphemeralKeySecret: jsonData['ephemeralKey'],
      ),
    );
  }

  Future<String> _getClientSecret(String secretKey,String amount,String currency)async{
    Dio dio=Dio();
    print('Bearer $secretKey');
    var response= await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          // 'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    print(response.data);
    return response.data["client_secret"];
  }
   Future getData(String amount)async{
    Dio dio=Dio();
    var response= await dio.post(
      'https://19fd-197-43-13-71.ngrok-free.app/api/payment/intent',
      options: Options(
        headers: {
          'Authorization': 'Bearer 7|CUr7dLRFEneRXlaDBavhHafVuIu2iorNYwmeeChz7efc5d2b',
          // 'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount
      },
    );
    print(response.data);
    return response.data;
  }

}
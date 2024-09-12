import 'package:dio/dio.dart';
import 'package:food_recipes/core/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  Future<String> getPaymentKey(
      {required int amount, required String currency}) async {
    String authToken = await _getAuthToken();
    int orderId = await _getOrderId(
      authToken: authToken,
      amount: (amount * 100).toString(),
      currency: currency,
    );
    String paymentKey = await _getPaymentKey(
      amount: (amount * 100).toString(),
      currency: currency,
      authToken: authToken,
      orderId: orderId.toString(),
    );
    return paymentKey;
  }

  Future<String> _getAuthToken() async {
    Response response = await Dio().post(
        'https://accept.paymob.com/api/auth/tokens',
        data: {"api_key": apiKey});
    return response.data['token'];
  }

  Future<int> _getOrderId({
    required String authToken,
    required String amount,
    required String currency,
  }) async {
    Response response = await Dio()
        .post('https://accept.paymob.com/api/ecommerce/orders', data: {
      "auth_token": authToken,
      "amount_cents": amount, // String
      "currency": currency, // Not Required
      "delivery_needed": "false",
      "items": [],
    });
    return response.data['id'];
  }

  Future<String> _getPaymentKey({
    required String authToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    Response response = await Dio()
        .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
      "auth_token": authToken,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": orderId, // String
      "currency": currency,
      "integration_id": integrationId,
      "billing_data": {
        "email": "claudette09@exa.com",
        "first_name": "Clifford",
        "last_name": "Nicolas",
        "phone_number": "+86(8)9135210487",
        // Can be NA
        "apartment": "NA",
        "floor": "NA",
        "street": "NA",
        "building": "NA",
        "shipping_method": "NA",
        "postal_code": "NA",

        "city": "NA",
        "country": "NA",
        "state": "NA"
      },
    });
    return response.data['token'];
  }

  getPaymentCallback() {
    return pay;
  }

 void pay({required String paymentKey}) async {
    await launchUrl(
      Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/867318?payment_token=$paymentKey'),
    );
  }
}

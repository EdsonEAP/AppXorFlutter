import 'package:appxor/src/Utils/internet.dart';

class LoginService {
//->S service
  //service para logear el usuario ´pass and user´
  Future xorS({required String x1, required String x2}) async {
    Map<String, dynamic> body = {
      'x1': int.parse(x1),
      'x2': int.parse(x2),
    };
    print("Envio al servicio-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://jairomendozawithedsonalvarado.pythonanywhere.com/",
        body: body);
    print("Resultado del servicio....$response");
    // LoginM.fromJson(response);

    return response;
  }
}

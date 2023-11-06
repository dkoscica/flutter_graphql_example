import 'package:ferry/ferry.dart';

class ApiService {
  final Client _client;

  ApiService({required Client client}) : _client = client;

  Stream<OperationResponse<TData, TVars>> request<TData, TVars>(
    OperationRequest<TData, TVars> request, [
    NextTypedLink<TData, TVars>? forward,
  ]) {
    return _client.request(request, forward);
  }
}

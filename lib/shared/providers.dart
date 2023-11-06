import 'package:ferry/ferry.dart';
import 'package:flutter_graphql_example/feature/home/github_repository.dart';
import 'package:flutter_graphql_example/shared/api_service.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final graphQLClientProvider = Provider<Client>((ref) {
  const token = String.fromEnvironment('GITHUB_TOKEN');
  final Map<String, String> headers = {
    "Authorization": "Bearer $token",
  };
  final link = HttpLink("https://api.github.com/graphql", defaultHeaders: headers);
  return Client(link: link);
});

final apiServiceProvider =
    Provider<ApiService>((ref) => ApiService(client: ref.watch(graphQLClientProvider)));

final githubRepositoryProvider =
    Provider<GitHubRepository>((ref) => GitHubRepository(ref.watch(apiServiceProvider)));

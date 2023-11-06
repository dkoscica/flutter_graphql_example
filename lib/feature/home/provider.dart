import 'package:flutter_graphql_example/feature/home/graphql/__generated__/get_repository_details.data.gql.dart';
import 'package:flutter_graphql_example/shared/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RepositoryParams {
  const RepositoryParams({required this.owner, required this.name});

  final String owner;
  final String name;
}

final repositoryDetailsProvider = FutureProvider.autoDispose
    .family<GGetRepositoryDetailsData_repository?, RepositoryParams>((ref, params) async {
  final gitHubRepository = ref.watch(githubRepositoryProvider);
  final repositoryDetails = await gitHubRepository.getRepositoryDetails(params.owner, params.name);
  return repositoryDetails;
});

final repositoryIdProvider = Provider.autoDispose.family<String?, RepositoryParams>((ref, params) {
  final repositoryDetails = ref.watch(repositoryDetailsProvider(params));
  return repositoryDetails.maybeWhen(
    data: (data) => data?.id,
    orElse: () => null,
  );
});

import 'package:ferry/typed_links.dart';
import 'package:flutter_graphql_example/feature/home/graphql/__generated__/create_issue.data.gql.dart';
import 'package:flutter_graphql_example/feature/home/graphql/__generated__/create_issue.req.gql.dart';
import 'package:flutter_graphql_example/feature/home/graphql/__generated__/get_repository_details.data.gql.dart';
import 'package:flutter_graphql_example/feature/home/graphql/__generated__/get_repository_details.req.gql.dart';
import 'package:flutter_graphql_example/shared/api_service.dart';
import 'package:loggy/loggy.dart';

class GitHubRepository {
  final ApiService _apiService;

  GitHubRepository(this._apiService);

  @override
  Future<GGetRepositoryDetailsData_repository?> getRepositoryDetails(
      String owner, String name) async {
    try {
      final request = GGetRepositoryDetailsReq(
        (b) => b
          ..vars.owner = owner
          ..vars.name = name
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      );
      final response = await _apiService.request(request).first;
      return response.data?.repository;
    } catch (e) {
      logError(e);
      return null;
    }
  }

  @override
  Future<GCreateIssueData_createIssue_issue?> createIssue(
    String repositoryId,
    String title,
    String body,
  ) async {
    try {
      final request = GCreateIssueReq((b) => b
        ..vars.repositoryId = repositoryId
        ..vars.title = title
        ..vars.body = body);
      final response = await _apiService.request(request).first;
      return response.data?.createIssue?.issue;
    } catch (e) {
      logError(e);
      return null;
    }
  }
}

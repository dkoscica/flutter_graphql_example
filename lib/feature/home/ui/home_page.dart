import 'package:flutter/material.dart';
import 'package:flutter_graphql_example/shared/providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../graphql/__generated__/create_issue.data.gql.dart';
import '../provider.dart';

/// Adjust these values to your own repository
const repositoryParams = RepositoryParams(owner: 'dkoscica', name: 'shake');

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const UserDetailsSection(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(width: double.infinity, height: 1, color: Colors.grey),
          ),
          const CreateIssueSection(),
        ],
      ),
    );
  }
}

class UserDetailsSection extends HookConsumerWidget {
  const UserDetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryDetails = ref.watch(repositoryDetailsProvider(repositoryParams));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Heading(title: 'GetRepositoryDetails Query'),
        repositoryDetails.when(
          data: (data) => data != null
              ? Column(
                  children: [
                    Text('Id: ${data.id}'),
                    Text('Name: ${data.name}'),
                    Text('Username: ${data.description}'),
                  ],
                )
              : const Text('No user found'),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}

class CreateIssueSection extends HookConsumerWidget {
  const CreateIssueSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryId = ref.watch(repositoryIdProvider(repositoryParams));
    const title = "Some title";
    const body = "Some body";
    final createdIssueState = useState<GCreateIssueData_createIssue_issue?>(null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Heading(title: 'Create Issue Mutation'),
        if (createdIssueState.value != null) ...[
          Text('Id: ${createdIssueState.value!.id}'),
          Text('Title: ${createdIssueState.value!.title}'),
          Text('Body: ${createdIssueState.value!.bodyText}'),
        ] else
          const Text('No issue created yet'),
        ElevatedButton(
          onPressed: () async {
            if (repositoryId == null) {
              return;
            }

            final createdIssue =
                await ref.read(githubRepositoryProvider).createIssue(repositoryId, title, body);
            if (createdIssue != null) {
              createdIssueState.value = createdIssue;
            }
          },
          child: const Text('Create Issue'),
        ),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      );
}

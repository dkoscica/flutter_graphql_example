# flutter_graphql_example

Futter Graphql example description

## Getting Started

[Install fvm](https://fvm.app/)

In the run settings define the following environment variables:
```console
--dart-define GITHUB_TOKEN=your_github_token
```

Run the following command to generate the graphql files:
```console
fvm flutter pub run build_runner build --delete-conflicting-outputs
```
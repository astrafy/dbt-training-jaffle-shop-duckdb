# dbt demo

This repository is a playground to learn how to use dbt and to test new features. It contains
the famous jaffle shop data product from dbt labs. The repository has evolved from the original
code you will find on the official dbt labs github page as we have extended with new features,
packages, macros, etc.

This repository is not linked to a Gitlab CI pipelien on purpose as goal is to experiment
quickly.

## Quickstart

1. Create a python virtual environment in python 3.10.5 named "venv_dbt_demo" by following the
instruction on this [Gitbook page](https://astrafy.gitbook.io/technical-cookbook/python/local-development/python-setup-pyenv)
2. Install the required dependencies by running the following at the root of the repo:
```poetry install```
3. Assign the dbt profiles from this repository by running the following commands:
```
cd dbt
dbt_profile_assign $(pwd)
```
You need to have the function defined in your .zshrc profile. You can find instructions on this
[Gitbook page](https://astrafy.gitbook.io/data/dbt/configuration)
4. Activate your Google Cloud account by running the following command:
```commandline
gcloud-activate default
```
You need to have the function defined in your .zshrc profile. You can find instructions on this
[Gitbook page](https://astrafy.gitbook.io/google-cloud/configuration/authentication)

You also need to have initialized beforehand gcloud with a default account. You can do this by running
the following command:
```gcloud init```
5. You are now ready to run dbt commands within the dbt repository.

This dbt project comes with two targets:

- **sbx** target: it will materialize the models in the sandbox datasets with your $USER prepended to the table names (either file name or alias defined in config)
- **prd** target: it will materialize the models in the prd datasets with the vanilla table names (either file name or alias defined in config)

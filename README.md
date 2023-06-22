# dbt training - Astrafy

This repository is a playground to learn how to use dbt and to test new features. It contains
the famous jaffle shop data product from dbt labs. The repository has evolved from the original
code you will find on the official dbt labs github page as it is extended with new features,
packages, macros, etc.


<p align="center" width="100%">
    <img width="25%" src="https://seeklogo.com/images/D/dbt-logo-500AB0BAA7-seeklogo.com.png">
    <img width="25%" src="https://cdn-images-1.medium.com/max/1200/1*0jrqkgFv3U142GxAjUYfMg.png">
</p>


## Quickstart

You can use this repository with `duckdb` or with `bigquery`. 
Use `duckdb` if you want test `dbt` in general. 
It requires less setup, works locally on your machine and is a lot faster.
Use `bigquery` if you want to see `dbt` in action on Google Cloud or you need features there are not yet supported by `duckdb` adapter.

<details>
<summary>DuckDB</summary>

### `duckdb` quickstart

1. Create a python virtual environment in python 3.10 named "venv_dbt_training" 

2. Install the required dependencies by running the following at the root of the repo:
```
poetry install --with duckdb
```

3. Assign the dbt profiles from this repository by running the following commands:
```
cd dbt
export DBT_PROFILES_DIR=$(pwd)
```

4. You are now ready to run dbt commands within the dbt repository.

You can run:

- `dbt deps` to download dependencies
- `dbt seed` to populate the initial tables with local data (instead of using sources)
- `dbt compile` to compile your dbt project
- `dbt run|test|build` to execute and test models

Note that dbt project comes with one `duckdb` target (others relate to `bigquery`):

- **local** target: it will materialize the models in the `db.duckdb` file database. You can access it via `duckcli -D db.duckdb` command.

By default, the **local** target is selected.

</details>
<details>
<summary>BigQuery</summary>

### `bigquery` quickstart
1. Create a python virtual environment in python 3.10 named "venv_dbt_training" 

2. Install the required dependencies by running the following at the root of the repo:
```
poetry install --with bigquery
```

3. Assign the dbt profiles from this repository by running the following commands:
```
cd dbt
export DBT_PROFILES_DIR=$(pwd)
```

4. Activate your Google Cloud account by running the following command:
```
gcloud auth login
gcloud auth application-default
```

You also need to have initialized beforehand gcloud with a default account. You can do this by running
the following command:
```
gcloud init
```

5. Set the following environment variable to your Google Cloud project where the tables from this dbt repo will 
be written to:

```
export GCP_PROJECT=[Google Cloud Project ID that dbt will use]
```

6. You are now ready to run dbt commands within the dbt repository.

You can run:

- `dbt deps` to download dependencies
- `dbt seed -t sbx` to populate the initial tables with local data (instead of using sources)
- `dbt compile -t sbx` to compile your dbt project
- `dbt run|test|build -t sbx` to execute and test models

This dbt project comes with two `bigquery` targets:

- **sbx** target: it will materialize the models in the sandbox datasets with your $USER prepended to the table names (either file name or alias defined in config)
- **prd** target: it will materialize the models in the prd datasets with the vanilla table names (either file name or alias defined in config)

You will need to specify target explicitly while running the commands, because by default, the **local** target is selected (see duckdb section for more info).


</details>

### Elementary package:

For `Elementary` instructions and code see `elementary` branch.
The mainstream repository works with `duckdb` which is not supported by `elementary` yet.

### Additional references

- [dbt official documentation](https://docs.getdbt.com/)
- [dbt free courses](https://courses.getdbt.com/collections)
- [dbt at scale on Google Cloud](https://medium.com/astrafy/dbt-at-scale-on-google-cloud-part-1-54f8655443a7)
- [Top dbt packages pick](https://medium.com/astrafy/our-top-dbt-packages-pick-fad02e98eac6)

dbt slack workspace:
- Join the dbt slack workspace:  https://getdbt.slack.com 


### Feedback

If you have attended a training from Astrafy on dbt with this repository as material support, please take 5 minutes to
answer a few questions via [this link](https://astrafy.typeform.com/to/mFbRuPLB#hubspot_utk=xxxxx&hubspot_page_name=xxxxx&hubspot_page_url=xxxxx).


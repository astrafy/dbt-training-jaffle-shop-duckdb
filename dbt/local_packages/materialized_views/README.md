## dbt_labs_materialized_views

`dbt_labs_materialized_views` is a dbt project containing materializations, helper macros, and some builtin macro overrides that enable use of materialized views in your dbt project. It takes a conceptual approach similar to that of the existing `incremental` materialization:
- In a "full refresh" run, drop and recreate the MV from scratch.
- Otherwise, "refresh" the MV as appropriate. Depending on the database, that could require DML (`refresh`) or no action.

At any point, if the database object corresponding to a MV model exists instead as a table or standard view, dbt will attempt to drop it and recreate the model from scratch as a materialized view.

Materialized views vary significantly across databases, as do their current limitations. Be sure to read the documentation for your adapter.

If you're here, you may also like the [dbt-materialize](https://github.com/MaterializeInc/dbt-materialize) plugin, which enables dbt to materialize models as materialized views in [Materialize](https://materialize.io/).

## Setup

You can:
- Install this project as a local package (as in the [integration tests](integration_tests/packages.yml))
- Copy-paste the files from `macros/` (specifically `default` and your adapter) into your own project

## BigQuery

- Supported model configs: `auto_refresh`, `refresh_interval_minutes`
- [docs](https://cloud.google.com/bigquery/docs/materialized-views-intro)
- ❗ Although BQ does not have `drop ... cascade`, if the base table of a MV is dropped and recreated, the MV also needs to be dropped and recreated:
```
Mate

 # `02-create-data-model` branch
 ## Create the models including validations and tests
- [ ] You should use `Postgres` as your _database_.
- [ ] You should `validate` all user `input` to make sure that anyone with bad intentions cannot compromise your app.
- [ ] **Create** your `model`s according to the following ERD diagram.
  > <img width="374" alt="erd_diagram" src="https://ik.imagekit.io/dqd3uh1at/budget-app/erd/erd_diagram.png?updatedAt=1707740376788">
- [ ] Your _database_ `schema` should reflect the above structure.
  > NOTE: do not change _column names_ visible in the diagram. You need to change the **"Entity"**  name according to the _theme you have chosen_ for your **project** (please note: "_Transaction_" is a name already used by `ActiveRecord`, so using it as a name for your `model` and `table` will result in an _error_).

----
- [ ] **Create** `unit` and `integration` **tests** for all the most _important components_ of your RoR application.
# Music Library Database App

## Learning how to test drive routes with a database

1. I cloned the project from [this repo](https://github.com/makersacademy/web-applications/tree/main/resources "link to repo").

2. Create a database. The database music_library already existed so I skipped this bit. The test database music_library_test has also been created.

```
createdb music_library
```
3. To setup the program:
```
cd music_library_database_app

bundle install

# Make sure the tests pass
rspec

# Run the web server
rackup
```
I created this [Get Albums Route Recipe](link here "Get Albums Route Recipe") using this [Design Recipe](https://github.com/makersacademy/web-applications/blob/main/resources/sinatra_route_design_recipe_template.md "Design Recipe Template") template.
# Music Library Database App

## Learning how to test drive routes with a database

1. I cloned the project from [this repo](https://github.com/makersacademy/web-applications/tree/main/resources "link to repo").

2. Creat a database. I already had one called music_library so I called this music_library_2.

```
createdb music_library_2
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
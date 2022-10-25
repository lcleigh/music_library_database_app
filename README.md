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
I created this [Get Albums Route Recipe](https://github.com/lcleigh/music_library_database_app/blob/main/get_albums_route_recipe.md "Get Albums Route Recipe") using this [Design Recipe](https://github.com/makersacademy/web-applications/blob/main/resources/sinatra_route_design_recipe_template.md "Design Recipe Template") template.

I then followed the video and test drove a GET /albums route. 

Tasks:

1. I have Test Driven a route for POST /albums to create a new album.

2. I have Test Driven a route for GET /artists to get a list of all artists.

3. I have Test Driven a route for POST /artists to create a new artist.
___
## Learn to return HTML responses to be viewed in a web browser

In the project I created a directory called views and in there a file called index.erb. This is where the html is stored.

***erb is and embedded Ruby***

The tests for the html file go in application_spec.rb also.
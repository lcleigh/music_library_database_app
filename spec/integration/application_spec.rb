require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end


describe Application do

  before(:each) do 
    reset_albums_table
    reset_artists_table
  end
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'GET /albums' do

      it "should return the list of albums as a HTML page" do
        response = get('/albums')

        expect(response.status). to eq 200
        expect(response.body).to include '<h1>Albums</h1>'
        expect(response.body).to include '<a href="/albums/2">Surfer Rosa</a>'
        expect(response.body).to include '<a href="/albums/3">Waterloo</a>'
        expect(response.body).to include '<a href="/albums/7">Folklore</a>'
      end
  end

  context 'GET /albums/:id' do
    it "returns the album info with id 1" do
      response = get('/albums/1')

      expect(response.status). to eq 200
      expect(response.body).to include '<h1>Doolittle</h1>'
      expect(response.body).to include 'Release year: 1989'
      expect(response.body).to include 'Artist: Pixies'
    end

    it "returns the album info with id 2" do
      response = get('/albums/2')

      expect(response.status). to eq 200
      expect(response.body).to include '<h1>Surfer Rosa</h1>'
      expect(response.body).to include 'Release year: 1988'
      expect(response.body).to include 'Artist: Pixies'
    end
  end

  context "GET /albums/new" do
    it 'returns the form page to add a new album' do
      response = get('/albums/new')
  
      expect(response.status).to eq(200)
      
      expect(response.body).to include '<h1>Add an Album</h1>'
      # Assert we have the correct form tag with the action and method.
      expect(response.body).to include '<form action="/albums" method="POST">'
      expect(response.body).to include '<input type="text" name="title">'
      expect(response.body).to include '<input type="text" name="release_year">'
      expect(response.body).to include '<input type="text" name="artist_id">'
  
      # We can assert more things, like having
      # the right HTML form inputs, etc.
    end
  end


  context 'POST /albums' do

    it "should validate album parameters" do
      response = post('/albums', invalid_artist_title: "Ok Computer", another_invalid_thing: 123)

      expect(response.status).to eq 400
    end

    it "returns a sucess page & creates a new album" do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

      
      expect(response.status).to eq 200
      expect(response.body).to include 'Your Album has been added.'

      response = get('/albums')

      expect(response.body).to include 'Voyage'
    end
  end


  context 'GET /artists' do
    it "should return the list of artists as a html page with links" do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Artists</h1>'
      expect(response.body).to include '<div>Name: <a href="/artists/1">Pixies</a></div>'
      expect(response.body).to include '<div>Name: <a href="/artists/2">ABBA</a></div>'
      expect(response.body).to include '<div>Name: <a href="/artists/3">Taylor Swift</a></div>'
      expect(response.body).to include '<div>Name: <a href="/artists/4">Nina Simone</a></div>'
    end

  end

  context 'GET /artists/:id' do
    it 'returns the artist infro with id 1' do
      response = get('/artists/1')

      expect(response.status). to eq 200
      expect(response.body).to include '<h1>Pixies</h1>'
      expect(response.body).to include 'Genre: Rock'
    end

    it 'returns the artist infro with id 3' do
      response = get('/artists/3')

      expect(response.status). to eq 200
      expect(response.body).to include '<h1>Taylor Swift</h1>'
      expect(response.body).to include 'Genre: Pop'
    end

  end

  context 'POST /artists' do
    it "should create a new artist" do
      response = post('/artists', name: 'Wild Nothing', genre: 'indie')

      
      expect(response.status).to eq 200
      expect(response.body).to eq ''

      response = get('/artists')

      expect(response.body).to include 'Wild Nothing'
    end
  end

end

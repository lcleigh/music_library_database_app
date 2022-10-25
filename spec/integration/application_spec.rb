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

  context 'GET /' do
    it 'returns the html index' do
      response = get('/')

      expect(response.body).to include '<h1>Hello!</h1>'
      # <img scr="hello.jpg"/>
      expect(response.body).to include '<img scr="hello.jpg"/>'
    end
  end


  context 'GET /albums' do
      it "should return the list of albums" do
        response = get('/albums')

        expected_response = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

        expect(response.status).to eq 200
        expect(response.body).to eq expected_response
      end
  end

  context 'POST /albums' do
    it "should create a new album" do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

      
      expect(response.status).to eq 200
      expect(response.body).to eq ''

      response = get('/albums')

      expect(response.body).to include 'Voyage'
    end
  end

  context 'GET /artists' do
    it "should return the list of artists" do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone'

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
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

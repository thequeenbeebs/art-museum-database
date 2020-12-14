Artist.destroy_all
Museum.destroy_all
Painting.destroy_all

van_gogh = Artist.create(name: "Vincent van Gogh", birth_year: 1853, death_year: 1890, nationality: "Dutch", style: "post-impressionism", img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg/800px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg" )
monet = Artist.create(name: "Claude Monet", birth_year: 1840, death_year: 1926, nationality: "French", style: "impressionism", img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Claude_Monet_1899_Nadar_crop.jpg/800px-Claude_Monet_1899_Nadar_crop.jpg" )
picasso = Artist.create(name: "Pablo Picasso", birth_year: 1881, death_year: 1973, nationality: "Spanish", style: "cubism", img_url: "https://www.biography.com/.image/t_share/MTY2NTIzNTAyNjgwMDg5ODQy/pablo-picasso-at-his-home-in-cannes-circa-1960-photo-by-popperfoto_getty-images.jpg" )
leonardo = Artist.create(name: "Leonardo da Vinci", birth_year: 1452, death_year: 1519, nationality: "Italian", style: "high renaissance", img_url: "https://s.abcnews.com/images/International/Leonardo-da-vinci-file-gty-ml-190502_hpMain_1x1_992.jpg" )
rembrandt = Artist.create(name: "Rembrandt", birth_year: 1606, death_year: 1669, nationality: "Dutch", style: "baroque", img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Rembrandt_van_Rijn_-_Self-Portrait_-_Google_Art_Project.jpg/1200px-Rembrandt_van_Rijn_-_Self-Portrait_-_Google_Art_Project.jpg" )
dali = Artist.create(name: "Salvador Dali", birth_year: 1904, death_year: 1989, nationality: "Spanish", style: "surrealism", img_url: "https://uploads5.wikiart.org/images/salvador-dali.jpg!Portrait.jpg")

moma = Museum.create(name: "Museum of Modern Art", location: "New York City, USA")
met = Museum.create(name: "The Metropolitan Museum of Art", location: "New York City, USA")
louvre = Museum.create(name: "Louvre Museum", location: "Paris, France")
rijk = Museum.create(name: "Rijkmuseum", location: "Amsterdam, Netherlands")

Painting.create(name: "The Starry Night", year: 1889, artist_id: van_gogh.id, museum_id: moma.id, img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg")
Painting.create(name: "Bridge over the Lily Pond", year: 1899, artist_id: monet.id, museum_id: met.id, img_url:"https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/The_Water-Lily_Pond_1899_Claude_Monet_Metropolitan.jpg/800px-The_Water-Lily_Pond_1899_Claude_Monet_Metropolitan.jpg")
Painting.create(name: "Les Demoiselles d'Avignon", year: 1907, artist_id: picasso.id, museum_id: moma.id, img_url: "https://uploads1.wikiart.org/images/pablo-picasso/the-girls-of-avignon-1907.jpg" )
Painting.create(name: "Mona Lisa", year: 1503, artist_id: leonardo.id, museum_id: louvre.id, img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/1200px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg")
Painting.create(name: "The Night Watch", year: 1642, artist_id: rembrandt.id, museum_id: rijk.id, img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/The_Night_Watch_-_HD.jpg/1200px-The_Night_Watch_-_HD.jpg")
Painting.create(name: "The Persistence of Memory", year: 1931, artist_id: dali.id, museum_id: moma.id, img_url: "https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg")

@base_url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/" 

met_ids = [436528,436534,435683,841285,437052,360751,360715,485518,436576,325688,310870,322861,324290,335240,437763]

met_ids.each do |id|
    uri = URI.parse(@base_url + id.to_s)
    response = Net::HTTP.get_response(uri)
    item = JSON.parse(response.body)
    artist = Artist.find_or_create_by(name: item["artistDisplayName"], nationality: item["artistNationality"], birth_year: item["artistBeginDate"], death_year: item["artistEndDate"])
    Painting.create(
        name: item["title"],
        artist_id: artist.id,
        year: item["objectEndDate"],
        img_url: item["primaryImage"],
        museum_id: met.id
    )
end



puts "seed file ran"
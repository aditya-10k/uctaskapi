import requests
import pandas as pd
import time

API_KEY = "f3a1f216"

imdb_ids_with_name = [
    ["The Shawshank Redemption", "tt0111161"],
    ["The Godfather", "tt0068646"],
    ["The Dark Knight", "tt0468569"],
    ["The Godfather Part II", "tt0071562"],
    ["12 Angry Men", "tt0050083"],
    ["Schindler's List", "tt0108052"],
    ["The Lord of the Rings: The Return of the King", "tt0167260"],
    ["Pulp Fiction", "tt0110912"],
    ["The Good, the Bad and the Ugly", "tt0060196"],
    ["The Lord of the Rings: The Fellowship of the Ring", "tt0120737"],
    ["Fight Club", "tt0137523"],
    ["Forrest Gump", "tt0109830"],
    ["Inception", "tt1375666"],
    ["The Lord of the Rings: The Two Towers", "tt0167261"],
    ["The Matrix", "tt0133093"],
    ["Goodfellas", "tt0099685"],
    ["Star Wars: Episode V - The Empire Strikes Back", "tt0080684"],
    ["One Flew Over the Cuckoo's Nest", "tt0073486"],
    ["Interstellar", "tt0816692"],
    ["Parasite", "tt6751668"],
    ["Saving Private Ryan", "tt0120815"],
    ["The Green Mile", "tt0120689"],
    ["Se7en", "tt0114369"],
    ["The Silence of the Lambs", "tt0102926"],
    ["City of God", "tt0317248"],
    ["Life Is Beautiful", "tt0118799"],
    ["The Usual Suspects", "tt0114814"],
    ["Léon: The Professional", "tt0110413"],
    ["Harakiri", "tt0056058"],
    ["The Pianist", "tt0253474"],
    ["Gladiator", "tt0172495"],
    ["Whiplash", "tt2582802"],
    ["The Intouchables", "tt1675434"],
    ["The Prestige", "tt0482571"],
    ["The Departed", "tt0407887"],
    ["The Lion King", "tt0110357"],
    ["Back to the Future", "tt0088763"],
    ["Joker", "tt7286456"],
    ["The Wolf of Wall Street", "tt0993846"],
    ["Django Unchained", "tt1853728"],
    ["The Truman Show", "tt0120382"],
    ["Avengers: Endgame", "tt4154796"],
    ["Avengers: Infinity War", "tt4154756"],
    ["Titanic", "tt0120338"],
    ["The Social Network", "tt1285016"],
    ["The Revenant", "tt1663202"],
    ["Inglourious Basterds", "tt0361748"],
    ["1917", "tt8579674"],
    ["The Grand Budapest Hotel", "tt2278388"],
    ["Oppenheimer", "tt15398776"]
]

imdb_ids_with_names = [
    ["The Dark Knight Rises", "tt1345836"],
    ["American History X", "tt0120586"],
    ["WALL·E", "tt0910970"],
    ["The Shining", "tt0081505"],
    ["A Beautiful Mind", "tt0268978"],
    ["Braveheart", "tt0112573"],
    ["The Imitation Game", "tt2084970"],
    ["Shutter Island", "tt1130884"],
    ["No Country for Old Men", "tt0477348"],
    ["Black Swan", "tt0947798"],
    ["Blade Runner 2049", "tt1856101"],
    ["Catch Me If You Can", "tt0264464"],
    ["The Pursuit of Happyness", "tt0454921"],
    ["Prisoners", "tt1392214"],
    ["The Curious Case of Benjamin Button", "tt0421715"],
    ["The Big Short", "tt1596363"],
    ["Ford v Ferrari", "tt1950186"],
    ["The Theory of Everything", "tt2980516"],
    ["Bohemian Rhapsody", "tt1727824"],
    ["Spotlight", "tt1895587"],
    ["Ex Machina", "tt0470752"],
    ["Gone Girl", "tt2267998"],
    ["La La Land", "tt3783958"],
    ["Her", "tt1798709"],
    ["Moonlight", "tt4975722"],
    ["A Star Is Born", "tt1517451"],
    ["Marriage Story", "tt7653254"],
    ["The Irishman", "tt1302006"],
    ["The Shape of Water", "tt5580390"],
    ["Birdman", "tt2562232"],
    ["Argo", "tt1024648"],
    ["Slumdog Millionaire", "tt1010048"],
    ["The King’s Speech", "tt1504320"],
    ["The Artist", "tt1655442"],
    ["Juno", "tt0467406"],
    ["Little Miss Sunshine", "tt0449059"],
    ["Eternal Sunshine of the Spotless Mind", "tt0338013"],
    ["Requiem for a Dream", "tt0180093"],
    ["Donnie Darko", "tt0246578"],
    ["The Perks of Being a Wallflower", "tt1659337"],
    ["The Breakfast Club", "tt0088847"],
    ["Dead Poets Society", "tt0097165"],
    ["Good Will Hunting", "tt0119217"],
    ["Rain Man", "tt0095953"],
    ["The Truman Show", "tt0120382"],
    ["Cast Away", "tt0162222"],
    ["The Terminal", "tt0362227"],
    ["Philadelphia", "tt0107818"],
    ["The Blind Side", "tt0878804"]
]






fields = [
    "Title", "Year", "Rated", "Released", "Runtime", "Genre", "Director",
    "Writer", "Actors", "Plot", "Language", "Country", "Awards", "Poster",
    "imdbRating", "imdbVotes", "imdbID"
]

data = []

for expected_title, imdb_id in imdb_ids_with_names :
    url = f"http://www.omdbapi.com/?i={imdb_id}&apikey={API_KEY}"
    response = requests.get(url)
    result = response.json()

    if result.get("Response") == "True":
        actual_title = result.get("Title", "").lower()
        if expected_title.lower() in actual_title or actual_title in expected_title.lower():
            print(f"✅ Match: Expected '{expected_title}' ↔ API Returned '{result['Title']}'")
            data.append({field: result.get(field, "") for field in fields})
        else:
            print(f"⚠️ Title mismatch for ID {imdb_id}: Expected '{expected_title}' but got '{result['Title']}'")
    else:
        print(f"❌ Failed for {imdb_id}: {result.get('Error')}")

    time.sleep(1)  # Respect API rate limits

# Save to CSV
df_result = pd.DataFrame(data)
df_result.to_csv("omdb_movies1.csv", index=False)
print("✅ Data saved to omdb_video_games.csv")
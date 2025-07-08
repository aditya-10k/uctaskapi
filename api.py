from flask import Flask, jsonify
import pandas as pd
import random

app = Flask(__name__)

# Load CSV into memory once
df = pd.read_csv("moviedata.csv")

@app.route("/random", methods=["GET"])
def random_movie():
    movie = df.sample(1).to_dict(orient="records")[0]
    return jsonify(movie)

if __name__ == "__main__":
    app.run(debug=True)

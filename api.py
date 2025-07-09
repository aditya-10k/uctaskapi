import os
from flask import Flask, jsonify
import pandas as pd
import random

app = Flask(__name__)

# Load CSV once
df = pd.read_csv("moviedata.csv")

@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "🎬 Welcome to the Movie API! Use /random to get a random movie."})

@app.route("/random", methods=["GET"])
def random_movie():
    movie = df.sample(1).to_dict(orient="records")[0]
    return jsonify(movie)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))  # default to 5000 locally
    app.run(host="0.0.0.0", port=port)

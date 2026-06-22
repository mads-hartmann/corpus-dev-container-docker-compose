import os

import redis
from flask import Flask


app = Flask(__name__)
cache = redis.Redis(
    host=os.getenv("REDIS_HOST", "redis"),
    port=int(os.getenv("REDIS_PORT", "6379")),
    decode_responses=True,
)


@app.get("/")
def hello():
    count = cache.incr("hits")
    return f"Hello from Docker Compose corpus! Seen {count} time(s).\n"


@app.get("/health")
def health():
    cache.ping()
    return {"status": "ok"}

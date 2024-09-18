from flask import Flask
import redis

app = Flask(__name__)


redis_client = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis_client.set('message', 'Hello from Flask and Redis!')
    
    message = redis_client.get('message').decode('utf-8')
    
    request_count = redis_client.incr('request_count')
    
    return f'Message from Redis: {message}. This page has been visited {request_count} times.'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

from flask import Flask, jsonify
import requests
import os

app = Flask(__name__)

@app.route('/')
def default_route():
    return jsonify(dict(
        service_name='service two'
    ))

@app.route('/talkthree')
def talkthree():
    service_three_url = os.environ.get('SERVICE_THREE_URL') or 'svc3'
    request_url = 'http://{}'.format(service_three_url)
    res = requests.get(request_url)
    return jsonify(dict(
        svc3_response=res.json(),
        other_things='some service three-y things but with version 2',
        svc3=service_three_url
    ))

if __name__ == '__main__':
    app.run()

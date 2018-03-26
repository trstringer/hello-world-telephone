from flask import Flask, jsonify
import requests
import os

app = Flask(__name__)

@app.route('/')
def default_route():
    return jsonify(dict(
        service_name='service one version 2!!'
    ))

@app.route('/talktwo')
def talktwo():
    service_two_url = os.environ.get('SERVICE_TWO_URL') or 'svc2'
    request_url = 'http://{}/talkthree'.format(service_two_url)
    res = requests.get(request_url)
    return jsonify(dict(
        svc2_response=res.json(),
        other_things='this is something here',
        svc2=service_two_url
    ))

if __name__ == '__main__':
    app.run()

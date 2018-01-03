from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def default_route():
    return jsonify(dict(
        service_name='service three'
    ))

if __name__ == '__main__':
    app.run()

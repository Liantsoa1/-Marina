from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route("/solve", methods=["POST"])
def solve():
    data = request.get_json()
    formula = data.get("formula")
    if not formula:
        return jsonify({"error": "Missing formula"}), 400

    try:
        result = subprocess.check_output(["./marina", formula], stderr=subprocess.STDOUT)
        return jsonify({"result": result.decode().strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.output.decode()}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

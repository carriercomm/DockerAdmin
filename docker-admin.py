import datetime
import docker

from flask import Flask, jsonify
from flask.ext.mako import MakoTemplates, render_template

app = Flask(__name__)
app.config['PROPAGATE_EXCEPTIONS'] = True
app.template_folder = "templates"

mako = MakoTemplates(app)


def getContainers(client, all=False):
    containers = []
    try:
        containers = client.containers(all=all)
    except Exception:
        pass

    return containers


@app.route('/containers')
def containers():
    client = docker.Client()
    containers = getContainers(client, all=True)
    for container in containers:
        container['Id'] = container['Id'][:12]
        container['Created'] = datetime.datetime.fromtimestamp(container['Created']).strftime("%Y-%m-%d %H:%M:%S")

    containers = {"containers": containers}
    return jsonify(containers)


@app.route('/')
def index():
    client = docker.Client()
    containers = getContainers(client, all=True)

    status = "Running" if containers else "Stopped"
    statusColour = "green" if containers else "red"

    return render_template('index.mako', status=status, statusColour=statusColour)


if __name__ == '__main__':
    app.run()



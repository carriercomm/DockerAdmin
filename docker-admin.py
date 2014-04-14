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


@app.route('/images')
def images():
    client = docker.Client()
    images = []

    try:
        currentImages = client.images()
        for image in currentImages:
            betterImage = {}
            betterImage['Repositories'] = list(set([repo.split(':')[0] for repo in image['RepoTags']]))
            betterImage['Tags'] = [repo.split(':')[1] for repo in image['RepoTags']]
            betterImage['Image'] = image['Id'][:12]
            betterImage['Created'] = datetime.datetime.fromtimestamp(image['Created']).strftime("%Y-%m-%d %H:%M:%S")
            betterImage['Size'] = "{0:.1f} MB".format(image['VirtualSize'] / 1000.0 / 1000.0)
            images.append(betterImage)
    except Exception:
        pass

    images = {"images": images}
    return jsonify(images)


@app.route('/containers')
def containers():
    client = docker.Client()
    containers = getContainers(client, all=True)
    for container in containers:
        container['Id'] = container['Id'][:12]
        container['Created'] = datetime.datetime.fromtimestamp(container['Created']).strftime("%Y-%m-%d %H:%M:%S")

    containers = {"containers": containers}
    return jsonify(containers)


@app.route('/status')
def status():
    client = docker.Client()
    containers = getContainers(client, all=True)

    status = "Running" if containers else "Stopped"
    statusColour = "green" if containers else "red"

    return jsonify({"status": status, "colour": statusColour})

@app.route('/')
def index():
    return render_template('index.mako')


if __name__ == '__main__':
    app.run()



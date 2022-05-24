from email.mime import application
from flask import Flask

application = Flask(__name__)


@application.route("/")
def index():
    return "Hello Wolen from Flask Main Page"


@application.route("/help")
def help():
    return "This is help page"

@application.route("/users")
def users():
    return "users main page"

@application.route("/users/<username>")
def show_user_page(username):
    return "Hello " + username.upper()

@application.route("/path/<path:subpath>")
def print_subpath(subpath):
    return "subpath " + subpath

@application.route("/kvadrat/<int:x>")
def calc_kvadrat(x):
    return "Kvadrat vid " + str(x) + "=" + str(x*x)


if __name__ == "__main__":
    application.debug = True    #need to delete on prod 
    application.run()



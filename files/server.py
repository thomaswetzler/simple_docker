import socket
from flask import (
    Flask,
    render_template
)

# Create the application instance
app = Flask(__name__, template_folder="/home")

# Create a URL route in our application for "/"
@app.route('/')
def home():
    """
    This function just responds to the browser ULR
    localhost:5000/

    :return:        the rendered template 'home.html'
    """
    host_name = socket.gethostname()
    host_ip = socket.gethostbyname(host_name)
    return render_template('home.html', hostname = host_name, hostip = host_ip)

# If we're running in stand alone mode, run the application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, threaded=True, debug=False)
    
    

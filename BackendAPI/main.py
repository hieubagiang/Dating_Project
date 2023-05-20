import platform

from flask import Flask

from api.build_recommendation.routes import build_recomendation_bp
from api.notification.routes import notification_bp
from api.payment.routes import payment_bp
from api.routes.routes import home_bp
from api.watch import start_watch

app = Flask(__name__)
app.register_blueprint(home_bp, url_prefix='/api')
app.register_blueprint(payment_bp, url_prefix='/api')
app.register_blueprint(build_recomendation_bp, url_prefix='/api')
app.register_blueprint(notification_bp, url_prefix='/api')
from api.payment.routes import *
from api.recommendation.routes import *
from api.routes.routes import *
from api.build_recommendation.routes import *
from api.notification.routes import *
start_watch()

if __name__ == '__main__':
    # Get the current operating system
    current_os = platform.system()
    if current_os == 'Linux':
        context = ('/etc/letsencrypt/live/api.dating.hieuit.top/fullchain.pem',
                   '/etc/letsencrypt/live/api.dating.hieuit.top/privkey.pem')
        app.run(debug=True, ssl_context=context)
    else:
        app.run(debug=True)
    # http_server = WSGIServer(('', 5000), app)
    # http_server.serve_forever()

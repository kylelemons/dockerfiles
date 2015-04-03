// # Ghost Configuration
// Setup your Ghost install for various environments
// Documentation can be found at http://support.ghost.org/config/

var path = require('path'),
    config;

config = {
    production: {
        url: 'http://my-ghost-blog.com',
        mail: {
            // This will need to be overridden to work in docker
        },
        database: {
            client: 'sqlite3',
            connection: {
                filename: '/data/ghost.db'
            },
            debug: false
        },
        server: {
            host: '0.0.0.0',
            port: '2368'
        },
        paths: {
            contentPath: '/data/content/'
        }
    }
};

// Export config
module.exports = config;

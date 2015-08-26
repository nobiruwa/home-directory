#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import argparse
import os
import sys
env_dir = os.path.expanduser(
    '~/.venvs/tornado/lib/python{}.{}/site-packages'
    .format(sys.version_info.major, sys.version_info.minor)
)
sys.path.append(env_dir)

from tornado.web import StaticFileHandler
from tornado.wsgi import WSGIApplication

from livereload import Server


class NonCacheStaticFileHandler(StaticFileHandler):
    def set_extra_headers(self, path):
        super(NonCacheStaticFileHandler, self).set_extra_headers(path)
        self.set_header('Cache-control',
                        'no-store, no-cache, must-revalidate, max-age=0')


class Application(object):
    def __init__(self, opts):
        self._opts = opts
        self._app = self._create()

    def _create(self):
        application = WSGIApplication([
            (r'/(favicon.ico)', StaticFileHandler, {'path': ''}),
            (r'/(.*)', NonCacheStaticFileHandler, {
                'path': self._opts.path,
                'default_filename': 'index.html'
            }),
        ])
        return application

    def serve(self):
        self.server = Server(self._app)
        self.server.serve(port=self._opts.port, root=self._opts.path)


def parse_arguments():
    parser = argparse.ArgumentParser(
        description='Simple HTTP Server with Tornado')
    parser.add_argument('-p', '--port',
                        type=int,
                        default=8888)
    parser.add_argument('path',
                        nargs='?',
                        default='.')
    return parser.parse_args()


if __name__ == '__main__':
    opts = parse_arguments()
    Application(opts).serve()

#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import urllib.request

def retrieve(url):
    with urllib.request.urlopen(url) as response:
        status_code = response.getcode()
        content = response.read()

    return {
        'status_code': status_code,
        'content': content,
    }

class Downloader():
    base_url = 'https://download.nvidia.com/XFree86/Linux-x86_64/'

    def detect_latest_driver_url(self):
        latest_txt_url = f'{self.base_url}latest.txt'
        response = retrieve(latest_txt_url)

        if response['status_code'] >= 300:
            raise Exception('cannot download latest.txt.')

        [_, relative_path] = response['content'].decode('utf-8').strip().split(' ')

        [_, name] = relative_path.split('/')

        return (name, f'{self.base_url}{relative_path}')

    def download(self):
        [name, url] = self.detect_latest_driver_url()

        response = retrieve(url)

        if response['status_code'] >= 300:
            raise Exception('cannot download latest.txt.')

        with open(name, 'wb') as inf:
            inf.write(response['content'])

        print(f'downloaded {name}')


def main():
    Downloader().download()


if __name__ == '__main__':
    main()

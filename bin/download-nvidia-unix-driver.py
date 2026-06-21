#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import re
import urllib.request

from html.parser import HTMLParser


def retrieve(url):
    with urllib.request.urlopen(url) as response:
        status_code = response.getcode()
        content = response.read()

    return {
        'status_code': status_code,
        'content': content,
    }


class DriversUnixHTMLParser(HTMLParser):
    strong_text = re.compile(r'Linux x86_64')
    span_text = re.compile(r'Latest Production Branch Version:')
    version_text = re.compile(r'[0-9]{1,4}\.[0-9]{1,4}(\.[0-9]{1,4})?')

    # next_heading_text = re.compile(r'(Linux aarch64|FreeBSD x64|Solaris x64/x86)')

    def __init__(self):
        super().__init__()
        # タグの判別
        self.is_a_element = False
        self.is_span_element = False
        self.is_strong_element = False

        # パースすべき要素を通過したかどうかの判別
        self.strong_text_found = False
        self.span_text_found = False
        self.section_parsed = False

        # パースの結果
        self.version_found = False
        self.version = None

    def __reset_element_flags(self):
        self.is_a_element = False
        self.is_span_element = False
        self.is_strong_element = False

    def handle_starttag(self, tag, attrs):
        self.__reset_element_flags()

        if tag == 'a':
            self.is_a_element = True
        elif tag == 'span':
            self.is_span_element = True
        elif tag == 'strong':
            self.is_strong_element = True

    def handle_endtag(self, tag):
        self.__reset_element_flags()

    def handle_data(self, data):
        # パース済みであればスキップ
        if self.version_found or self.section_parsed:
            return

        # strong要素
        if self.is_strong_element:
            if self.strong_text_found:
                # パースすべきセクションを通過したことを意味するため
                # 後続の要素を読む必要はない
                self.section_parsed = True
                return
            elif self.strong_text.search(data):
                self.strong_text_found = True
                return

        # span要素
        if self.strong_text_found and self.is_span_element:
            if self.span_text_found:
                # パースすべきa要素を通過したことを意味するため
                # 後続の要素を読む必要はない
                return
            elif self.span_text.search(data):
                self.span_text_found = True
                return

        # a要素
        if self.is_a_element:
            search_result = self.version_text.search(data)
            if search_result:
                self.version_found = True
                self.version = search_result.group()
                return

class LatestVersionDetector():
    url = 'https://www.nvidia.com/en-us/drivers/unix/'

    def find_latest_production_branch_version(self):
        response = retrieve(self.url)

        if response['status_code'] >= 300:
            raise Exception('cannot download latest.txt.')

        html_doc = response['content'].decode('utf-8')

        parser = DriversUnixHTMLParser()
        parser.feed(html_doc)

        return parser.version

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
        version = LatestVersionDetector().find_latest_production_branch_version()

        if not version:
            raise Exception('cannot find latest version.')

        # ex) https://us.download.nvidia.com/XFree86/Linux-x86_64/595.84/NVIDIA-Linux-x86_64-595.84.run
        name = f'NVIDIA-Linux-x86_64-{version}.run'
        url = f'{self.base_url}{version}/{name}'

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

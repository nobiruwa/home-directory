#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import argparse
import subprocess


def parse_arguments():
    parser = argparse.ArgumentParser(description='DPMS ON/OFF, screen blank ON/OFF')
    parser.add_argument('-d', '--dpms',
                        default='off',
                        choices=['on', 'off'])
    parser.add_argument('-s', '--screen',
                        default='off',
                        choices=['on', 'off'])

    return parser.parse_args()


class XsetProcessor(object):
    """xsetプロセスを呼び出します。継承するクラスはoptionsプロパティに
    xsetのオプションをリストとしてセットする必要があります。"""
    command = 'xset'
    def process(self):
        subprocess.call([self.command] + self.options)


class DpmsProcessor(XsetProcessor):
    def __init__(self, args):
        if args.dpms == 'on':
            self.options = ['+dpms']
        else:
            self.options = ['-dpms']


class ScreenSaverProcessor(XsetProcessor):
    def __init__(self, args):
        if args.dpms == 'on':
            self.options = ['s']
        else:
            self.options = ['s', 'off']


def main():
    args = parse_arguments()
    ScreenSaverProcessor(args).process()
    DpmsProcessor(args).process()


if __name__ == '__main__':
    main()

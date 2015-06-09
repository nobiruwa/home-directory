#!/usr/bin/env python3
# -*-  mode:python; coding:utf-8; -*-
HTSVOICE_MAN = ('$HOME/downloads/openjtalk/'
                + 'hts_voice_nitech_jp_atr503_m001-1.05/'
                + 'nitech_jp_atr503_m001.htsvoice')

HTSVOICE_WOMAN_TEMPLATE = ('$HOME/downloads/openjtalk/'
                           + 'MMDAgent_Example-1.4/Voice/mei'
                           + '/mei_{0}.htsvoice')


import os
import subprocess


class CommandLineParser:
    def parse_arguments(self):
        import argparse
        parser = argparse.ArgumentParser(description='Open JTalk wrapper')
        parser.add_argument('-s', '--sex', dest='sex',
                            choices=['man', 'woman'],
                            default='woman',
                            help='voice type')
        parser.add_argument('-o', '--output', dest='output',
                            default='/tmp/openjtalk.wav',
                            help='output file')
        parser.add_argument('-f', '--feeling', dest='feeling',
                            choices=['normal', 'angry',
                                     'bashful', 'happy', 'sad'],
                            default='normal',
                            help='feeling (it works only for woman voice)')
        parser.add_argument('-p', '--play', action='store_true',
                            help='play output')
        parser.add_argument('-t', '--text', dest='text', default=None,
                            help='sentence')
        parser.add_argument('-i', '--infile', dest='infile', default=None, help='input file')

        return parser.parse_args()


class OpenJTalkRunner(object):
    def __init__(self, args):
        self.args = self.extend_arguments(args)

    def run(self):
        status = self.call(self.args)
        return status

    def extend_arguments(self, args):
        if args.sex == 'man':
            htsvoice = HTSVOICE_MAN
        elif args.sex == 'woman':
            htsvoice = HTSVOICE_WOMAN_TEMPLATE.format(args.feeling)

        dic = '/usr/local/dic'
        args.htsvoice = os.path.expandvars(htsvoice)
        args.dic = os.path.expandvars(dic)
        return args

    def create_command_line(self, args):
        cmd = ['open_jtalk', '-m', args.htsvoice, '-x', args.dic, '-ow', args.output]
        return cmd

    def call(self, args):
        cmd = self.create_command_line(self.args)
        if args.text:
            proc = subprocess.Popen(cmd, stdin=subprocess.PIPE)
            proc.communicate(input=args.text.encode())
        elif args.infile:
            cmd.extend([args.infile])
            proc = subprocess.Popen(cmd)
            proc.communicate()
        else:
            raise ValueError('You must specifiy --text or --infile option.')
        proc.wait()
        return proc.returncode


class PlayerRunner(object):
    def __init__(self, args):
        self.args = args

    def run(self):
        if self.args.play:
            cmd = self.create_command_line(self.args)
            self.call(cmd)

    def create_command_line(self, args):
        template = 'aplay {0}'
        cmd = template.format(args.output)
        return cmd

    def call(self, cmd):
        import subprocess
        subprocess.call(cmd, shell=True)


if __name__ == '__main__':
    args = CommandLineParser().parse_arguments()
    status = OpenJTalkRunner(args).run()
    if status == 0:
        PlayerRunner(args).run()

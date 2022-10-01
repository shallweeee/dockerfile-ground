#! /usr/bin/env python3

import argparse
import sys


def get_args():
    parser = argparse.ArgumentParser(description='docker history viewer')
    parser.add_argument('file',
                        metavar='FILE',
                        nargs='?',
                        default=sys.stdin,
                        type=argparse.FileType('rt'),
                        help='Input file or stdin')
    return parser.parse_args()


def get_header(line):
    header = ['IMAGE', 'CREATED', 'CREATED BY', 'SIZE', 'COMMENT']
    indexes = [line.find(h) for h in header] + [0]
    return {h: indexes[i:i + 2] for i, h in enumerate(header)}


def main():
    args = get_args()

    header = get_header(next(args.file))
    rows = []

    for line in args.file:
        row = {}
        for h, [start, end] in header.items():
            row[h] = line[start:end or len(line)].strip()
        rows.append(row)

    rows.reverse()

    column = 'CREATED BY'
    print(column)
    for row in rows:
        print(row[column])


if __name__ == '__main__':
    main()

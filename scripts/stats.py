#!/usr/bin/env python3
import os
import argparse
from Bio import SeqIO

def get_args():
  parser = argparse.ArgumentParser(description='corrects contigs name to be unique')
  parser.add_argument('-f', '--contigs', help='contigs file path',
    type=str, metavar='CONTIGS', required=True)

  return parser.parse_args()

def main():
    #get arguments
    args = get_args()
    myfile= args.contigs

    # define the output file
    sample, ext = os.path.splitext(myfile)
    lengthfile= sample + "_length.csv"
    f = open(lengthfile, 'w') 

    #parse and correct contig names
    for record in SeqIO.parse(myfile, "fasta"):
        line= record.id + ", " + str(len(record)) + "\n"
        f.write(line)   


if __name__ == "__main__":main()


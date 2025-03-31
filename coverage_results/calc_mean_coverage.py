import re
import os

SEARCHPATTERN = r'<body>\n<h1>.*\((\d+)/(\d+)\).*</h1>'

dirs = ['bcd_combined_functional_no_bcd', 'bcd_valid_only', 'functional_no_bcd', 'functional_with_bcd']

for dir in dirs:
    possible = 0
    taken = 0
    for entry in os.scandir(dir):
        with open(entry, 'r') as file:
            entrycontent = file.read()
        data = re.search(SEARCHPATTERN, entrycontent)
        taken += int(data.group(1))
        possible += int(data.group(2))
    print(dir)
    print('total taken:', taken)
    print('total possible:', possible)
    print('percentage:', taken / possible)
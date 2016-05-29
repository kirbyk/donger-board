import json

FILE = "../data/dongers.json"


def sortDongers():
    _sorted = {}

    with open(FILE, 'r') as f:
        unsorted = json.loads(f.read())

        for key, unsort in unsorted.items():
            _sorted[key] = sorted(unsort, key=len)

    with open(FILE, 'w') as f:
        f.write(json.dumps(_sorted, indent=4, ensure_ascii=False))


if __name__ == "__main__":
    sortDongers()

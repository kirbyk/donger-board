import json

FILE = "../data/dongers.json"


def fixJSON():
    new_dict = {}

    with open(FILE, 'r') as f:
        bad_format = json.loads(f.read())
        for key, bad in bad_format.items():
            new_dict[key] = list(flatten(bad))

    with open(FILE, 'w') as f:
        f.write(json.dumps(new_dict, indent=4, ensure_ascii=False))



# Taken from SO
def flatten(container):
    for i in container:
        if isinstance(i, (list,tuple)):
            for j in flatten(i):
                yield j
        else:
            yield i

if __name__ == "__main__":
    fixJSON()


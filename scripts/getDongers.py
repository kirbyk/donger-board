'''
    Scrape dongerlist.com for dongers, matching categories as we go

    Apparently they're working on an API but this is all we got for now

    There's a similar parser here: https://github.com/frdmn/alfred-dongers
    which we could use but... why not just write one from scratch

'''
from splinter import Browser

categories = [
    "AMENO",
    "ANGRY",
    "ANIMAL",
    "BRICK",
    "COOL",
    "CRACKER",
    "CRAZY",
    "CRY",
    "CUTE",
    "DANCE",
    "DEAD",
    "DONGER",
    "DUNNO",
    "EXCITED",
    "FIGHT",
    "FINGER",
    "FLEX",
    "FLIP",
    "FLOWER",
    "GLASSES",
    "GUN",
    "HAPPY",
    "HUH",
    "LENNY",
    "LOWER",
    "MAD",
    "MAGIC",
    "MAN",
    "MEH",
    "MOB",
    "MONOCLE",
    "MUSIC",
    "POINT",
    "PYRAMID",
    "RAISE",
    "RUN",
    "SAD",
    "SCARED",
    "SCARY",
    "SHOCKED",
    "SPIDER",
    "SURPRISED",
    "SWORD",
    "TABLE",
    "THROW",
    "TREE",
    "UGLY",
    "UPSET",
    "WALK",
    "WALL",
    "WHY"]

BASE_URL = "http://www.dongerlist.com/"


# Traverse through url structure of dongerlist, accessing pages by category
def getDongers():
    path = "category/"
    for cat in categories:
        url = BASE_URL + path + cat.lower() + "/"
        print(url)
        # Parse the first page here

        pagenum = 2
        url += "page/"
        while pagenum > 0:
            page_url = url + str(pagenum) + "/"
            if not checkPage(page_url):
                break
            print(page_url)
            pagenum += 1


# Check if page exists
def checkPage(url):
    browser = Browser("chrome")
    browser.visit(url)

    # The site doesn't 404 but rather displays "Not Found" so look for that
    element_list = browser.find_by_text("Not Found")
    if element_list.is_empty():
        return True
    else:
        return False


# Once we have the HTML element we want, inspect it to get to the Dongers!!!
def scrapeDonger(url):
    browser = Browser("chrome")
    browser.visit(url)

    elems = browser.find_by_css(".donger")
    print(len(elems))
    for elem in elems:
        print(elem.text)


if __name__ == "__main__":
    # getDongers()
    scrapeDonger("http://dongerlist.com/category/ameno")

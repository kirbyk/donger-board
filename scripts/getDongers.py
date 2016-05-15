'''
    Scrape dongerlist.com for dongers, matching categories as we go

    Apparently they're working on an API but this is all we got for now

    There's a similar parser here: https://github.com/frdmn/alfred-dongers
    which we could use but... why not just write one from scratch

'''
from splinter import Browser
import json

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

dongers = {}


# Traverse through url structure of dongerlist, accessing pages by category
def getDongers():
    path = "category/"
    for cat in categories:
        url = BASE_URL + path + cat.lower() + "/"
        print(url)
        # Parse the first page here
        checkPage(url, cat)

        # Parse any additional pages if they exist
        pagenum = 2
        url += "page/"
        while pagenum > 0:
            page_url = url + str(pagenum) + "/"
            if not checkPage(page_url, cat):
                break
            print(page_url)
            pagenum += 1

        # After each category dump the dongers we have so far into a file
        with open('dongers.json', 'w') as f:
            f.write(json.dumps(dongers, indent=4, ensure_ascii=False))


# Check if page exists
def checkPage(url, category):
    browser = Browser("chrome")
    browser.visit(url)

    # The site doesn't 404 but rather displays "Not Found" so look for that
    element_list = browser.find_by_text("Not Found")
    if element_list.is_empty():
        scrapeDonger(url, category, browser)
        return True
    else:
        return False


# Once we have the page we want, inspect it to get to the Dongers!!!
def scrapeDonger(url, category, browser):
    # Get all elements containing dongers on the page by their CSS class
    elems = browser.find_by_css(".donger")
    print(len(elems))
    donger_category_list = []

    # Get the actual donger (the text) and
    for elem in elems:
        donger_category_list.append(elem.text)
        print(elem.text)

    # Add the donger list from this page to our dictionary
    # There might be multiple pages for a category so account for that
    if category in dongers:
        old_list = dongers[category]
        old_list.append(donger_category_list)
        dongers[category] = old_list
    else:
        dongers[category] = donger_category_list


if __name__ == "__main__":
    getDongers()
    '''
    browser = Browser('chrome')
    browser.visit("http://dongerlist.com/category/ameno")
    category = 'ameno'
    scrapeDonger("http://dongerlist.com/category/ameno", category, browser)
    '''

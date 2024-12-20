import requests
from bs4 import BeautifulSoup

start = 2016
end = 2024
events = []

for year in range(start, end + 1):
    events_in_year = []
    for month in range(1, 13):
        rYear = year + 1 if month == 12 else year
        rMonth = 1 if month == 12 else month + 1
        request = requests.get(f"https://www.bielefeld.jetzt/termine/suche?dateFrom={year}-{month}-01&dateTo={rYear}-{rMonth}-01&rubrik%5B0%5D=0&ort=0&stadtbezirk=0")

        soup = BeautifulSoup(request.text, "html.parser")
        all_divs = soup.find_all("div", {"class": "is-sticky"})
        events_in_month = []
        for div in all_divs:
            content = div.find_all("div", {"class": "masonry-event-content"})
            for event in content:
                name = event.find("h3").text
                date = event.find("p", {"class": "mb-2"}).text
                destination = event.find("p", {"class": "mb-1"}).text
                events_in_month.append({"name": name, "date": date, "destination": destination})
        events_in_year.append({"month": month, "events": events_in_month})
    events.append({"year": year, "events": events_in_year})

print("x")


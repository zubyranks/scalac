import requests
from bs4 import BeautifulSoup

response = requests.get("http://bash.org.pl/browse/").text

soup = BeautifulSoup(response, "lxml")

for div in soup.find_all('div', class_="q post"):

    div1 = soup.find('div', class_='quote post-content post-body').text

    print(div1)

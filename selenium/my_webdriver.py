from selenium import webdriver
from selenium.webdriver.common.by import By
# from bs4 import BeautifulSoup
import time

# https://stackoverflow.com/a/40208762
# https://www.instagram.com/accounts/login/?next=%2Fedynsoncoronado%2F&source=desktop_nav
driver = webdriver.Firefox()
user = 'edynsoncoronado'
url = 'https://www.instagram.com/accounts/login/?next=%2F{}%2F&source=desktop_nav'.format(user)
driver.get(url)
time.sleep(5)
driver.find_element_by_xpath("//input[@name='username']").send_keys('xxx@gmail.com')
driver.find_element_by_xpath("//input[@name='password']").send_keys('xxx')
driver.find_element_by_xpath("//button[@type='submit']").click()
time.sleep(3)
driver.get('https://www.instagram.com/{}/saved/'.format(user))
time.sleep(3)

len_element = 0
list_image = []
index = 0

for i in range(0, 5):
	element_before = driver.find_elements(By.XPATH, "//div[@class='Nnq7C weEfm']")
	if len(element_before) > len_element:
		len_element = len(element_before)
		print("index", index)
		print("len", len_element)
		for e in element_before[index:]:
			for e_div in e.find_elements(By.XPATH, "//div[@class='v1Nh3 kIKUG  _bz0w']"):
				src_image = e_div.find_element(By.XPATH, "//img").get_attribute("src")
				if src_image not in list_image:
					list_image.append(src_image)
					print("src_image", src_image)

			index += 1
	driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
	time.sleep(3)

print(list_image)
print(len(list_image))

time.sleep(10)
driver.close()



#element.get_attribute('innerHTML')
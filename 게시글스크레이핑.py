
import requests         # 웹서버 요청을 위한 패키지
from bs4 import BeautifulSoup   # 문서 파싱을 위한 모듈
from time import sleep          # 딜레이 시간을 주기위해
import csv                      # csv 형태로 저장하기 위해
import os                       # 저장파일 존재를 확인하기 위해


# step1 : 메인페이지에 접속해서 각 책들의 상세 페이지 주소를
#         스크래핑한다.
def step1_get_url_list():
    url_list = []
    # 요청 및 분석
    site = 'https://www.bikeseoul.com/customer/opinionBoard/opinionBoardList.do'
    response = requests.get(site)
    soup = BeautifulSoup(response.content, 'html.parser')

    # class 속성이 view_box인 태그들을 가져온다.
    div_list = soup.select('.board_box .left a')


    for b in range(15013, 15020):
        href = 'https://www.bikeseoul.com/customer/opinionBoard/opinionBoardView.do?usrQnaSeq=' + str(b)
        url_list.append(href)
    return url_list
'''
    for a in div_list:
        # print(a)
        # href 속성값을 가지고 온다(링크주소)
        href = a.get('href')
        href = 'https://www.bikeseoul.com' + href
        # 리스트에 담는다.
        url_list.append(href)
'''


#    print(url_list)


def step2_get_detail_html(url) :
    try:
        # 상세 페이지의 html 데이터를 받아온다.
        response = requests.get(url)
        soup = BeautifulSoup(response.content, 'html.parser')
        #print(soup)
        board_title_tag = soup.select('.read_box p')
        board_title = board_title_tag[0].text
        #print(board_title_tag)
        #print(board_title)
        info_list = soup.select('.read_box dd')
        info = info_list[0].text
        info = info.replace(u'\xa0', u' ')
        info = info.replace(u'\t', u'')
        info = info.replace(u'\n', u'')
        info = info.replace(u'\r', u'')
        data_list = [board_title, info]
        print(data_list)
        return data_list
    except IndexError:
        pass

def step4_save_csv(data) :
    if os.path.exists('dd.csv') == False:
        # 헤더를 저장한다.
        with open('dd.csv', 'a', -1, 'utf-8-sig', newline='') as fp:
            writer = csv.writer(fp)
            writer.writerow(['board_title', 'info'])

    # 데이터 저장
    with open('dd.csv', 'a', -1, 'utf-8-sig', newline='') as fp2:
        try:
            writer2 = csv.writer(fp2)
            writer2.writerow(data)
        except csv.Error:
            pass

url_list = step1_get_url_list()

for url in url_list :
    sleep(1)
    data_list = step2_get_detail_html(url)
    #print(data_list)
    step4_save_csv(data_list)
    print(str(url) + '/' + str(len(url_list)))
print("fin")


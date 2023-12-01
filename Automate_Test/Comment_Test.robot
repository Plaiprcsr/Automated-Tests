*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${URL}        http://45.144.164.182:8080/

*** Test Cases ***
Test Launch Website
    #เปิด Broeser เเละ url ที่ได้ทำการตั้งค่าไว้
    Open Browser    ${URL}    ${BROWSER}
    Set Log Level    ERROR
    Maximize Browser Window   
    Sleep    3s


Test Click on Blog Topic
    #หาข้อมูลที่ต้องการจะทดสอบ
    Execute JavaScript    document.querySelector('.blog-news.blog-home2').scrollIntoView();
    #ทำการทดสอบระบบที่ต้องการ
    Click Element   link=How to Have More Focused
    Sleep    5s


Test Enter comment and user information
    #ทำการทดสอบโดยการกรอกข้อมูล ให้ระบบทำการcomment ลงบนwebsite 
    Input Text    id=comment    Final_Test
    Input Text    id=author    Group_07
    Input Text    id=email    Group_07@gmail.com
    Click Element    id=wp-comment-cookies-consent
    Sleep    5s


Test Submit Comment
    Click Button    Post Comment
    #Capture Page Screenshot
    Sleep    5s

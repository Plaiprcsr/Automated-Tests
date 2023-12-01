*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}          chrome
${url_retailsy}     http://45.144.164.182:8080/
${login_page_url}   css=.user-btn > .e-commerce-corn
${username_input}   id=username 
${password_input}   id=password
${user_login}       id=user_login
${valid_username}   realmookcy@gmail.com
${valid_password}   mook1234
#${eyes_label}      css=.woocommerce-form-row:nth-child(2) > label
${login_button}     name=login
${lost_pass}        css=.woocommerce-LostPassword > a
${reset_button}     xpath=//button[@value='Reset password']


*** Test Cases ***
Test Opening Retailsy using Chrome
    #เปิด Broeser เเละ url ที่ได้ทำการตั้งค่าไว้
    Open Browser    ${url_retailsy}    ${browser}

Navigate to Login Page
    #ทำการ click เพื่อไปยังระบบที่ต้องการจะทดสอบ
    Click Element    ${login_page_url}

Provide Valid Username or Email
    #ทำการ กรอกข้อมูลที่ต้องการทดสอบ
    Input Text    ${username_input}    ${valid_username}

Provide Valid Password
    #ทำการ กรอกข้อมูลที่ต้องการทดสอบ
    Input Text    ${password_input}    ${valid_password}

# Click Eyes Label to Show Password
#     Click Element    ${eyes_label}
#     Click Element    ${eyes_label}

Click on "Log in" button
    #ทดสอบโดย การclick หลังจากรอกข้อมูลเรียบร้อยเเล้ว
    Click Element    ${login_button}

Click on "Lost your password?" linktext
    #ทดสอบโดย การclick เพื่อทดสอบระบบ lost password
    Click Element    ${lost_pass} 

Provide Valid Username or Email for Reset password
    #ทำการ กรอกข้อมูลที่ต้องการทดสอบ
    Input Text    ${user_login}    ${valid_username}

Click on "Reset" linktext
    #ทดสอบโดย การclick เพื่อทดสอบระบบ
    Click Element    ${reset_button} 





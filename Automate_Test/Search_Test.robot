*** Settings ***
Library           SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${browser}        Edge
${url_web}     http://45.144.164.182:8080/ 
${text}           xpath=//*[@id="lst-ib"]
${search_button}  css=input.lsb

*** Test Cases ***
Test opening google.com using Edge
    #เปิด Broeser เเละ url ที่ได้ทำการตั้งค่าไว้
    Open Browser        ${url_web}       ${browser}
    #ตั้งค่าขนาดของ หน้าจอ
    Set Window Size    1400    1020
    

Launch Website
    ${title}=           Get Title
    Should Be Equal As Strings     ${title}    Life Gadget

Enter a valid keyword
    #กรอกข้อมูล คำว่า Logitech เพื่อทำการทดสอบระบบ serach
    Input Text          css:input[placeholder="Search Products Here"]     Logitech
    # ส่งข้อมูลไปยัง server เพื่อทำการทดสอบระบบ
    Submit Form
    ${title}=           Get Title
    #ข้อมูลโชว์ถูกต้องตามที่คาดหวัง หรือไม่
    Should Be Equal As Strings     ${title}    LOGITECH G YETI ORB RGB BLACK – Life Gadget

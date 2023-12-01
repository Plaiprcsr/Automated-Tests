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
    Open Browser        ${url_web}       ${browser}
    Set Window Size    1400    1020
    

Launch Website
    ${title}=           Get Title
    Should Be Equal As Strings     ${title}    Life Gadget

Navigate to Product Page
    #คลิ๊กไปที่ลิ้งค์ของผลิตภัณฑ์ที่ชื่อ LOGITECH G YETI ORB RGB BLACK
    Click Link  http://45.144.164.182:8080/product/logitech-g-yeti-orb-rgb-black/
    ${title}=           Get Title
    Should Be Equal As Strings     ${title}    LOGITECH G YETI ORB RGB BLACK – Life Gadget

Click Add to Cart on Item
    #รอให้ปุ่ม Add Cart แสดงผลขึ้นมา และทำการกดต่อไป
    Wait Until Element Is Visible  xpath=//button[@value='81']
    Click Element  xpath=//button[@value='81']
    #รอให้จำนวนเลขสินค้าที่อยู่ในตะกร้าเพิ่มขึ้นมา จากนั้นจึงเก็บค่าตัวเลขในนั้น และนำมา Assert
    Wait Until Element Is Visible    css=span.cart-counts
    ${span_text}=    Get Text   css=span.cart-counts
    Should Be Equal As Strings     ${span_text}    1

Navigate to Cart Section
    Wait Until Element Is Visible    css=span.cart-counts
    #คลิ๊กไปที่ปุ่ม Cart
    Click Link  javascript:void(0)
    #รอให้ Drawer ขึ้นมาจากทางด้านขวา
    Wait Until Element Is Visible    css=div.cart-container
    #Assert ว่า Drawer นั้นขึ้นมาจริงๆหรือไม่
    ${drawer_text}=    Get Text   css=a.cart-ft-btn.button.btn.btn-border-secondary.cart-ft-btn-checkout
    Should Be Equal As Strings     ${drawer_text}    Checkout

Navigate to Checkout button
    #คลิ๊กไปที่ปุ่ม Check Out
    Click Element  css=a.cart-ft-btn.button.btn.btn-border-secondary.cart-ft-btn-checkout
    ${title}=           Get Title
    Should Be Equal As Strings     ${title}    Checkout – Life Gadget
    
Provide a valid Billing Address and press Place Order
    #ใส่ข้อมูลลงใน Form
    Input Text    id=billing_first_name    Princhon
    Input Text    id=billing_last_name   Sriurairatana
    Input Text    id=billing_address_1    457
    Input Text    id=billing_city    Bangkok
    Input Text    id=billing_postcode    10400
    Input Text    id=billing_phone   0812345678
    Input Text    id=billing_email    testmail@hotmail.com
    #คลิ๊ก Place Order เพื่อไปหน้าถัดไป
    Click Element  xpath=//button[@value='Place order']
    #Assert ว่า path ปัจจุบันนั้นตรงกับ path ที่เป็นหน้า order details หรือไม่
    Wait Until Element Is Visible    css=section.woocommerce-order-details
    ${currentpath}=   Get Location
    Should Contain     ${currentpath}    http://45.144.164.182:8080/checkout/order-received/

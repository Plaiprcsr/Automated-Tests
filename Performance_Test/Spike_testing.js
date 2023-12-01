import http from 'k6/http';
import { sleep, check } from 'k6';
//Spike testing คือการทดสอบในกรณีทีVมีปริมาณการใช้งานระบบเพิVมสูงขึKนด้วยเงืVอนไขบางประการ เช่น มี
//ประชาชนเข้ามาใช้งานอย่างมาก มีการเข้ามาสัVงซืKอของเนืVองจากมี Promotion ทีVมีเวลาจํากัด โดยให้


export let options = {
  stages: [
    { duration: '30s', target: 10 },// เพื่อจำนวนผู้ใช้งานจาก 0 user ขึ้นเป็น 10 users ภายในเวลา 30วินาที
    { duration: '1m', target: 10 }, // สั่งการให้ 10 users คงอยู่ในระบบเป็นเวลา 1นาที เพื่อตรวจสอบกรณีที่ระบบมีผู้ใช้งานเพื่มสูงขึ้น/ ลดลงในกรณ๊ต่างๆ
    { duration: '30s', target: 50 },// เพื่อจำนวนผู้ใช้งานจาก 10 user ขึ้นเป็น 50 users ภายในเวลา 30วินาที
    { duration: '1m', target: 50 },// สั่งการให้ 50 users คงอยู่ในระบบเป็นเวลา 1นาที เพื่อตรวจสอบกรณีที่ระบบมีผู้ใช้งานเพื่มสูงขึ้น/ ลดลงในกรณ๊ต่างๆ
    { duration: '1m', target: 10 },// เพื่อจำนวนผู้ใช้งานจาก 50 user ลดลงเป็น 10 users ภายในเวลา 30วินาที
    { duration: '3m', target: 10 },// สั่งการให้ 10 users คงอยู่ในระบบเป็นเวลา 3นาที เพื่อตรวจสอบกรณีที่ระบบมีผู้ใช้งานเพื่มสูงขึ้น/ ลดลงในกรณ๊ต่างๆ
    { duration: '30s', target: 100 },// เพื่อจำนวนผู้ใช้งานจาก 10 user ขึ้นเป็น 100 users ภายในเวลา 30วินาที
    { duration: '30s', target: 10 },//ลดจำนวนผู้ใช้งาน จาก 100 user เป็น 10 users ภายในเวลา 30วินาที
  ],
};

export default function () {
  // Launch Website
  http.get('http://45.144.164.182:8080/');
  sleep(1);

  // Click on Blog Topic
  let blogResponse = http.get('http://45.144.164.182:8080/2023/11/05/how-to-have-more-focused/');
  check(blogResponse, {
    'Navigate to Blog Page': (res) => res.status === 200,
  });
  sleep(1);

  // Test Submit Comment
  let commentData = JSON.stringify({
    comment: 'Test101',
    author: 'John',
    email: 'John101@gmail.com',
    'wp-comment-cookies-consent': 'yes',
  });
  let response = http.post('http://45.144.164.182:8080/wp-comments-post.php', commentData);
  check(response, {
    'Comment is displayed': (res) => res.status === 200,
  });
  sleep(5);
}

import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
    // Key configurations for avg load test in this section
    stages: [
      { duration: '1m', target: 100 }, //เพิ่มจำนวนผู้ใช้งานจาก 0 user ขึ้นเป็น 100 users ภายในเวลา 1 นาที
      { duration: '5m', target: 100 }, // สั่งการให้ 100 users คงอยู่ในระบบเป็นเวลา 5นาที เพื่อตรวจสอบความเสถียรของระบบ
      { duration: '1m', target: 0 }, // ลดจำนวนผู้ใช้งานลงจาก 100 users ให้มีค่าเป็น 0 ในเวลา 1นาที
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
    comment: 'Test102',
    author: 'Johns',
    email: 'John102@gmail.com',
    'wp-comment-cookies-consent': 'yes',
  });
  let response = http.post('http://45.144.164.182:8080/wp-comments-post.php', commentData);
  check(response, {
    'Comment is displayed': (res) => res.status === 200,
  });
  sleep(5);
}


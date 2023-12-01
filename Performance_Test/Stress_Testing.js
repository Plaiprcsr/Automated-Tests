import http from 'k6/http';
import { sleep, check } from 'k6';


export const options = {
    // Key configurations for Stress in this section
    stages: [
      { duration: '2m', target: 200 }, // เพื่มจำนวนผู้ใช้งานจาก 0 user ขึ้นเป็น 200 users ภายในเวลา 2นาที
      { duration: '6m', target: 200 }, // สั่งการให้ 200 users คงอยู่ในระบบเป็นเวลา 6นาที เพื่อทำการทดสอบความคงทนของระบบเมื่อมีผู้ใช้งานสูงเป็นเวลานาน
      { duration: '1m', target: 0 }, // ลดจำนวนผู้ใช้งานลงจาก 200 users ให้มีค่าเป็น 0 ในเวลา1นาที
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
    comment: 'Test103',
    author: 'John3',
    email: 'John103@gmail.com',
    'wp-comment-cookies-consent': 'yes',
  });
  let response = http.post('http://45.144.164.182:8080/wp-comments-post.php', commentData);
  check(response, {
    'Comment is displayed': (res) => res.status === 200,
  });
  sleep(5);
}
const admin = require("firebase-admin");

// Đường dẫn tới tệp serviceAccountKey.json, chứa thông tin xác thực của Firebase Admin SDK.
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Hàm gửi silent notification đến một thiết bị đã đăng ký.
function sendSilentNotification(registrationToken) {
  const message = {
    token: registrationToken,
    data: {
      title: "Silent Notification",
      body: "This is a silent notification.",
    },
    notification: {
      silent: true,
    },
  };

  // Gửi thông báo sử dụng Firebase Admin SDK.
  admin.messaging().send(message)
    .then((response) => {
      console.log("Silent notification sent successfully:", response);
    })
    .catch((error) => {
      console.error("Error sending silent notification:", error);
    });
}

// Thay đổi giá trị `device_registration_token` thành token đăng ký của thiết bị cụ thể.
const deviceRegistrationToken = "device_registration_token";

// Gửi silent notification đến thiết bị đã đăng ký.
sendSilentNotification(deviceRegistrationToken);

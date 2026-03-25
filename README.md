# 🍼 Hệ Thống Chăm Sóc Mẹ & Bé

> Nền tảng kết nối gia đình với người chăm sóc chuyên nghiệp, hỗ trợ theo dõi sức khỏe mẹ & bé, chia sẻ cộng đồng và cung cấp kiến thức chăm sóc toàn diện.

---

## 📋 Mục Lục

- [Tổng Quan](#-tổng-quan)
- [Các Module Chức Năng](#-các-module-chức-năng)
  - [① Booking — Đặt Lịch Chăm Sóc](#-booking--đặt-lịch-chăm-sóc)
  - [② Theo Dõi — Tình Hình Mẹ & Bé](#-theo-dõi--tình-hình-mẹ--bé)
  - [③ Hồ Sơ Caregiver](#-hồ-sơ-caregiver)
  - [④ Cộng Đồng](#-cộng-đồng)
  - [⑤ Kho Kiến Thức](#-kho-kiến-thức)
- [Đối Tượng Người Dùng](#-đối-tượng-người-dùng)
- [Tech Stack Gợi Ý](#-tech-stack-gợi-ý)
- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)

---

## 🌟 Tổng Quan

Hệ thống **Chăm Sóc Mẹ & Bé** là một nền tảng đa chức năng nhằm hỗ trợ các gia đình trong giai đoạn mang thai và sau sinh. Hệ thống kết nối gia đình với đội ngũ người chăm sóc (caregiver) chuyên nghiệp, đồng thời cung cấp công cụ theo dõi sức khỏe, cộng đồng chia sẻ và thư viện kiến thức.

### Mục tiêu chính

- Giúp gia đình dễ dàng tìm kiếm và đặt lịch caregiver phù hợp
- Theo dõi tình trạng sức khỏe mẹ & bé theo thời gian thực
- Xây dựng cộng đồng cha mẹ hỗ trợ lẫn nhau
- Cung cấp kiến thức chăm sóc đáng tin cậy dưới dạng video và tài liệu PDF

---

## 🧩 Các Module Chức Năng

### ① Booking — Đặt Lịch Chăm Sóc

Module quản lý toàn bộ quy trình tìm kiếm và đặt lịch chăm sóc.

#### Tìm kiếm & lựa chọn caregiver
- Xem danh sách caregiver đang khả dụng
- Lọc theo: khu vực, kinh nghiệm, đánh giá, mức giá
- Xem hồ sơ chi tiết (ảnh, chứng chỉ, đánh giá từ khách hàng trước)

#### Quản lý lịch đặt
- Chọn ngày, giờ, ca làm việc (sáng / chiều / tối)
- Đặt lịch một lần hoặc định kỳ (hàng ngày, hàng tuần)
- Hủy và đổi lịch linh hoạt
- Nhắc lịch qua thông báo đẩy (push notification)

#### Thanh toán
- Xem báo giá trước khi xác nhận đặt lịch
- Thanh toán trực tuyến: ví điện tử, chuyển khoản ngân hàng
- Xem lịch sử giao dịch và hóa đơn

---

### ② Theo Dõi — Tình Hình Mẹ & Bé

Module ghi nhật ký và theo dõi tình trạng sức khỏe theo thời gian thực.

#### Nhật ký tự động theo mẫu
- Checklist sẵn có: bú sữa, giờ ngủ, tắm, nhiệt độ cơ thể, thay tã,...
- Caregiver điền nhanh sau mỗi ca chăm sóc
- Gia đình xem lại lịch sử bất kỳ lúc nào

#### Ghi chú bổ sung
- Phần ghi chú tự do thêm vào bên cạnh checklist
- Đính kèm ảnh hoặc video tình trạng bé

#### Cảnh báo & chia sẻ
- Thông báo khi có triệu chứng bất thường
- Xuất và chia sẻ nhật ký với bác sĩ hoặc người thân

---

### ③ Hồ Sơ Caregiver

Module quản lý thông tin và danh tiếng của đội ngũ người chăm sóc.

#### Thông tin hồ sơ
- Đăng ký và xác minh danh tính (CCCD / chứng chỉ)
- Hiển thị: tên, ảnh đại diện, số năm kinh nghiệm, chứng chỉ nghề
- Trạng thái khả dụng: Đang trực tuyến / Đang bận / Nghỉ

#### Đánh giá & phản hồi
- Khách hàng đánh giá sau mỗi ca làm việc (sao + nhận xét)
- Hiển thị điểm trung bình và tổng số ca đã thực hiện

#### Quản lý cá nhân
- Caregiver tự cập nhật thông tin, lịch rảnh, khu vực làm việc
- Xem lịch sử các ca đã nhận

---

### ④ Cộng Đồng

Module xây dựng cộng đồng cha mẹ chia sẻ kinh nghiệm nuôi con.

#### Đăng bài & tương tác
- Đăng bài chia sẻ kinh nghiệm chăm sóc mẹ & bé
- Bình luận, thả cảm xúc (thích, yêu thích, hữu ích)
- Lưu bài viết yêu thích để đọc lại

#### Hỏi & Đáp
- Đặt câu hỏi cho cộng đồng hoặc chuyên gia
- Trả lời và gắn tag câu trả lời hữu ích nhất

#### Quản trị nội dung
- Kiểm duyệt bài đăng trước khi hiển thị công khai
- Báo cáo nội dung vi phạm
- Phân loại bài viết theo chủ đề (sơ sinh, dinh dưỡng, tâm lý,...)

---

### ⑤ Kho Kiến Thức

Module cung cấp tài nguyên học tập về chăm sóc mẹ & bé.

#### Thư viện video
- Video hướng dẫn chăm sóc cơ bản: tắm bé, cho bú, quấn khăn, massage,...
- Phân loại theo độ tuổi bé (0–1 tháng, 1–6 tháng, 6–12 tháng,...)
- Xem trực tiếp trong ứng dụng

#### Tài liệu PDF
- Hướng dẫn dinh dưỡng cho mẹ sau sinh
- Lịch tiêm chủng, biểu đồ tăng trưởng
- Tải xuống để đọc offline

#### Tìm kiếm & phân loại
- Tìm kiếm theo từ khóa
- Lọc theo chủ đề: sơ sinh, trẻ nhỏ, mẹ sau sinh, dinh dưỡng, tâm lý

---

## 👥 Đối Tượng Người Dùng

| Vai trò | Mô tả |
|---|---|
| **Gia đình / Phụ huynh** | Tìm kiếm, đặt lịch và theo dõi caregiver; đọc kiến thức; tham gia cộng đồng |
| **Caregiver** | Quản lý hồ sơ, nhận ca làm việc, ghi nhật ký chăm sóc |
| **Quản trị viên** | Duyệt nội dung, xác minh caregiver, quản lý hệ thống |

---

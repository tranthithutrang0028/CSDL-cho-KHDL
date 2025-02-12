CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);
---chèn dữ liệu
INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan) VALUES
(1, 'Nguyen Van A', 30, 'Ke Toan'),
(2, 'Tran Thi B', 25, 'Nhan Su'),
(3, 'Le Van C', 28, 'IT'),
(4, 'Pham Thi D', 32, 'Ke Toan'),
(5, 'Vu Van E', 26, 'IT'),
(6, 'Nguyen Thi F', 29, 'Marketing'),
(7, 'Le Thi G', 27, 'Nhan Su'),
(8, 'Hoang Van H', 35, 'Ke Toan'),
(9, 'Pham Van I', 33, 'Marketing'),
(10, 'Tran Van J', 24, 'IT'),
(11, 'Dang Thi K', 31, 'Nhan Su'),
(12, 'Nguyen Van L', 28, 'Ke Toan'),
(13, 'Tran Thi M', 26, 'Marketing'),
(14, 'Pham Van N', 30, 'Nhan Su'),
(15, 'Hoang Thi O', 27, 'IT');
--liệt kê nhân vien có họ tên chứ từ 'Nguyen'
SELECT * FROM NhanVien
WHERE HoTen LIKE '%Nguyen%';
---truy cập họ tên và tuổi của nhân viên trong phong IT
SELECT HoTen, Tuoi FROM NhanVien
WHERE PhongBan = 'IT';
---tìm nhân viên có độ tuỏi lớn hơn 25
SELECT * FROM NhanVien
WHERE Tuoi>25;
---biết nhân viên lớn tuổi nhất của các phòng ban
SELECT HoTen, Tuoi, PhongBan
FROM NhanVien
WHERE Tuoi IN (
    SELECT MAX(Tuoi)
    FROM NhanVien
    GROUP BY PhongBan
);
---chuyển đồi phong ban của nhân viên "Lê Văn C " sang "Marketing"
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C';
----xoá nhân viên có MaNV=2, rồi đếm số lượng nhân viên PhongBan
DELETE FROM NhanVien
WHERE MaNV = 2;

SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
FROM NhanVien
GROUP BY PhongBan;

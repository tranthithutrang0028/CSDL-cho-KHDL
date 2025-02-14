-- 1. Kiểm tra và chỉ tạo bảng nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'NhanVien') AND type = N'U')
BEGIN
    CREATE TABLE NhanVien (
        MaNV INT PRIMARY KEY,
        HoTen VARCHAR(50),
        Tuoi INT,
        PhongBan VARCHAR(50)
    );
END;

-- 2. Làm mới dữ liệu trong bảng NhanVien
TRUNCATE TABLE NhanVien;

-- 3. Chèn các bản ghi vào bảng NhanVien
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

-- 4. Truy vấn các nhân viên có họ là 'Nguyen'
SELECT * 
FROM NhanVien
WHERE HoTen LIKE 'Nguyen%';

-- 5. Truy vấn họ tên và tuổi của nhân viên trong phòng 'IT'
SELECT HoTen, Tuoi
FROM NhanVien
WHERE PhongBan = 'IT';

-- 6. Truy vấn các nhân viên có độ tuổi lớn hơn 25
SELECT *
FROM NhanVien
WHERE Tuoi > 25;
--7. NHÂN VIÊN LỚN TUỔI TRONG CÁC PHÒNG BAN
WITH RankedNhanVien AS (
    SELECT MaNV, HoTen, Tuoi, PhongBan,
           RANK() OVER (PARTITION BY PhongBan ORDER BY Tuoi DESC) AS RankNum
    FROM NhanVien
)
SELECT MaNV, HoTen, Tuoi, PhongBan
FROM RankedNhanVien
WHERE RankNum = 1;
--8 sửa đổi phòng ban của "Le Van C" sang "MAKETING"
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C';
--9 xóa nhân viên có MASV = 2
DELETE FROM NhanVien
WHERE MaNV = 2;
-- số người còn trong phòng ban
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
FROM NhanVien
GROUP BY PhongBan;

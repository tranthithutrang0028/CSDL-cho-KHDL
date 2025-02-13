---Phạm Thị Ngọc Tú 22174600090
---1. Tao bang NhanVien
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);

---2. Chen cac bang ghi vao bang NhanVien
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

---3.Lay toan bo thong tin cua nhan vien trong bang NhanVien
SELECT * FROM NhanVien;

---4. Truy van HoTen va Tuoi cua cac nhan vien trong phong IT
SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';

---5. Tim nhan vien co do tuoi lon hon 25
SELECT * FROM NhanVien WHERE Tuoi > 25;

---6. Cho biet nhan vien lon tuoi nhat cua cac phong ban
SELECT PhongBan, HoTen, Tuoi
FROM NhanVien
WHERE Tuoi IN (
    SELECT MAX(Tuoi)
    FROM NhanVien
    GROUP BY PhongBan
);

---7. Chuyen doi thong tin PhongBan cua nhan vien "Le Van C" sang "Marketing"
UPDATE NhanVien 
SET PhongBan = 'Marketing' 
WHERE HoTen = 'Le Van C';

---Kiem tra
SELECT * 
FROM NhanVien
WHERE HoTen = 'Le Van C';

--8. Xoa nhan vien co "MaSV = 2" roi cho biet moi phong ban co bao nhieu nguoi
DELETE FROM NhanVien WHERE MaNV = 2;
--Dem so nhan vien sau khi xoa
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
FROM NhanVien
GROUP BY PhongBan;



#9 Trình bày các bước kết nối đến SQLite trong Python và thực thi các câu lệnh trên bằng Python.
import sqlite3

# Kết nối đến cơ sở dữ liệu
conn = sqlite3.connect("nhanvien.db")
cursor = conn.cursor()

# Thực hiện truy vấn: Lấy toàn bộ nhân viên
cursor.execute("SELECT * FROM NhanVien")
rows = cursor.fetchall()
for row in rows:
    print(row)

# Truy vấn nhân viên trong phòng IT
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT'")
it_employees = cursor.fetchall()
print(it_employees)

# Cập nhật phòng ban của nhân viên "Le Van C"
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE MaNV = 3")
conn.commit()

# Xóa nhân viên có MaNV = 2
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2")
conn.commit()

# Đếm số nhân viên theo từng phòng ban
cursor.execute("SELECT PhongBan, COUNT(*) FROM NhanVien GROUP BY PhongBan")
departments = cursor.fetchall()
print(departments)

# Đóng kết nối
conn.close()

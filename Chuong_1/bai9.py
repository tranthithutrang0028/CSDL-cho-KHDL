import sqlite3

# Kết nối đến cơ sở dữ liệu (hoặc tạo mới nếu chưa tồn tại)
conn = sqlite3.connect('nhanvien.db')
cursor = conn.cursor()

# Tạo bảng NhanVien
cursor.execute('''
CREATE TABLE IF NOT EXISTS NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);
''')

# Chèn dữ liệu
cursor.executemany('''
INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan) VALUES (?, ?, ?, ?)
''', [
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
    (15, 'Hoang Thi O', 27, 'IT')
])

# Lấy toàn bộ thông tin nhân viên
cursor.execute("SELECT * FROM NhanVien")
print(cursor.fetchall())

# Truy vấn HoTen và Tuoi của các nhân viên trong phòng IT
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT'")
print(cursor.fetchall())

# Tìm nhân viên có độ tuổi lớn hơn 25
cursor.execute("SELECT * FROM NhanVien WHERE Tuoi > 25")
print(cursor.fetchall())

# Nhân viên lớn tuổi nhất của các PhongBan
cursor.execute("SELECT PhongBan, MAX(Tuoi) AS TuoiLonNhat FROM NhanVien GROUP BY PhongBan")
print(cursor.fetchall())

# Chuyển đổi thông tin PhongBan của nhân viên “Le Van C” sang “Marketing”
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE MaNV = 3")

# Xóa nhân viên có MaNV = 2
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2")

# Đếm số lượng nhân viên trong mỗi phòng ban
cursor.execute("SELECT PhongBan, COUNT(*) AS SoLuong FROM NhanVien GROUP BY PhongBan")
print(cursor.fetchall())

# Lưu thay đổi và đóng kết nối
conn.commit()
conn.close()
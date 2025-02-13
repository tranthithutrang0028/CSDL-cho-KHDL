import sqlite3

# 1️⃣ KẾT NỐI ĐẾN SQLITE VÀ TẠO BẢNG
conn = sqlite3.connect("NhanVien.db")  # Kết nối hoặc tạo file nếu chưa có
cursor = conn.cursor()

# Xóa bảng nếu đã tồn tại để chạy lại từ đầu (không bắt buộc)
cursor.execute("DROP TABLE IF EXISTS NhanVien;")

# Tạo bảng NhanVien
cursor.execute("""
    CREATE TABLE NhanVien (
        MaNV INTEGER PRIMARY KEY,
        HoTen VARCHAR(50),
        Tuoi INTEGER,
        PhongBan VARCHAR(50)
    );
""")
conn.commit()
print("[1] Đã tạo bảng NhanVien.")

# 2️⃣ CHÈN DỮ LIỆU VÀO BẢNG
data = [
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
]

cursor.executemany("INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan) VALUES (?, ?, ?, ?);", data)
conn.commit()
print("[2] Đã chèn dữ liệu vào bảng NhanVien.")

# 3️⃣ LẤY TOÀN BỘ THÔNG TIN NHÂN VIÊN
print("\n[3] Danh sách nhân viên:")
cursor.execute("SELECT * FROM NhanVien;")
for row in cursor.fetchall():
    print(row)

# 4️⃣ TRUY VẤN HoTen & Tuoi CỦA NHÂN VIÊN PHÒNG IT
print("\n[4] Danh sách nhân viên phòng IT:")
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';")
for row in cursor.fetchall():
    print(row)

# 5️⃣ TÌM NHÂN VIÊN CÓ TUỔI > 25
print("\n[5] Nhân viên có độ tuổi lớn hơn 25:")
cursor.execute("SELECT * FROM NhanVien WHERE Tuoi > 25;")
for row in cursor.fetchall():
    print(row)

# 6️⃣ NHÂN VIÊN LỚN TUỔI NHẤT TRONG CÁC PHÒNG BAN
print("\n[6] Nhân viên lớn tuổi nhất:")
cursor.execute("""
    SELECT HoTen, Tuoi, PhongBan
    FROM NhanVien
    WHERE Tuoi = (SELECT MAX(Tuoi) FROM NhanVien);
""")
for row in cursor.fetchall():
    print(row)

# 7️⃣ CHUYỂN NHÂN VIÊN "Le Van C" SANG "Marketing"
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE HoTen = 'Le Van C';")
conn.commit()
print("\n[7] Đã cập nhật phòng ban của 'Le Van C' thành 'Marketing'.")

# 8️⃣ XÓA NHÂN VIÊN MaNV = 2 VÀ ĐẾM NHÂN VIÊN MỖI PHÒNG BAN
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2;")
conn.commit()
print("\n[8] Đã xóa nhân viên có MaNV = 2.")

print("\n[8] Số lượng nhân viên trong từng phòng ban:")
cursor.execute("SELECT PhongBan, COUNT(*) AS SoLuongNhanVien FROM NhanVien GROUP BY PhongBan;")
for row in cursor.fetchall():
    print(row)

# Đóng kết nối SQLite
conn.close()
print("\n[9] Đã hoàn thành tất cả các bước!")
-- Tạo cơ sở dữ liệu
CREATE DATABASE SHOP_BAN_DEP1001;
GO
USE SHOP_BAN_DEP1001;
GO


-- Bảng KieuDang
CREATE TABLE KieuDang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
);

-- Thêm dữ liệu vào bảng KieuDang
INSERT INTO KieuDang (ten, trangthai) VALUES 
(N'Kiểu tròn mũi', 1),
(N'Kiểu vuông mũi', 1),
(N'Kiểu mũi nhọn', 1),
(N'Kiểu có quai chéo', 1),
(N'Kiểu quai ngang', 1),
(N'Kiểu quai chéo chồng', 1),
(N'Kiểu dây mảnh', 1),
(N'Kiểu khóa gài', 1);


-- Bảng MauSac
CREATE TABLE MauSac (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
);

-- Thêm dữ liệu vào bảng MauSac
INSERT INTO MauSac (ten, trangthai) VALUES 
(N'Den', 1),          -- Đen
(N'Tranh', 1),        -- Trắng
(N'Do', 1),           -- Đỏ
(N'Vang', 1),         -- Vàng
(N'Xanh lá cây', 1), -- Xanh lá cây
(N'Xanh dương', 1),  -- Xanh dương
(N'Nau', 1),         -- Nâu
(N'Tim', 1),         -- Tím
(N'Cam', 1),         -- Cam
(N'Hong', 1);        -- Hồng

-- Bảng ChatLieu
CREATE TABLE ChatLieu (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trang_thai INTEGER NOT NULL,
);

INSERT INTO ChatLieu (ten, trang_thai) VALUES 
('Da', 1),             -- Chất liệu da
('Vải', 1),            -- Chất liệu vải
('Cao su', 1),         -- Chất liệu cao su
('Nhựa', 1),           -- Chất liệu nhựa
('Len', 1),            -- Chất liệu len
('Lưới', 1),           -- Chất liệu lưới
('Da tổng hợp', 1),    -- Chất liệu da tổng hợp
('Xốp', 1),            -- Chất liệu xốp
('Vải canvas', 1),     -- Chất liệu vải canvas
('Nhung', 1),          -- Chất liệu nhung
('Giả da', 1);         -- Chất liệu giả da


-- Bảng Size
CREATE TABLE Size (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
	trang_thai INTEGER NOT NULL
);

-- Thêm dữ liệu vào bảng Size (kích cỡ dép)
INSERT INTO Size (ten, trang_thai) VALUES 
('35', 1),
('36', 1),
('37', 1),
('38', 1),
('39', 1),
('40', 1),
('41', 1),
('42', 1),
('43', 1),
('44', 1);


-- Bảng DanhMuc
CREATE TABLE DanhMuc (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
    ngay_tao DATE NOT NULL,
    ngay_sua DATE
);

-- Thêm dữ liệu vào bảng DanhMuc
INSERT INTO DanhMuc (ten, trangthai, ngay_tao, ngay_sua) VALUES 
(N'Dép xỏ ngón', 1, '2024-10-14', NULL),
(N'Dép sandal', 1, '2024-10-14', NULL),
(N'Dép quai hậu', 1, '2024-10-14', NULL),
(N'Dép lê', 1, '2024-10-14', NULL),
(N'Dép bệt', 1, '2024-10-14', NULL),
(N'Dép cao gót', 1, '2024-10-14', NULL),
(N'Dép thể thao', 1, '2024-10-14', NULL),
(N'Dép phòng tắm', 1, '2024-10-14', NULL);

-- Bảng SanPham
CREATE TABLE SanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma NVARCHAR(255) UNIQUE NOT NULL,
    ten NVARCHAR(255) NOT NULL,
    trangThai INTEGER NOT NULL,
    anh NVARCHAR(255) NOT NULL,
    thuongHieu NVARCHAR(255) NOT NULL,
    ngayTao DATE,
    ngaySua DATETIME2,
    giaBan DECIMAL(18, 2),
    moTa NVARCHAR(3000),
    gioiTinh BIT,  -- true cho Nam, false cho Nữ
    id_Kieu_dang INT NOT NULL,
    id_chat_lieu INT NOT NULL,
    id_danh_muc_san_pham INT NOT NULL,
    CONSTRAINT fk_kieu_dang_sp FOREIGN KEY (id_Kieu_dang) REFERENCES KieuDang(id),
    CONSTRAINT fk_chat_lieu_sp FOREIGN KEY (id_chat_lieu) REFERENCES ChatLieu(id),
    CONSTRAINT fk_danh_muc_sp FOREIGN KEY (id_danh_muc_san_pham) REFERENCES DanhMuc(id)
);


-- Bảng Anh
CREATE TABLE Anh (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten VARCHAR(255),
    id_san_pham INT,
    FOREIGN KEY (id_san_pham) REFERENCES SanPham(id)
);
CREATE TABLE Vai_Tro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_vai_tro NVARCHAR(50) NOT NULL -- Ví dụ: Admin, NhanVien, KhachHang
);
INSERT INTO Vai_Tro (ten_vai_tro) VALUES 
('ADMIN'), 
('STAFF'),
('CLIENT');
-- Bảng KhachHang
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tai_khoan NVARCHAR(255) UNIQUE NOT NULL, 
    mat_khau NVARCHAR(255) NOT NULL,          
    email NVARCHAR(255) NOT NULL,             
    trang_thai INT ,                  
    id_vai_tro INT NOT NULL,                  
    ngay_tao DATE NOT NULL,                  
    ngay_sua DATE NULL,                       
    CONSTRAINT FK_VaiTro_User FOREIGN KEY (id_vai_tro) REFERENCES Vai_Tro(id)
);
-- Bảng KhachHang
CREATE TABLE Khach_Hang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ho_ten NVARCHAR(255) NOT NULL,            
    sdt VARCHAR(15) NOT NULL,                 
    dia_chi NVARCHAR(255) NOT NULL,          
    user_id INT NOT NULL,                     
    CONSTRAINT FK_User_KhachHang FOREIGN KEY (user_id) REFERENCES Users(id)
);
-- Bảng DiaChi
CREATE TABLE DiaChi (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ho_ten NVARCHAR(255) NOT NULL,
    sdt VARCHAR(15) NOT NULL,
    dia_chi NVARCHAR(500) NOT NULL,
    id_khachHang INT NOT NULL,
    CONSTRAINT fk_khach_hang_dc FOREIGN KEY (id_khachHang) REFERENCES Khach_Hang(id)
);


-- Bảng ChiTietSanPham
CREATE TABLE ChiTietSanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idsanpham INT NOT NULL,  -- Khóa ngoại để liên kết với bảng SanPham
	soLuong int not null,
    trangthai INTEGER,	
    qrcode NVARCHAR(255),
    idmausac INT NOT NULL,
    idsize INT NOT NULL,
    CONSTRAINT fk_san_pham_ctsp FOREIGN KEY (idsanpham) REFERENCES SanPham(id) ON DELETE CASCADE,
    CONSTRAINT fk_mau_sac_ctsp FOREIGN KEY (idmausac) REFERENCES MauSac(id),
    CONSTRAINT fk_size_ctsp FOREIGN KEY (idsize) REFERENCES Size(id)
);

ALTER TABLE ChiTietSanPham
ADD image NVARCHAR(255);


CREATE TABLE NhapHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_chi_tiet_san_pham INT NOT NULL, -- Khóa ngoại đến bảng ChiTietSanPham
    soLuong INT NOT NULL,              -- Số lượng nhập
    giaNhap DECIMAL(18, 2) NOT NULL,   -- Giá nhập
    ngayNhap DATE NOT NULL,            -- Ngày nhập hàng         
    CONSTRAINT fk_chi_tiet_san_pham FOREIGN KEY (id_chi_tiet_san_pham) REFERENCES ChiTietSanPham(id) ON DELETE CASCADE
);
CREATE TABLE dbo.nhan_vien (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    gioi_tinh INT NULL,                       
    cccd NVARCHAR(255) NULL,                
    dia_chi NVARCHAR(255) NULL,             
    email NVARCHAR(255) NULL,               
    ma_nhan_vien NVARCHAR(255) NULL,          
    quoc_tinh NVARCHAR(255) NULL,           
    sdt VARCHAR(15) NOT NULL,           
    ten_nhan_vien NVARCHAR(255) NULL,        
    trang_thai INT NULL,                                                   
    user_id INT NOT NULL,                     
    CONSTRAINT FK_User_NhanVien FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE TrangThai (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL
);

CREATE TABLE HoaDon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    diaChi NVARCHAR(255),
    hoTen NVARCHAR(255),
    sdt VARCHAR(15),
    ngayTao DATETIME,
    ngay_nhan_hang DATETIME,
    ngay_thanh_toan DATE,
    moTa NVARCHAR(255),
	tienShip DECIMAL(18, 2),
    tongTien DECIMAL(18, 2),
    trangThai INT,  -- Khóa ngoại tham chiếu đến TrangThai
    loaiHoaDon BIT, -- Khóa ngoại tham chiếu đến LoaiHoaDon
    phuongThucThanhToan BIT, -- Khóa ngoại tham chiếu đến PhuongThucThanhToan
    hinhThucNhanHang BIT,
    idNhanVien INT,
    idKhachHang INT,
    CONSTRAINT fk_nhan_vien_hd FOREIGN KEY (idNhanVien) REFERENCES nhan_vien(id),
    CONSTRAINT fk_khach_hang_hd FOREIGN KEY (idKhachHang) REFERENCES Khach_Hang(id),
    CONSTRAINT fk_trang_thai FOREIGN KEY (trangThai) REFERENCES TrangThai(id),
);

CREATE TABLE TrangThaiHoaDonChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tenTrangThai NVARCHAR(255) NOT NULL
);

CREATE TABLE HoaDonChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    donGia DECIMAL(18, 2),
    soLuong INT,
    idHoaDon INT,
    idCTSP INT,
    id_trangThai INT,  -- Trạng thái của hóa đơn chi tiết
    CONSTRAINT fk_hoa_don_hdt FOREIGN KEY (idHoaDon) REFERENCES HoaDon(id),
    CONSTRAINT fk_ctsp_hdt FOREIGN KEY (idCTSP) REFERENCES ChiTietSanPham(id),
    CONSTRAINT fk_trang_thai_hdt FOREIGN KEY (id_trangThai) REFERENCES TrangThaiHoaDonChiTiet(id),
);


-- Bảng GioHang
CREATE TABLE GioHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idKhachHang INT,       -- Để có thể nhận giá trị null cho khách lẻ
    ngayTao DATE NOT NULL,
    trangThai INTEGER NOT NULL,
    CONSTRAINT fk_khach_hang_gh FOREIGN KEY (idKhachHang) REFERENCES Khach_Hang(id)
);

-- Bảng GioHangChiTiet
CREATE TABLE GioHangChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idGioHang INT NOT NULL,
    idCTSP INT NOT NULL,
    soLuong INTEGER NOT NULL,
    CONSTRAINT fk_gio_hang_ghct FOREIGN KEY (idGioHang) REFERENCES GioHang(id),
    CONSTRAINT fk_ctsp_ghct FOREIGN KEY (idCTSP) REFERENCES ChiTietSanPham(id)
);


CREATE TABLE KhuyenMai (
    id INT PRIMARY KEY IDENTITY(1,1), -- Sử dụng IDENTITY để tự động tăng ID
    ma NVARCHAR(255) UNIQUE NOT NULL,
    ten NVARCHAR(255) NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    mo_ta NVARCHAR(500), 
    trang_thai INTEGER NOT NULL, -- 0: Không hoạt động, 1: Hoạt động
    loai_giam_gia BIT NOT NULL DEFAULT 0, -- true: Giảm %, false: Giảm VND
    muc_giam DECIMAL(18, 2) -- Thêm cột mức giảm với kiểu DECIMAL
);

GO
-- Bảng ctsp_khuen_mai
CREATE TABLE dbo.ctsp_khuyen_mai (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    don_gia_sau_khi_giam NUMERIC(18, 2) NULL,
    loai_giam_gia BIT NOT NULL,
    muc_giam NUMERIC(18, 2) NOT NULL,
    trang_thai INT NOT NULL,
    id_khuyen_mai INT NOT NULL,
    id_san_pham INT NOT NULL,
    CONSTRAINT FK_ctsp_khuyen_mai_san_pham FOREIGN KEY (id_san_pham) REFERENCES dbo.SanPham(id),
    CONSTRAINT FK_ctsp_khuyen_mai_khuyen_mai FOREIGN KEY (id_khuyen_mai) REFERENCES dbo.KhuyenMai(id)
);
-- Bảng SanPham (sửa lại để có dữ liệu hợp lệ)
INSERT INTO SanPham (ma, ten, trangThai, anh, thuongHieu, ngayTao, giaBan, moTa, gioiTinh, id_Kieu_dang, id_chat_lieu, id_danh_muc_san_pham)
VALUES 
('SP005', N'Dép xỏ ngón cao su', 1, N'anh6.jpg', 'Adidas', '', 199000, N'Dép xỏ ngón cao su thoải mái, chống nước', 0, 2, 3, 1)

-- Bảng ChiTietSanPham
INSERT INTO ChiTietSanPham (idsanpham, trangthai, soLuong, qrcode, idmausac, idsize)
VALUES 
(1, 1,10, 'QRCODE_SP001_RED', 1, 1),   -- Kiểm tra idmausac và idsize có tồn tại
(1, 1,10, 'QRCODE_SP001_BLACK', 2, 2),
(1, 1,15, 'QRCODE_SP001_RED', 1, 2),   
(1, 1,23, 'QRCODE_SP001_BLACK', 4, 2),
(1, 1,9, 'QRCODE_SP001_RED', 3, 1),   -- Kiểm tra idmausac và idsize có tồn tại
(1, 1,10, 'QRCODE_SP001_BLACK', 3, 4),
(1, 1,15, 'QRCODE_SP001_RED', 4, 1),   
(1, 1,23, 'QRCODE_SP001_BLACK', 4, 5);

-- Bảng Anh (sửa lại để đảm bảo id_san_pham hợp lệ)
--INSERT INTO Anh (ten, id_san_pham, id_mau_sac) VALUES
--(N'anh1.jpg', 1, 1),
--(N'anh2.jpg', 1, 2);


INSERT INTO TrangThai (ten) VALUES 
(N'Đang xử lý'),
(N'Đã thanh toán'),
(N'Hủy'),
(N'Đang giao hàng'),
(N'Hoàn thành');



INSERT INTO TrangThaiHoaDonChiTiet (tenTrangThai) VALUES 
(N'Chờ xử lý'),
(N'Đang giao hàng'),
(N'Hoàn tất'),
(N'Đã hủy'),
(N'Đã nhận hàng');






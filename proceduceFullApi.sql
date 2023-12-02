  INSERT INTO [dbo].[SanPhams] ( [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [NgayTao], [Gia], [GiaGiam], [SoLuong], [TrangThai], [LuotXem])
VALUES
    ( 8, N'Áo khoác dù Nam Nữ bigsize ', N'https://lzd-img-global.slatic.net/g/p/f58d7364ec72ca69f1b65384d367aa2c.jpg_400x400q75.jpg_.webp', GETDATE(), 119000, 100000, 50, 1, 12)
    
	(2, N'Tên Sản Phẩm 2', N'/Images/Product2.jpg', GETDATE(), 1500000, 200000, 30, 1, 0),
    ( 1, N'Tên Sản Phẩm 3', N'/Images/Product3.jpg', GETDATE(), 750000, 50000, 80, 1, 0),
    (4, 3, N'Tên Sản Phẩm 4', N'/Images/Product4.jpg', GETDATE(), 2000000, 300000, 40, 1, 0),
    (5, 2, N'Tên Sản Phẩm 5', N'/Images/Product5.jpg', GETDATE(), 1200000, 100000, 60, 1, 0),





/****** Object:  StoredProcedure [dbo].[sp_khach_search]    Script Date: 9/18/2023 2:42:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
ALTER PROCEDURE [dbo].[sp_khach_search] 
(@page_index  INT, 
        @page_size   INT,
		@ten_khach Nvarchar(50),
		@dia_chi Nvarchar(250)
)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        --kiem tra page size != 0
		IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKhachHang,
							  k.TenKH,
							  k.DiaChi

                        INTO #Results1
                        FROM KhachHangs AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKhachHang,
							  k.TenKH,
							  k.DiaChi
                        INTO #Results2
                        FROM KhachHangs AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;


	select * from KhachHangs
	select * from SanPhams
--	{
--  "page": "1",
--  "pageSize": "2",
--  "ten_khach": "Tien Anh",
--  "que_quan": "Hung Yen"
--}--



exec sp_khach_search 3,10, '',''



--------------------------danhh muc -----------------------
----get all cac danh muc
CREATE PROCEDURE sp_get_all_danhmuc 
AS
BEGIN 
	SELECT cm.MaChuyenMuc,
        cm.TenChuyenMuc,
        cm.NoiDung
	FROM ChuyenMucs cm
END

CREATE PROCEDURE danhmuc_ten
    @TenChuyenMuc NVARCHAR(50)
AS
BEGIN
    SELECT
        sp.MaSanPham,
        sp.TenSanPham,
        sp.AnhDaiDien,
        sp.Gia,
        sp.GiaGiam,
        sp.SoLuong,
        sp.TrangThai,
        sp.LuotXem
    FROM
        SanPhams sp
    INNER JOIN
        ChuyenMucs cm ON sp.MaChuyenMuc = cm.MaChuyenMuc
    WHERE
        cm.TenChuyenMuc = @TenChuyenMuc;
END;

exec danhmuc_ten 'Sam Sung'

----crud danh muc
CREATE PROCEDURE sp_them_chuyenmuc
    @TenChuyenMuc nvarchar(50),
    @NoiDung nvarchar(max)
AS
BEGIN
    INSERT INTO ChuyenMucs (TenChuyenMuc, NoiDung)
    VALUES (@TenChuyenMuc, @NoiDung);
END;


CREATE PROCEDURE sp_update_chuyenmuc
    @MaChuyenMuc int,
    @TenChuyenMuc nvarchar(50),
    @NoiDung nvarchar(max)
AS
BEGIN
    UPDATE ChuyenMucs
    SET TenChuyenMuc = @TenChuyenMuc, NoiDung = @NoiDung
    WHERE MaChuyenMuc = @MaChuyenMuc;
END;


CREATE PROCEDURE sp_delete_chuyenmuc
    @MaChuyenMuc int
AS
BEGIN
    DELETE FROM ChuyenMucs
    WHERE MaChuyenMuc = @MaChuyenMuc;
END;





/* tin tuc*/
CREATE TABLE [dbo].[TinTucs](
	[MaTinTuc] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](250) NULL,
	[AnhDaiDien] [nvarchar](max) NULL,
	[MoTa] [nvarchar](250) NULL,
	[NgayTao] [datetime] NULL
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[MaTinTuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_tin_tuc]
AS
    BEGIN
      SELECT  t.MaTinTuc,
			t.TieuDe,
			t.AnhDaiDien,
			t.TacGia,
			t.NgayTao
      FROM TinTucs as t
    END;

	EXEC [sp_get_tin_tuc]



	select pp.TenNhaPhanPhoi ,sp.TenSanPham
	from SanPhams as sp, NhaPhanPhois as pp
	where MaSanPham = 1
	
	/**   **/
	 SELECT
        sp.MaSanPham,
        sppp.MaNhaPhanPhoi,
        npp.TenNhaPhanPhoi,
        sp.TrangThai,
        sp.LuotXem
    FROM
        SanPhams sp
    INNER JOIN
        SanPhams_NhaPhanPhois sppp ON sp.MaSanPham = sppp.MaSanPham
		INNER JOIN NhaPhanPhois npp ON sppp.MaNhaPhanPhoi = npp.MaNhaPhanPhoi
	WHERE sp.MaSanPham = 1;
    

-----------------test npp san cung luc -----
CREATE PROCEDURE [dbo].[sp_add_product_to_distributor]
(
    @TenNhaPhanPhoi nvarchar(250),
    @DiaChi nvarchar(max),
    @SoDienThoai nvarchar(50),
    @MoTa nvarchar(max),
    @MaSanPham int
)
AS
BEGIN
    DECLARE @MaNhaPhanPhoi INT;

    -- Kiểm tra xem nhà phân phối đã tồn tại chưa
    SELECT @MaNhaPhanPhoi = MaNhaPhanPhoi
    FROM NhaPhanPhois
    WHERE TenNhaPhanPhoi = @TenNhaPhanPhoi;

    -- Nếu nhà phân phối chưa tồn tại, thêm mới nhà phân phối
    IF @MaNhaPhanPhoi IS NULL
    BEGIN
        INSERT INTO NhaPhanPhois (TenNhaPhanPhoi, DiaChi, SoDienThoai, MoTa)
        VALUES (@TenNhaPhanPhoi, @DiaChi, @SoDienThoai, @MoTa);

        SET @MaNhaPhanPhoi = SCOPE_IDENTITY();
    END

    -- Thêm sản phẩm vào nhà phân phối
    INSERT INTO SanPhams_NhaPhanPhois (MaSanPham, MaNhaPhanPhoi)
    VALUES (@MaSanPham, @MaNhaPhanPhoi);
END;

exec [sp_add_product_to_distributor] 'Việt Tiến', '', '', '',10





	
CREATE PROCEDURE sp_san_pham_get_all
AS
BEGIN
    SELECT
        sp.MaSanPham,
        sp.TenSanPham,
        sp.AnhDaiDien,
        sp.Gia,
        sp.GiaGiam,
        sp.SoLuong,
        sp.TrangThai,
        sp.LuotXem
    FROM
        SanPhams sp
END;



select * from HoaDons



CREATE PROCEDURE sp_tin_tuc_get_all
AS
BEGIN
    SELECT
        tt.MaTinTuc,
		tt.TieuDe,
		tt.AnhDaiDien,
		tt.TacGia,
		tt.NgayTao
    FROM
        TinTucs tt
END;






----------------------------san pham-----------------------------------------

ALTER PROCEDURE [dbo].[sp_san_pham_search] 
(@page_index  INT, 
 @page_size   INT,
@ten_san_pham Nvarchar(50)
)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        --kiem tra page size != 0
		IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenSanPham ASC)) AS RowNumber, 
                              sp.MaSanPham,
							  sp.TenSanPham,
							  sp.AnhDaiDien, 
							  sp.MaChuyenMuc,
							  sp.Gia,
							  sp.NgayTao,
							  sp.GiaGiam,
							  sp.SoLuong,
							  sp.TrangThai,
							  sp.LuotXem
                        INTO #Results1
                        FROM SanPhams AS sp
					    WHERE  (@ten_san_pham = '' Or sp.TenSanPham like N'%'+@ten_san_pham+'%')      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenSanPham ASC)) AS RowNumber, 
                              sp.MaSanPham,
							  sp.TenSanPham,
							  sp.MaChuyenMuc,
							  sp.AnhDaiDien, 
							  sp.Gia,
							  sp.GiaGiam,
							  sp.NgayTao,
							  sp.SoLuong,
							  sp.TrangThai,
							  sp.LuotXem
                        INTO #Results2
                        FROM SanPhams AS sp
					    WHERE  (@ten_san_pham = '' Or sp.TenSanPham like N'%'+@ten_san_pham+'%')     
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;

	exec sp_san_pham_search 1, 10, ''

--	{
--  "page": "1",
--  "sizePage": "5",
--  "ten_sp": "SamSung"
--}


ALTER PROCEDURE [dbo].[sp_san_pham_search1] 
(
    @page_index INT, 
    @page_size INT,
    @ten_san_pham NVARCHAR(50),
    @status NCHAR
)
AS
BEGIN
    DECLARE @RecordCount BIGINT;

    IF (@page_size <> 0)
    BEGIN
        SET NOCOUNT ON;

        IF @status = 1
        BEGIN
            -- Sắp xếp theo giá tăng dần
            SELECT
                ROW_NUMBER() OVER (ORDER BY Gia ASC) AS RowNumber, 
                MaSanPham,
                TenSanPham,
                AnhDaiDien, 
                MaChuyenMuc,
                Gia,
                NgayTao,
                GiaGiam,
                SoLuong,
                TrangThai,
                LuotXem
            INTO #Results1
            FROM SanPhams
            WHERE @ten_san_pham = '' OR TenSanPham LIKE N'%' + @ten_san_pham + '%';

            SELECT @RecordCount = COUNT(*) FROM #Results1;

            SELECT
                *,
                @RecordCount AS RecordCount
            FROM #Results1
            WHERE ROWNUMBER BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
                OR @page_index = -1;

            DROP TABLE #Results1;
        END
        ELSE
        BEGIN
            -- Sắp xếp theo giá giảm dần (mặc định)
            SELECT
                ROW_NUMBER() OVER (ORDER BY Gia DESC) AS RowNumber, 
                MaSanPham,
                TenSanPham,
                AnhDaiDien, 
                MaChuyenMuc,
                Gia,
                NgayTao,
                GiaGiam,
                SoLuong,
                TrangThai,
                LuotXem
            INTO #Results2
            FROM SanPhams
            WHERE @ten_san_pham = '' OR TenSanPham LIKE N'%' + @ten_san_pham + '%';

            SELECT @RecordCount = COUNT(*) FROM #Results2;

            SELECT
                *,
                @RecordCount AS RecordCount
            FROM #Results2
            WHERE ROWNUMBER BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
                OR @page_index = -1;

            DROP TABLE #Results2;
        END;
    END;
END;


exec sp_san_pham_search1 1, 8, '', '1'




--get all san pham kem chi tiet
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_san_pham_get_all]
AS
BEGIN
    SELECT
        sp.MaSanPham,
        sp.TenSanPham,
        sp.AnhDaiDien,
        sp.Gia,
        sp.GiaGiam,
        sp.SoLuong,
        sp.TrangThai,
        sp.LuotXem,
		(
            SELECT 
                ct.*
            FROM ChiTietSanPhams AS ct
            WHERE ct.MaSanPham = sp.MaSanPham
            FOR JSON PATH
        ) AS list_json_chitietsanpham
    FROM
        SanPhams sp
END;



exec [sp_san_pham_get_all] 


---get san pham tuong tu
ALTER proc sp_sanpham_get_similar 
(
@masanpham int
)
	as
	begin
			select top 4 sp.MaSanPham, TenSanPham, dm.TenChuyenMuc, sp.AnhDaiDien, gia
			from SanPhams sp 
			inner join ChuyenMucs dm on sp.MaChuyenMuc = dm.MaChuyenMuc
			where sp.MaChuyenMuc = (select MaChuyenMuc from SanPhams where masanpham=@masanpham) and masanpham != @masanpham
		end






CREATE PROCEDURE GetAllSanPhamByDanhMuc
    @TenChuyenMuc NVARCHAR(50) = NULL
AS
BEGIN
    IF @TenChuyenMuc IS NOT NULL
    BEGIN
        -- Lấy sản phẩm theo tên danh mục
        SELECT
            sp.MaSanPham,
            sp.TenSanPham,
			cm.TenChuyenMuc,
            sp.AnhDaiDien,
            sp.Gia,
            sp.GiaGiam,
            sp.SoLuong,
            sp.TrangThai,
            sp.LuotXem,
			(
            SELECT 
                ct.*
            FROM ChiTietSanPhams AS ct
            WHERE ct.MaSanPham = sp.MaSanPham
            FOR JSON PATH
        ) AS list_json_chitietsanpham
        FROM
            SanPhams sp
        INNER JOIN
            ChuyenMucs cm ON sp.MaChuyenMuc = cm.MaChuyenMuc
        WHERE
            cm.TenChuyenMuc = @TenChuyenMuc;
    END
    ELSE
    BEGIN
        -- Lấy tất cả sản phẩm
        SELECT
            sp.MaSanPham,
            sp.TenSanPham,
            sp.AnhDaiDien,
            sp.Gia,
            sp.GiaGiam,
            sp.SoLuong,
            sp.TrangThai,
            sp.LuotXem,
			(
            SELECT 
                ct.*
            FROM ChiTietSanPhams AS ct
            WHERE ct.MaSanPham = sp.MaSanPham
            FOR JSON PATH
        ) AS list_json_chitietsanpham
        FROM
            SanPhams sp;
    END
END;







exec GetAllSanPhamByDanhMuc 'Hot'
drop proc GetAllSanPhamByDanhMuc




--------------crud san pham ----------------
--create sp
ALTER PROCEDURE [dbo].[sp_sanpham_create]
(@MaChuyenMuc         INT, 
 @TenSanPham nvarchar(150),
 @AnhDaiDien          NVARCHAR(MAX), 
 @NgayTao         date,  
 @Gia         decimal,  
 @SoLuong         int,  
 @TrangThai         bit, 
 @LuotXem         int, 
 @list_json_ct_sanpham NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaSanPham INT;
        INSERT INTO SanPhams
                (
					MaChuyenMuc,
					TenSanPham,
					AnhDaiDien,
					NgayTao,
					Gia,
					SoLuong,
					TrangThai,
					LuotXem
                )
                VALUES
                (
					@MaChuyenMuc,   
					@TenSanPham,
					 @AnhDaiDien,   
					 @NgayTao,   
					 @Gia,
					 @SoLuong,
					 @TrangThai,    
					 @LuotXem   
                );

				SET @MaSanPham = (SELECT SCOPE_IDENTITY());
                IF(@list_json_ct_sanpham IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietSanPhams
						 (MaSanPham, 
						  MaNhaSanXuat,
                          Anh1, 
                          Anh2,
						  MoTa
                        )
                           SELECT  @MaSanPham, 
							JSON_VALUE(p.value, '$.maNhaSanXuat'), 
                            JSON_VALUE(p.value, '$.anh1'), 
                            JSON_VALUE(p.value, '$.anh2'),
							JSON_VALUE(p.value, '$.moTa')    
                    FROM OPENJSON(@list_json_ct_sanpham) AS p;
                END;
        SELECT '';
    END;

	[sp_sanpham_create]
(@MaChuyenMuc         INT, 
@TenSanPham nvarchar(150),
 @AnhDaiDien          NVARCHAR(MAX), 
 @NgayTao         date,  
 @Gia         decimal,  
 @SoLuong         int,  
 @TrangThai         bit, 
 @LuotXem         int, 
 @list_json_ct_sanpham NVARCHAR(MAX)
)

	exec [sp_sanpham_create] 8, 'Ao thun cuc dep', 'null', '2022/1/1', 232424, 12, 1, 12444, '[]'


  select * from sanphams
	
	select * from ChiTietSanPhams
---update san pham
ALTER PROCEDURE sp_sanpham_update
(@MaSanPham INT,
 @MaChuyenMuc INT, 
 @TenSanPham nvarchar(150),
 @AnhDaiDien NVARCHAR(MAX), 
 @NgayTao  date,  
 @Gia  decimal,  
 @SoLuong  int,  
 @TrangThai  bit, 
 @LuotXem  int
 )
AS
    BEGIN
		UPDATE SanPhams
		SET
			MaChuyenMuc =@MaChuyenMuc,
            TenSanPham= @TenSanPham,
            AnhDaiDien=@AnhDaiDien,
            Gia = @Gia,
            SoLuong =@SoLuong,
            TrangThai= @TrangThai,
            LuotXem =@LuotXem
		WHERE MaSanPham = @MaSanPham;
END;
---- xoa san pham
ALTER PROCEDURE sp_xoa_sanpham(@MaSanPham int)
	AS
    BEGIN
    DELETE FROM SanPhams
	where MaSanPham = @MaSanPham
END;

	{
  "maChuyenMuc": 2,
  "tenSanPham": "Ao nam day mua dong",
  "anhDaiDien": "string",
  "gia": 0,
  "giaGiam": 0,
  "ngayTao": "2023-11-10T05:51:18.275Z",
  "soLuong": 0,
  "trangThai": true,
  "luotXem": 0,
  "list_json_ctsanpham": [
    {

      "anh1": "string",
      "anh2": "string",
      "maNhaSanXuat": 3,
      "moTa": "string"
    }
  ]
}

---get 5 san pham ban chay 

CREATE PROCEDURE sp_get_sanpham_hot
AS
BEGIN
    SELECT TOP 10
        sp.*
    FROM
        dbo.SanPhams sp
    ORDER BY
        sp.LuotXem DESC; 
END;
GO

exec sp_get_sanpham_hot
select * from sanphams



-------------gio hang--------------------------------------
	select ct.*, gh.*
	from GioHangs gh
	inner join TaiKhoans tk ON gh.MaTaiKhoan = tk.MaTaiKhoan
	inner join ChiTiet_GioHangs ct ON gh.CartID = ct.CartID 
	inner join SanPhams sp ON ct.MaSanPham = sp.MaSanPham
	where tk.MaTaiKhoan = 1




CREATE TRIGGER CreateCartAfterInsert
ON TaiKhoans
AFTER INSERT
AS
BEGIN
    DECLARE @NewAccountID INT;
    SELECT @NewAccountID = MaTaiKhoan FROM INSERTED;
    INSERT INTO GioHangs (MaTaiKhoan, NgayTao, TongTien) VALUES (@NewAccountID, GETDATE(), '0');
END;

	--them gio hang
	CREATE PROCEDURE [dbo].[sp_giohang_create]
	( @MaTaiKhoan int,
	 @MaSanPham int,
	 @list_json_chitiet_giohang NVARCHAR(MAX)
	)
	AS 
		BEGIN 
		DECLARE @MaGioHang INT;
		SELECT @MaGioHang = CartID
		FROM GioHangs
		WHERE MaTaiKhoan = @MaTaiKhoan;





exec [sp_giohang_create] 

CREATE PROCEDURE [dbo].[sp_giohang_create]
( 
    @MaTaiKhoan INT,
    @list_json_chitiet_giohang NVARCHAR(MAX)
)
AS 
BEGIN 
    DECLARE @MaGioHang INT;

    -- Lấy mã giỏ hàng từ bảng GioHangs dựa trên mã tài khoản
    SELECT @MaGioHang = CartID
    FROM GioHangs
    WHERE MaTaiKhoan = @MaTaiKhoan;
    IF @list_json_chitiet_giohang IS NOT NULL
    BEGIN

        INSERT INTO ChiTiet_GioHangs (CartID, MaSanPham, SoLuong, Gia)
        SELECT 
            @MaGioHang, 
            JSON_VALUE(p.value, '$.maSanPham'), 
            JSON_VALUE(p.value, '$.soLuong'), 
            JSON_VALUE(p.value, '$.gia')  -- Đảm bảo rằng các tên trường JSON khớp với cơ sở dữ liệu của bạn
        FROM OPENJSON(@list_json_chitiet_giohang) AS p;
    END;
    
    -- Tính toán lại tổng tiền cho giỏ hàng (cập nhật lại tổng tiền trong bảng GioHangs)
  
END;
select * from SanPhams
drop proc [sp_giohang_create]
exec GetCartItemsByAccountID 2
exec  sp_giohang_create 2, ' [
    { "maSanPham" :7,
      "cartID": 0,
      "ngayTao": "2023-10-15T10:22:06.526Z",
      "gia": 0,
      "list_san_pham": [
        { "maSanPham": 7,
          "maChuyenMuc": 0,
          "tenSanPham": "string",
          "anhDaiDien": "string",
          "gia": 0,
          "giaGiam": 0,
          "soLuong": 0,
          "trangThai": true,
          "luotXem": 0
        }
      ]
    }
  ]'
  

  ------chi tite hoa don by id -----
  ALTER  PROCEDURE [dbo].[sp_hoadon_get_by_id](@MaHoaDon int)
AS
    BEGIN
        SELECT h.*, 
        (
            SELECT c.*,
			sp.TenSanPham
            FROM ChiTietHoaDons AS c inner join SanPhams sp ON sp.MaSanPham = c.MaSanPham
            WHERE h.MaHoaDon = c.MaHoaDon FOR JSON PATH
        ) AS list_json_chitiethoadon
        FROM HoaDons AS h
        WHERE  h.MaHoaDon = @MaHoaDon;
    END;
GO

exec [sp_hoadon_get_by_id] 24
select * from HoaDons
select * from ChiTietHoaDons




  ----------------------hoa don ----------------------------
  -----get all hoa don -----
  
ALTER PROCEDURE [dbo].[sp_hoa_don_get_all]
AS
BEGIN
    SELECT
       hd.*,
	   dh.*,
		(
            SELECT 
                cthd.MaChiTietHoaDon,
				cthd.MaHoaDon,
				cthd.MaSanPham,
				cthd.SoLuongXuat,
				cthd.TongGia = sp.Gia * cthd.SoLuongXuat
            FROM ChiTietHoaDons AS cthd 
			inner join SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
            WHERE  hd.MaHoaDon = cthd.MaHoaDon
            FOR JSON PATH
        ) AS list_json_chitiethoadon
    FROM
        HoaDons hd inner join DonHang dh on dh.MaDonHang = hd.MaDonHang
END;

USE [WEBAPI_SALES]
GO

ALTER PROCEDURE [dbo].[sp_hoa_don_get_all]
AS
BEGIN
    SELECT
       hd.*,
       dh.*,
       (
           SELECT 
               cthd.MaChiTietHoaDon,
               cthd.MaHoaDon,
               cthd.MaSanPham,
               cthd.SoLuongXuat,
               cthd.SoLuongXuat * sp.Gia AS TongGia
           FROM ChiTietHoaDons AS cthd 
           INNER JOIN SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
           WHERE hd.MaHoaDon = cthd.MaHoaDon
           FOR JSON PATH
       ) AS list_json_chitiethoadon
    FROM
        HoaDons hd INNER JOIN DonHang dh ON dh.MaDonHang = hd.MaDonHang
END;

select * from ChiTietHoaDons
exec [sp_hoa_don_get_all]
/****** Object:  StoredProcedure [dbo].[sp_hoadon_create]    Script Date: 9/18/2023 4:47:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_hoadon_create]
(@TenKH              NVARCHAR(50), 
 @MaDH INT,
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @TongGia decimal,
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDons
                (MaDonHang,
				TenKH, 
                 Diachi, 
                 TrangThai,
				 TongGia
                )
                VALUES
                (@MaDH,
				@TenKH, 
                 @Diachi, 
                 @TrangThai,
				 @TongGia
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDons
						 (MaSanPham, 
						  MaHoaDon,
						  TongGia,
                          SoLuongXuat             
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
							JSON_VALUE(p.value, '$.tongGia'),
                            JSON_VALUE(p.value, '$.soLuongXuat')   
                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
                END;
        SELECT '';
    END;
select * from ChiTietHoaDons

	-----them chi tiet hoa don 
CREATE PROCEDURE [dbo].[sp_create_ct_hoadon]
    @MaHoaDon INT,
    @MaSanPham INT,
    @SoLuongXuat INT
AS
BEGIN
    INSERT INTO ChiTietHoaDons
    VALUES (@MaHoaDon, @MaSanPham, @SoLuongXuat);
END;
exec sp_create_ct_hoadon 1, 7, 4
select *from HoaDons
select *from ChiTietHoaDons
select *from ChiTiet_DonHang
------get all hoa don va chi tiet hoa don--------



-------------sua hoa don ---------------------
ALTER PROCEDURE [dbo].[sp_hoa_don_update]
(@MaHoaDon        int, 
 @TenKH              NVARCHAR(50), 
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDons
		SET
			TenKH  = @TenKH ,
			Diachi = @Diachi,
			TrangThai = @TrangThai
		WHERE MaHoaDon = @MaHoaDon;
		
		IF(@list_json_chitiethoadon IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDon,
			  JSON_VALUE(p.value, '$.maHoaDon') as maHoaDon,
			  JSON_VALUE(p.value, '$.maSanPham') as maSanPham,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.tongGia') as tongGia,
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadon) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDons (MaSanPham, 
						  MaHoaDon,
                          SoLuongXuat, 
                          TongGia ) 
			   SELECT
				  #Results.maSanPham,
				  @MaHoaDon,	
				  #Results.soLuong,
				  #Results.tongGia			 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDons 
			  SET
				 MaSanPham = #Results.maSanPham,
				 SoLuongXuat = #Results.soLuong,
				 TongGia = #Results.tongGia
			  FROM #Results 
			  WHERE  ChiTietHoaDons.maChiTietHoaDon = #Results.maChiTietHoaDon AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDons C
			INNER JOIN #Results R
				ON C.maChiTietHoaDon=R.maChiTietHoaDon
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;
	select * from ChiTietHoaDons

EXEC [sp_hoa_don_update]
   2, 
   'Tuan Anh', 
   'Quang Ninh', 
   1,  
   '[{
	  "maChiTietHoaDon": 13,
      "maHoaDon": 2,
      "maSanPham": 9,
      "soLuong": 9,
      "tongGia": 90000,
      "status": "2"
   }]';



-----xoa hoa don 
CREATE PROCEDURE [dbo].[sp_hoa_don_delete]
@MaHoaDon int
AS
    BEGIN
       Delete from HoaDons
	   where MaHoaDon = @MaHoaDon;
END;

select * from HoaDons





----tim kiem hoa don theo ngay
ALTER PROCEDURE [dbo].[sp_thong_ke_khach] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuongXuat,
							  h.TongGia,
							  h.NgayTao,
							  h.TenKH,
							  h.Diachi
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  (@ten_khach = '' Or h.TenKH like N'%'+@ten_khach+'%') and ((@fr_NgayTao IS NULL  AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL   AND @to_NgayTao IS NULL   AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL  AND @to_NgayTao IS NOT NULL    AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuongXuat,
							  h.TongGia,
							  h.NgayTao,
							  h.TenKH,
							  h.Diachi
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  (@ten_khach = '' Or h.TenKH like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

	exec sp_thong_ke_khach 1,5, '','2021/01/01','2024/01/01'
	/* api 
	{
  "page": "1",
  "pageSize": "4",
  "tenkhach": "",
  "fr_NgayTao":"2022/01/01",
"to_NgayTao":"2024/01/01"
}*/

ALTER PROCEDURE [dbo].[sp_hoa_don_get_all_test]
    @ten_khach NVARCHAR(50),
    @fr_NgayTao DATETIME,
    @to_NgayTao DATETIME
AS
BEGIN
    SELECT
        hd.*,
        dh.*,
        (
            SELECT 
                cthd.MaChiTietHoaDon,
                cthd.MaHoaDon,
                cthd.MaSanPham,
                cthd.SoLuongXuat,
                cthd.SoLuongXuat * sp.Gia AS TongGia
            FROM ChiTietHoaDons AS cthd 
            INNER JOIN SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
            WHERE hd.MaHoaDon = cthd.MaHoaDon
            FOR JSON PATH
        ) AS list_json_chitiethoadon
    FROM
        HoaDons hd
        INNER JOIN DonHang dh ON dh.MaDonHang = hd.MaDonHang
    WHERE
        (@ten_khach = '' Or hd.TenKH like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND hd.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
AND @to_NgayTao IS NOT NULL
                            AND hd.NgayTao <= @to_NgayTao)
                        OR (hd.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))  
END;
exec [sp_hoa_don_get_all_test] N'Phước Vũ', '2023-02-10','2024-01-01'
exec [sp_hoa_don_get_all_test] '', '',''
ALTER PROCEDURE [dbo].[sp_hoa_don_get_all_test]
    @ten_khach NVARCHAR(50),
    @fr_NgayTao DATETIME,
    @to_NgayTao DATETIME
AS
BEGIN
    IF (@ten_khach = '' AND @fr_NgayTao ='' AND @to_NgayTao = '')
    BEGIN
        -- Trường hợp không có tham số nào truyền vào, lấy tất cả hóa đơn
        SELECT
            hd.*,
            dh.*,
            (
                SELECT 
                    cthd.MaChiTietHoaDon,
                    cthd.MaHoaDon,
                    cthd.MaSanPham,
                    cthd.SoLuongXuat,
                    cthd.SoLuongXuat * sp.Gia AS TongGia
                FROM ChiTietHoaDons AS cthd 
                INNER JOIN SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
                WHERE hd.MaHoaDon = cthd.MaHoaDon
                FOR JSON PATH
            ) AS list_json_chitiethoadon
        FROM
            HoaDons hd INNER JOIN DonHang dh ON dh.MaDonHang = hd.MaDonHang
    END
    ELSE
    BEGIN
        -- Trường hợp có tham số truyền vào, áp dụng điều kiện tìm kiếm
        SELECT
            hd.*,
            dh.*,
            (
                SELECT 
                    cthd.MaChiTietHoaDon,
                    cthd.MaHoaDon,
                    cthd.MaSanPham,
                    cthd.SoLuongXuat,
                    cthd.SoLuongXuat * sp.Gia AS TongGia
                FROM ChiTietHoaDons AS cthd 
                INNER JOIN SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
                WHERE hd.MaHoaDon = cthd.MaHoaDon
                FOR JSON PATH
            ) AS list_json_chitiethoadon
        FROM
            HoaDons hd INNER JOIN DonHang dh ON dh.MaDonHang = hd.MaDonHang
        WHERE 
            (@ten_khach IS NULL OR hd.TenKH LIKE N'%' + @ten_khach + '%')
            AND (
                (@fr_NgayTao IS NULL AND @to_NgayTao IS NULL)
                OR (@fr_NgayTao IS NOT NULL AND @to_NgayTao IS NULL AND hd.NgayTao >= @fr_NgayTao)
                OR (@fr_NgayTao IS NULL AND @to_NgayTao IS NOT NULL AND hd.NgayTao <= @to_NgayTao)
                OR (hd.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))
    END
END;

          


---------------------------------------------------------
	-- Tạo stored procedure
CREATE PROCEDURE GetCartItemsByAccountID
    @MaTaiKhoan INT
AS
BEGIN
    DECLARE @MaGioHang INT;

    -- Lấy MaGioHang từ bảng GioHangs dựa trên MaTaiKhoan
    SELECT @MaGioHang = CartID
    FROM GioHangs
    WHERE MaTaiKhoan = @MaTaiKhoan;

    -- Lấy danh sách sản phẩm từ bảng ChiTietGioHangs dựa trên MaGioHang
    SELECT P.AnhDaiDien ,C.MaSanPham, P.TenSanPham, C.SoLuong, C.Gia
    FROM ChiTiet_GioHangs C
    INNER JOIN SanPhams P ON C.MaSanPham = P.MaSanPham
    WHERE C.CartID = @MaGioHang;
END;
drop proc GetCartItemsByAccountID
exec GetCartItemsByAccountID 2






--TOP 5 SAN PHAM CO LUOT XEM CAO NHAT Lấy sản phẩm có nhiều lượt xem nhất
-- Tạo stored procedure
CREATE PROCEDURE [dbo].[sp_get_3_chu_de]
AS
BEGIN
    -- Lấy sản phẩm bán chạy nhất (sắp xếp theo số lượng đã bán giảm dần)
    -- Lấy sản phẩm xem nhiều nhất (sắp xếp theo lượt xem giảm dần)
    -- Lấy sản phẩm mới nhất (sắp xếp theo ngày tạo giảm dần)
    SELECT *,
	
	(
        SELECT 
            (
                SELECT TOP 8 MaSanPham, TenSanPham, AnhDaiDien, NgayTao, Gia
                FROM SanPhams
                WHERE TrangThai = 1
                ORDER BY SoLuong DESC
                FOR JSON AUTO--lay teb truong lam doi tuong
            ) AS BanChay,
            (
                SELECT TOP 8 MaSanPham, TenSanPham, AnhDaiDien, NgayTao, Gia
                FROM SanPhams
                WHERE TrangThai = 1
                ORDER BY LuotXem DESC
                FOR JSON AUTO
            ) AS XemNhieu,
            (
                SELECT TOP 8 MaSanPham, TenSanPham, AnhDaiDien, NgayTao, Gia
                FROM SanPhams
                WHERE TrangThai = 1
                ORDER BY NgayTao DESC
                FOR JSON AUTO
            ) AS MoiNhat
        FOR JSON PATH
    ) AS AllProduct
	From SanPhams
END;


exec  [sp_get_3_chu_de]



SELECT *
FROM KhachHangs
FOR JSON PATH
SELECT *
FROM KhachHangs
FOR JSON PATH



CREATE PROCEDURE [dbo].[sp_san_pham_get_all]
AS
BEGIN
    SELECT
        sp.MaSanPham,
        sp.TenSanPham,
        sp.AnhDaiDien,
        sp.Gia,
        sp.GiaGiam,
        sp.SoLuong,
        sp.TrangThai,
        sp.LuotXem,
		(
            SELECT 
                ct.*
            FROM ChiTietSanPhams AS ct
            WHERE ct.MaSanPham = sp.MaSanPham
            FOR JSON PATH
        ) AS list_json_chitietsanpham
    FROM
        SanPhams sp
END;


exec [sp_san_pham_get_all]

----check out --- dua thong tin vao don hang , khach hang









---------------nha phan phoi-----------------
CREATE PROCEDURE [dbo].[sp_get_all_npp]
AS
BEGIN
    SELECT
       npp.*
    FROM
        NhaPhanPhois npp
END;



alter PROCEDURE [dbo].[sp_create_nha_phan_phoi]
    @TenNhaPhanPhoi NVARCHAR(250),
    @DiaChi NVARCHAR(MAX),
    @SoDienThoai NVARCHAR(50),
    @MoTa NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO NhaPhanPhois (TenNhaPhanPhoi, DiaChi, SoDienThoai, MoTa)
    VALUES (@TenNhaPhanPhoi, @DiaChi, @SoDienThoai, @MoTa);
END;


---nha phan phoi ra san pham
CREATE PROCEDURE [dbo].[sp_create_npp_sp]
    @MaNhaPhanPhoi INT,
	@MaSanPham INT
AS
BEGIN
    INSERT INTO SanPhams_NhaPhanPhois 
    VALUES (@MaNhaPhanPhoi, @MaSanPham );
END;

exec sp_create_nha_phan_phoi 'Cho Dau Moi', 'Ha Noi','080808767',null, null



--sua nha phan phoi

CREATE PROCEDURE [dbo].[sp_update_nha_phan_phoi]
	@MaNhaPhanPhoi INT,
    @TenNhaPhanPhoi NVARCHAR(250),
    @DiaChi NVARCHAR(MAX),
    @SoDienThoai NVARCHAR(50),
    @MoTa NVARCHAR(MAX)
AS
BEGIN
	UPDATE NhaPhanPhois
    SET 
		TenNhaPhanPhoi = @TenNhaPhanPhoi,
		DiaChi = @DiaChi,
		SoDienThoai = @SoDienThoai,
		MoTa = @MoTa
	WHERE MaNhaPhanPhoi= @MaNhaPhanPhoi;
END;

--xoas
CREATE PROCEDURE [dbo].[sp_npp_delete]
@MaNhaPhanPhoi int
AS
    BEGIN
       Delete from NhaPhanPhois
	   where MaNhaPhanPhoi = @MaNhaPhanPhoi;
    END;

GO



--------------insert đơn hàng gom thong tin khach hang-------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_donhang_create]
(@TenKH nvarchar(50),
 @GioiTinh bit,
 @DiaChi nvarchar(250),
 @SDT nvarchar(50),
 @Email nvarchar(250),
 @NgayDat datetime,
 @MaTK INT,
 @TrangThaiDonHang varchar(10) ,
 @list_json_chitiet_donhang NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaKhachHang INT;
		INSERT INTO KhachHangs (
			TenKH, 
			GioiTinh, 
			DiaChi, 
			SDT, 
			Email
		)
		VALUES (
			@TenKH, 
			@GioiTinh,
			@DiaChi,
			@SDT, 
			@Email
		);
		SET @MaKhachHang = SCOPE_IDENTITY();

		
		DECLARE @MaDonHang INT;
        INSERT INTO DonHang
                (MaKhachHang, 
				 MaTK,
                 NgayDat, 
                 TrangThaiDonHang               
                )
                VALUES
                (@MaKhachHang, 
				@MaTK,
                 @NgayDat, 
                 @TrangThaiDonHang
                );
		SET @MaDonHang = (SELECT SCOPE_IDENTITY());

	
                IF(@list_json_chitiet_donhang IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTiet_DonHang
						 (MaDonHang, 
						  MaSanPham,
                          SoLuong, 
                          GiaMua               
                        )
                     SELECT @MaDonHang, 
						    JSON_VALUE(p.value, '$.maSanPham'), 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.giaMua')    
                    FROM OPENJSON(@list_json_chitiet_donhang) AS p;
                END;
        SELECT '';
    END;



------crud khach hang basic
CREATE PROCEDURE sp_khach_create
    @TenKH nvarchar(50),
    @GioiTinh bit,
    @DiaChi nvarchar(250),
    @SDT nvarchar(50),
    @Email nvarchar(250)
AS
BEGIN
    INSERT INTO KhachHangs (TenKH, GioiTinh, DiaChi, SDT, Email)
    VALUES (@TenKH, @GioiTinh, @DiaChi, @SDT, @Email);
END;

CREATE PROCEDURE sp_khach_update
    @MaKhachHang int,
    @TenKH nvarchar(50),
    @GioiTinh bit,
    @DiaChi nvarchar(250),
    @SDT nvarchar(50),
    @Email nvarchar(250)
AS
BEGIN
    UPDATE KhachHangs
    SET TenKH = @TenKH, GioiTinh = @GioiTinh, DiaChi = @DiaChi, SDT = @SDT, Email = @Email
    WHERE MaKhachHang = @MaKhachHang;
END;

CREATE PROCEDURE sp_khach_hang_delete
    @MaKhachHang int
AS
BEGIN
    DELETE FROM KhachHangs
    WHERE MaKhachHang = @MaKhachHang;
END;

select * from KhachHANGS

	{
  "khach": {
    "tenKH": "Tin quan",
    "gioiTinh": true,
    "diaChi": "ha noi",
    "sdt": "09242034",
    "email": "string"
  },
  "ngayDat": "2023-11-06T03:56:35.382Z",
  "maTK": 3,
  "trangThaiDonHang": "dang xu ly",
  "listchitiet": [
    {
      "maSanPham": 6,
      "soLuong": 2,
      "giaMua": 10000
    },
    {
      "maSanPham": 7,
      "soLuong": 2,
      "giaMua": 10000
    }
  ]
}
	---get don hang by id 
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[sp_get_donhang_by_customer]
(@MaKhachHang INT)
AS
BEGIN
    SELECT *
    FROM DonHang
    WHERE MaKhachHang = @MaKhachHang;
END;
EXEC sp_get_donhang_by_customer @MaKhachHang = 115



---get don hang by trang thai 
ALTER PROCEDURE sp_get_donhang_by_trangthai
( 
@trangThai int
)
AS
BEGIN
 -- Lấy ra cac don hang chua thanh toan
    IF @trangThai = 2
    BEGIN
		SELECT dh.*, kh.*
		FROM DonHang dh
		inner join KhachHangs kh on kh.MaKhachHang = dh.MaKhachHang
		ORDER BY NgayDat DESC
    END
    ELSE IF @trangThai = 0
	BEGIN 
		SELECT  dh.*, kh.MaKhachHang, kh.TenKH, kh.DiaChi
		FROM DonHang dh
		inner join KhachHangs kh on kh.MaKhachHang = dh.MaKhachHang
		WHERE TrangThaiDonHang = 0
		ORDER BY NgayDat DESC
	END

	 ELSE IF @trangThai = 1
	BEGIN 
		SELECT  dh.*, kh.MaKhachHang, kh.TenKH, kh.DiaChi
		FROM DonHang dh
		inner join KhachHangs kh on kh.MaKhachHang = dh.MaKhachHang
		WHERE TrangThaiDonHang = 1
		ORDER BY NgayDat DESC
	END

END
exec sp_get_donhang_by_trangthai 1


----tim kiem don hang 
----get chi tiet don hang

ALTER PROCEDURE [dbo].[sp_get_chitiet_donhang]
	 @MaDonHang INT
AS
BEGIN
	DECLARE @MaKH INT;
	SET @MaKH = (SELECT MaKhachHang FROM DonHang WHERE MaDonHang = @MaDonHang)
    SELECT
        dh.MaDonHang,
		dh.NgayDat,
		dh.TrangThaiDonHang,
		(
            SELECT 
                ctdh.*,
				sp.TenSanPham
            FROM ChiTiet_DonHang AS ctdh inner join SanPhams sp on ctdh.MaSanPham = sp.MaSanPham
            WHERE ctdh.MaDonHang = @MaDonHang
            FOR JSON PATH
        ) AS list_json_chitiet_donhang
		,
		(
		SELECT kh.*
            FROM KhachHangs AS kh
            WHERE kh.MaKhachHang = @MaKH
            FOR JSON PATH	
        ) AS list_json_chitiet_khachhang

    FROM DonHang dh 
	where dh.MaDonHang = @MaDonHang 
END;

exec [sp_get_chitiet_donhang] 40005

CREATE PROCEDURE [dbo].[sp_get_chitiet_donhang1]
	 @MaDonHang INT
AS
BEGIN
	DECLARE @MaKH INT;
	SET @MaKH = (SELECT MaKhachHang FROM DonHang WHERE MaDonHang = @MaDonHang)
    SELECT
        dh.MaDonHang,
		dh.NgayDat,
		dh.TrangThaiDonHang,
		kh.TenKH,
		kh.DiaChi,
		kh.SDT,
		(
            SELECT 
                ctdh.*
            FROM ChiTiet_DonHang AS ctdh
            WHERE ctdh.MaDonHang = @MaDonHang
            FOR JSON PATH
        ) AS list_json_chitiet_donhang
    FROM DonHang dh inner join KhachHangs AS kh on kh.MaKhachHang = @MaKH
	where dh.MaDonHang = @MaDonHang 
END;
exec [sp_get_chitiet_donhang] 2505

{
  "khach": {
    "tenKH": "Nang Tuan",
    "gioiTinh": true,
    "diaChi": "Ha Nam",
    "sdt": "07797554",
    "email": "tienanh@gmail.com"
  },
  "ngayDat": "2023-10-18T04:46:36.343Z",
  "trangThaiDonHang": "Dang xu ly",
  "listchitiet": [
    {
      "maSanPham": 1,
      "soLuong": 1,
      "giaMua": 10230
    }
  ]
}

select * from KhachHangs
select * from DonHang
select * from ChiTiet_DonHang
-----------sua don hang----------------
ALTER PROCEDURE sp_update_donhang
    @MaDonHang INT,
    @NgayDat DATE,
    @TrangThaiDonHang NVARCHAR(50)
AS
BEGIN
    UPDATE [dbo].[DonHang]
    SET
        NgayDat = @NgayDat,
        TrangThaiDonHang = @TrangThaiDonHang
    WHERE MaDonHang = @MaDonHang
END

exec sp_update_donhang 10005, '2023-12-09 17:06:50.860', 1

select * from DonHang

--------------khacg hang ----------------------
CREATE PROCEDURE 
    @MaKhachHang INT,
    @TenKH NVARCHAR(50),
    @GioiTinh BIT,
    @DiaChi NVARCHAR(250),sp_update_khach_hang
    @SDT NVARCHAR(50),
    @Email NVARCHAR(250)
AS
BEGIN
    UPDATE [dbo].[KhachHangs]
    SET
        [TenKH] = @TenKH,
        [GioiTinh] = @GioiTinh,
        [DiaChi] = @DiaChi,
        [SDT] = @SDT,
        [Email] = @Email
    WHERE [MaKhachHang] = @MaKhachHang
END
GO
/* xoa kh*/
CREATE PROCEDURE [dbo].[sp_khach_hang_delete]
@MaKhachHang int
AS
    BEGIN
       Delete from KhachHangs
	   where MaKhachHang = @MaKhachHang;
    END;

GO






----create tin tuc-----


CREATE PROCEDURE [dbo].[sp_create_tin_tuc]
    @TieuDe NVARCHAR(250),
    @AnhDaiDien NVARCHAR(MAX),
    @TacGia NVARCHAR(50),
    @NgayTao NVARCHAR(50)
  
AS
BEGIN
    INSERT INTO TinTucs
    VALUES (@TieuDe, @AnhDaiDien, @TacGia, @NgayTao);
END;

--UPDATE TIN TUC
ALTER PROCEDURE [dbo].[sp_update_tin_tuc]
    @MaTinTuc INT,
	@TieuDe NVARCHAR(250),
    @AnhDaiDien NVARCHAR(MAX),
    @TacGia NVARCHAR(50),
    @NgayTao NVARCHAR(50)
  
AS
BEGIN
    UPDATE TinTucs 
    SET  TieuDe = @TieuDe, 
	AnhDaiDien = @AnhDaiDien, 
	TacGia = @TacGia, 
	NgayTao = @NgayTao
	WHERE MaTinTuc = @MaTinTuc;
END;

SELECT * FROM TinTucs
EXEC [sp_update_tin_tuc] 6, 'NTA', 'NTA','BTA','2022/1/1'

CREATE PROCEDURE [dbo].[sp_tin_tuc_delete]
@MaTinTuc int
AS
    BEGIN
       Delete from TinTucs
	   where MaTinTuc = @MaTinTuc;
    END;

GO
select * from TinTucs

----------Hoa don nhap -----------
create proc sp_getAll_HDN
AS
BEGIN 
	select 
		hddn.MaHoaDon ,
		hddn.MaNhaPhanPhoi ,
		hddn.NgayTao ,
		hddn.KieuThanhToan ,
		hddn.MaTaiKhoan 
	from HoaDonNhaps as hddn
END



------tao hoa don nhap 
ALTER PROCEDURE [dbo].[sp_hoadon_nhap_create]
(
 @MaNhaPhanPhoi INT,
 @NgayTao  date, 
 @KieuThanhToan nchar(50),  
 @MaTaiKhoan INT
)
AS
    BEGIN
        INSERT INTO HoaDonNhaps
                (
				MaNhaPhanPhoi, 
                 NgayTao, 
                 KieuThanhToan,
				 MaTaiKhoan
                )
                VALUES
                (@MaNhaPhanPhoi,
				@NgayTao, 
                 @KieuThanhToan, 
                 @MaTaiKhoan
                );	
    END;

	drop proc [sp_hoadon_nhap_create1]





--ALTER PROCEDURE [dbo].[sp_hoadon_nhap_create1]
--(
--    @MaNhaPhanPhoi INT,
--    @NgayTao  DATE, 
--    @KieuThanhToan NCHAR(50),  
--    @MaTaiKhoan INT,
--    @list_json_chitiethoadonnhap NVARCHAR(MAX),
--    @Status INT
--)
--AS
--BEGIN
--    DECLARE @MaHoaDon INT;
--    DECLARE @MaSanPham INT; 

--    INSERT INTO HoaDonNhaps
--    (
--        MaNhaPhanPhoi, 
--        NgayTao, 
--        KieuThanhToan,
--        MaTaiKhoan
--    )
--    VALUES
--    (
--        @MaNhaPhanPhoi,
--        @NgayTao, 
--        @KieuThanhToan, 
--        @MaTaiKhoan
--    );

--    SET @MaHoaDon = (SELECT SCOPE_IDENTITY());

--    IF (@list_json_chitiethoadonnhap IS NOT NULL)
--    BEGIN
--        IF @Status = 1
--        BEGIN
--            -- Thêm sản phẩm mới vào bảng SanPhams nếu chưa tồn tại
--            INSERT INTO SanPhams
--            (
--                TenSanPham,
--                SoLuong
--            )
--            SELECT
--                JSON_VALUE(p.value, '$.tenSanPham'),
--                JSON_VALUE(p.value, '$.soLuong')
--            FROM OPENJSON(@list_json_chitiethoadonnhap) AS p;
            
--            SET @MaSanPham = (SELECT SCOPE_IDENTITY());

--            -- Thêm sản phẩm vào bảng ChiTietHoaDonNhaps
--            INSERT INTO ChiTietHoaDonNhaps
--            (
--                MaHoaDon,
--                MaSanPham, 
--                SoLuongNhap,
--                DonViTinh,
--                GiaNhap,
--                TongTien            
--            )
--            SELECT
--                @MaHoaDon,
--                @MaSanPham, -- Sử dụng biến mới này
--                JSON_VALUE(p.value, '$.soLuongNhap'), 
--                JSON_VALUE(p.value, '$.donViTinh'), 
--                JSON_VALUE(p.value, '$.giaNhap'), 
--                JSON_VALUE(p.value, '$.tongTien')
--            FROM OPENJSON(@list_json_chitiethoadonnhap) AS p;
--        END
--        ELSE IF @Status = 2
--        BEGIN
--            -- Sử dụng các sản phẩm đã có từ bảng SanPhams
--            INSERT INTO ChiTietHoaDonNhaps
--            (
--                MaHoaDon,
--                MaSanPham, 
--                SoLuongNhap,
--                DonViTinh,
--                GiaNhap,
--                TongTien            
--            )
--            SELECT
--                @MaHoaDon,
--                JSON_VALUE(p.value, '$.maSanPham'), 
--                JSON_VALUE(p.value, '$.soLuongNhap'), 
--                JSON_VALUE(p.value, '$.donViTinh'), 
--                JSON_VALUE(p.value, '$.giaNhap'), 
--                JSON_VALUE(p.value, '$.tongTien')
--            FROM OPENJSON(@list_json_chitiethoadonnhap) AS p;
--        END
--    END;

--    SELECT ''; -- Thêm dấu chấm phẩy vào đây
--END;




exec [sp_hoadon_nhap_create1] 2, '1/1/2023', 'Khi nhận hàng', 1, '
[
    {
	  "tenSanPham":"Ao dep vcl",
      "soLuongNhap": 3,
      "donViTinh": 3,
	  "soLuong": 3,
      "giaNhap": 20000,
	  "tongTien":300000
    }
]', 1

	select * from SanPhams
	exec [sp_hoadon_nhap_create] 2, '1/1/2023', 'Khi nhận hàng', 1, '
[
    {
      "maSanPham": 40,
      "soLuongNhap": "string",
      "donViTinh": 3,
      "giaNhap": "string",
	  "tongTien": "string"
    }
]'
		select * from SanPhams
		select * from HoaDonNhaps
	select * from NhaPhanPhois
---sua hoa don nhap
ALTER PROCEDURE [dbo].[sp_hoa_don_nhap_update]
(   
	@MaHoaDon INT,
	@MaNhaPhanPhoi INT,
    @NgayTao  DATE, 
    @KieuThanhToan NCHAR(50),  
    @MaTaiKhoan INT,
    @list_json_chitiethoadonnhap NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDonNhaps
		SET
			MaNhaPhanPhoi  = @MaNhaPhanPhoi,
			NgayTao = @NgayTao,
			KieuThanhToan = @KieuThanhToan,
			MaTaiKhoan = @MaTaiKhoan
		WHERE MaHoaDon = @MaHoaDon;
		DECLARE @MaSanPham INT;
		IF(@list_json_chitiethoadonnhap IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
				SELECT
					JSON_VALUE(p.value, '$.id') as id,
					JSON_VALUE(p.value, '$.maHoaDon') as maHoaDon,
					JSON_VALUE(p.value, '$.maSanPham') as maSanPham,
					JSON_VALUE(p.value, '$.soLuongNhap') as soLuongNhap,
					JSON_VALUE(p.value, '$.tenSanPham') as tenSanPham,
					JSON_VALUE(p.value, '$.donViTinh') as donViTinh,
					JSON_VALUE(p.value, '$.giaNhap') as giaNhap,
					JSON_VALUE(p.value, '$.tongTien') as tongTien,
					JSON_VALUE(p.value, '$.status') AS status 
				INTO #Results 
				FROM OPENJSON(@list_json_chitiethoadonnhap) AS p;
			----them moi san pham status = 1
				INSERT INTO SanPhams
				(
					TenSanPham,
					SoLuong
				)
				SELECT
				    #Results.tenSanPham,
					#Results.soLuongNhap
				FROM  #Results 
				WHERE #Results.status = '1';
				SET @MaSanPham = SCOPE_IDENTITY();
				-- Thêm sản phẩm vào bảng ChiTietHoaDonNhaps
				INSERT INTO ChiTietHoaDonNhaps
				(
					MaHoaDon,
					MaSanPham, 
					SoLuongNhap,
					DonViTinh, 
					GiaNhap,
					TongTien 
				) 
				SELECT
					@MaHoaDon,
					@MaSanPham,
					#Results.soLuongNhap,
					#Results.donViTinh,
					#Results.giaNhap,
					#Results.tongTien
				FROM  #Results 
				WHERE #Results.status = '1';




			
			-- Thêm sản phẩm có sẵn STATUS = 2
			INSERT INTO ChiTietHoaDonNhaps
				(
					MaHoaDon,
					MaSanPham, 
					SoLuongNhap,
					DonViTinh, 
					GiaNhap,
					TongTien 
				) 
				SELECT
					@MaHoaDon,
					@MaSanPham,
					#Results.soLuongNhap,
					#Results.donViTinh,
					#Results.giaNhap,
					#Results.tongTien
				FROM  #Results 
				WHERE #Results.status = '2';

		----- cập nhật hóa đơn STATUS = 3
			  UPDATE ChiTietHoaDonNhaps 
			  SET
				 MaHoaDon = #Results.maHoaDon,
				 MaSanPham = #Results.maSanPham,
				 SoLuongNhap = #Results.soLuongNhap,
				 DonViTinh = #Results.donViTinh,
				 GiaNhap = #Results.giaNhap,
				 TongTien = #Results.tongTien
			  FROM #Results 
			  WHERE  ChiTietHoaDonNhaps.Id = #Results.id AND #Results.status = '3';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDonNhaps C
			INNER JOIN #Results R
				ON C.id=R.id
			WHERE R.status = '4';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;
	select * from ChiTietHoaDonNhaps

exec sp_hoa_don_nhap_update
	4,
	1,
    '2022-12-12', 
    'Online',  
    1,
	'[
		{
				
		      "maHoaDon": 4,
			  "tenSanPham": "Ao dep nam thun mong",
			  "soLuong": 20,
			  "donViTinh": "Chiec",
			  "giaNhap": 20000,
			  "tongTien": "400000",
			  "status": "1"
		}
	 ]'



	 {
  "maHoaDon": 4,
  "maNhaPhanPhoi": 1,
  "ngayTao": "2023-11-21T04:41:47.147Z",
  "kieuThanhToan": "Online",
  "maTaiKhoan": 1,
  "tongTienHoaDon": 400000,
  "list_json_chitiet_hoa_don_nhap": [
    {
      "maHoaDon": 4,
      "tenSanPham": "San pham moi",
      "soLuong": 2,
      "donViTinh": "Chiec",
      "giaNhap": 20000,
      "tongTien":40000,
      "status": "1"
    }
  ]
}
----get all

ALTER PROCEDURE [dbo].[sp_hoa_don_nhap_get_all]
AS
BEGIN
    SELECT
        hdn.*,
		npp.TenNhaPhanPhoi,
		(
            SELECT 
                ct.Id,
				ct.GiaNhap,
				ct.SoLuongNhap,
				ct.TongTien
            FROM ChiTietHoaDonNhaps AS ct
            WHERE ct.MaHoaDon = hdn.MaHoaDon
            FOR JSON PATH
        ) AS list_json_chitiet_hoa_don_nhap
    FROM
        HoaDonNhaps hdn inner join NhaPhanPhois npp on hdn.MaNhaPhanPhoi = npp.MaNhaPhanPhoi
END;




ALTER PROCEDURE [dbo].[sp_hoa_don_nhap_get_all]
AS
BEGIN
    SELECT
        hdn.*,
	    npp.TenNhaPhanPhoi,
        (
            SELECT 
                ct.Id,
                ct.GiaNhap,
                ct.SoLuongNhap,
                ct.TongTien	
            FROM ChiTietHoaDonNhaps AS ct
            WHERE ct.MaHoaDon = hdn.MaHoaDon
            FOR JSON PATH
        ) AS list_json_chitiet_hoa_don_nhap,
        (
            SELECT 
                SUM(ct.TongTien) -- Tính tổng tiền của chi tiết hóa đơn
            FROM ChiTietHoaDonNhaps AS ct
            WHERE ct.MaHoaDon = hdn.MaHoaDon
        ) AS TongTienHoaDon
    FROM
        HoaDonNhaps hdn inner join NhaPhanPhois npp on hdn.MaNhaPhanPhoi = npp.MaNhaPhanPhoi
END;
exec [sp_hoa_don_nhap_get_all] 
[{"Id":1,"GiaNhap":12000,"SoLuongNhap":12,"TongTien":240000},{"Id":8,"GiaNhap":10000,"SoLuongNhap":16,"TongTien":1600000}]



---get by id hoa don nhap
ALTER PROCEDURE [dbo].[sp_hoa_don_nhap_get_by_id]
    @MaHoaDon INT
AS
BEGIN
    SELECT
        hdn.*,
        npp.TenNhaPhanPhoi,
        (
            SELECT 
                ct.Id,
				ct.MaHoaDon,
				ct.MaSanPham,
				sp.TenSanPham,
                ct.GiaNhap,
				ct.DonViTinh,
                ct.SoLuongNhap,
                ct.TongTien
            FROM ChiTietHoaDonNhaps AS ct  inner join SanPhams sp on sp.MaSanPham = ct.MaSanPham
            WHERE ct.MaHoaDon = hdn.MaHoaDon
            FOR JSON PATH
        ) AS list_json_chitiet_hoa_don_nhap,
        (
            SELECT 
                SUM(ct.TongTien) -- Tính tổng tiền của chi tiết hóa đơn
            FROM ChiTietHoaDonNhaps AS ct
            WHERE ct.MaHoaDon = hdn.MaHoaDon
        ) AS TongTienHoaDon
    FROM
        HoaDonNhaps hdn
    INNER JOIN
        NhaPhanPhois npp ON hdn.MaNhaPhanPhoi = npp.MaNhaPhanPhoi
    WHERE
        hdn.MaHoaDon = @MaHoaDon;
END;

exec [sp_hoa_don_nhap_get_by_id] 4
[{"Id":1,"MaHoaDon":4,"MaSanPham":1,"TenSanPham":"Quần Juvetus","GiaNhap":12000,"DonViTinh":"Chiec","SoLuongNhap":1,"TongTien":20000},{"Id":8,"MaHoaDon":4,"MaSanPham":6,"TenSanPham":"Quần Short Unisex","GiaNhap":10000,"DonViTinh":"Chiec","SoLuongNhap":1,"TongTien":10000},{"Id":16,"MaHoaDon":4,"MaSanPham":42,"TenSanPham":"Ao dep nam thun mong","GiaNhap":20000,"DonViTinh":"Chiec","SoLuongNhap":2,"TongTien":10000},{"Id":20,"MaHoaDon":4,"MaSanPham":46,"TenSanPham":"San pham moi","GiaNhap":20000,"DonViTinh":"Chiec","SoLuongNhap":2,"TongTien":40000},{"Id":21,"MaHoaDon":4,"MaSanPham":47,"TenSanPham":"Ao MU 2024","GiaNhap":10000,"DonViTinh":"Chiec","TongTien":20000},{"Id":22,"MaHoaDon":4,"MaSanPham":48,"TenSanPham":"Ao MC 2025","GiaNhap":12000,"DonViTinh":"Chiec","TongTien":12000}]

select * from SanPhams
select * from HoaDonNhaps
select * from ChiTietHoaDonNhaps







---------------------------TAI KHOAN----------------------------------

CREATE PROCEDURE [dbo].[sp_tai_khoan_delete]
@MaTK int
AS
    BEGIN
       Delete from TaiKhoans
	   where MaTaiKhoan = @MaTK
    END;

GO

------CRUD TAI KHOAN ----

ALTER PROCEDURE [dbo].[sp_tai_khoan_create](
@LoaiTK int,
@TenTK nvarchar(50),
@MatKhau nvarchar(50),
@Email nvarchar(150)
)
AS
    BEGIN
       insert into TaiKhoans(LoaiTaiKhoan,TenTaiKhoan,MatKhau,Email)
	   values(@LoaiTK,@TenTK,@MatKhau,@Email);
    END;
GO









-----------------------LOGIN------------------------------
ALTER PROCEDURE [dbo].[sp_login](@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
BEGIN
    SELECT *
    FROM TaiKhoans
    WHERE TenTaiKhoan COLLATE Latin1_General_CS_AS = @taikhoan
    AND MatKhau COLLATE Latin1_General_CS_AS = @matkhau;
END;


	
--ALTER PROCEDURE [dbo].[sp_get_account_and_details]
--    @tenTaiKhoan nvarchar(50)
--AS
--BEGIN
--    SELECT TK.*,
--	CTTK.MaChitietTaiKhoan, CTTK.HoTen, CTTK.DiaChi, CTTK.SoDienThoai, CTTK.AnhDaiDien
--    FROM TaiKhoans TK
--    LEFT JOIN ChiTietTaiKhoans CTTK ON TK.MaTaiKhoan = CTTK.MaTaiKhoan
--    WHERE TK.TenTaiKhoan COLLATE Latin1_General_CS_AS = @tenTaiKhoan;
--END;

--drop proc sp_get_account_and_details
--exec [sp_get_account_login] 'tienanh'






ALTER PROCEDURE [dbo].[sp_tk_get_chitiet]
	 @MaTaiKhoan INT
AS
BEGIN
    SELECT
        tk.MaTaiKhoan,
        tk.LoaiTaiKhoan,
        tk.TenTaiKhoan,
        tk.MatKhau,
        tk.Email,
		(
            SELECT 
                ct.*
            FROM ChiTietTaiKhoans AS ct
            WHERE ct.MaTaiKhoan = @MaTaiKhoan
            FOR JSON PATH
        ) AS list_json_chitiettaikhoan
    FROM
        TaiKhoans tk
	where tk.MaTaiKhoan = @MaTaiKhoan
END;


exec [sp_tk_get_chitiet] 2




---------------THONG KE-----------------------
ALTER PROCEDURE sp_thongke_doanhthu (
    @fr_NgayTao DateTime,
    @To_NgayTao DateTime

)
AS
BEGIN
    -- Tạo bảng tạm thời để lưu kết quả
    CREATE TABLE #TempResult (
		MaSanPham int,
        TenSanPham NVARCHAR(255),
        DoanhThu DECIMAL(18, 2)
    );

    INSERT INTO #TempResult (MaSanPham,TenSanPham,DoanhThu, TongNhap, TongBan)
    SELECT 
		S.MaSanPham,
        S.TenSanPham,
        SUM((S.Gia * CTHD.SoLuongXuat) - (Id.GiaNhap *  CTHD.SoLuongXuat)) ,
		SUM((S.Gia * CTHD.SoLuongXuat)),
		SUM((Id.GiaNhap *  CTHD.SoLuongXuat))
    FROM SanPhams AS S
    INNER JOIN ChiTietHoaDonNhaps AS id ON S.MaSanPham = id.MaSanPham
    INNER JOIN ChiTietHoaDons AS CTHD ON S.MaSanPham = CTHD.MaSanPham
    INNER JOIN HoaDons AS HD ON CTHD.MaHoaDon = HD.MaHoaDon
    WHERE HD.NgayTao BETWEEN @fr_NgayTao AND @To_NgayTao
    GROUP BY S.MaSanPham, S.TenSanPham;

    -- Trả kết quả qua bản ghi ảo
    SELECT * FROM #TempResult;

    -- Xóa bảng tạm thời sau khi hoàn thành
    DROP TABLE #TempResult;
END;

drop proc sp_thongke_doanhthu
 EXEC sp_thongke_doanhthu1 @fr_NgayTao='2022-01-12 00:00:00.000' , @To_NgayTao ='2023-12-12 00:00:00.000'

 select * from ChiTietHoaDonNhaps
  select * from HoaDons





ALTER PROCEDURE [dbo].[sp_get_revenue_by_product]
    @from_ngaytao date,
    @to_ngaytao date
AS
BEGIN
    SELECT
        SP.MaSanPham,
        SP.TenSanPham,
        SUM((CTHD.SoLuongXuat * SP.Gia) - (CTHN.SoLuongNhap * CTHN.GiaNhap)) AS DoanhThu
    FROM SanPhams SP
    LEFT JOIN ChiTietHoaDons CTHD ON SP.MaSanPham = CTHD.MaSanPham
    LEFT JOIN ChiTietHoaDonNhaps CTHN ON SP.MaSanPham = CTHN.MaSanPham
    LEFT JOIN HoaDons HD ON CTHD.MaHoaDon = HD.MaHoaDon
    WHERE HD.NgayTao >= @from_ngaytao
    AND HD.NgayTao <= @to_ngaytao
    GROUP BY SP.MaSanPham, SP.TenSanPham;
END;

 EXEC [sp_get_revenue_by_product] @from_ngaytao='2022-01-12 00:00:00.000' , @to_ngaytao ='2023-12-12 00:00:00.000'
--test tong doanh thu
ALTER PROCEDURE sp_Tong_Doanh_Thu
    @from_ngaytao DATE,
    @to_ngaytao DATE
AS
BEGIN
    SELECT ISNULL(SUM(DoanhThu), 0) AS TongDoanhThu
    FROM (
        SELECT 
            SUM((CTHD.SoLuongXuat * SP.Gia) - ISNULL((CTHN.SoLuongNhap * CTHN.GiaNhap), 0)) AS DoanhThu
        FROM 
            SanPhams SP
            LEFT JOIN ChiTietHoaDons CTHD ON SP.MaSanPham = CTHD.MaSanPham
            LEFT JOIN ChiTietHoaDonNhaps CTHN ON SP.MaSanPham = CTHN.MaSanPham
            LEFT JOIN HoaDons HD ON CTHD.MaHoaDon = HD.MaHoaDon
        WHERE 
            HD.NgayTao >= @from_ngaytao
            AND HD.NgayTao <= @to_ngaytao
        GROUP BY
            SP.MaSanPham
    ) AS Tong;
END;


 EXEC sp_Tong_Doanh_Thu @from_ngaytao='2022-01-12 00:00:00.000' , @to_ngaytao ='2023-12-12 00:00:00.000'



---danh muc
ALTER PROCEDURE sp_LaySanPhamTheoChucNang
    @ChucNang int
AS
BEGIN
    IF @ChucNang = 1
    BEGIN
        -- Lấy sản phẩm bán chạy nhất
        SELECT TOP 8 sp.*, SUM(CTHD.SoLuongXuat) AS TongSoLuongBan, COUNT(DISTINCT CTHD.MaHoaDon) AS SoDonDatHang
        FROM SanPhams sp
        JOIN ChiTietHoaDons CTHD ON sp.MaSanPham = CTHD.MaSanPham
        WHERE sp.TrangThai = 1
		GROUP BY sp.MaSanPham, sp.MaChuyenMuc ,sp.TenSanPham, sp.AnhDaiDien, sp.Gia, sp.GiaGiam, sp.SoLuong, sp.TrangThai, sp.LuotXem, sp.NgayTao
        ORDER BY SUM(CTHD.SoLuongXuat) DESC;
    END
    ELSE IF @ChucNang = 2
    BEGIN
        -- Lấy sản phẩm có nhiều lượt xem nhất
        SELECT TOP 8 *
        FROM SanPhams
        WHERE TrangThai = 1
        ORDER BY LuotXem DESC;
    END
	ELSE IF @ChucNang = 3
	BEGIN
		-- Lấy sản phẩm mới nhất dựa trên ngày tạo Hóa Đơn Nhập
		SELECT TOP 8 sp.*
		FROM SanPhams sp
		JOIN ChiTietHoaDonNhaps CTHDN ON sp.MaSanPham = CTHDN.MaSanPham
		JOIN HoaDonNhaps HDN ON CTHDN.MaHoaDon = HDN.MaHoaDon
		WHERE sp.TrangThai = 1
		ORDER BY HDN.NgayTao DESC;
	END
	ELSE IF @ChucNang = 4
	BEGIN
	---get quan
		SELECT * 
		FROM SanPhams 
		WHERE MaChuyenMuc = 2
	End
	ELSE IF @ChucNang = 5
	BEGIN
	---get ao
		SELECT * 
		FROM SanPhams 
		WHERE MaChuyenMuc = 3
	End
	ELSE IF @ChucNang = 6
	BEGIN
	---get ao
		SELECT * 
		FROM SanPhams sp inner join ChiTietSanPhams ct on sp.MaSanPham = ct.MaSanPham
	End
    ELSE
    BEGIN
        PRINT 'Chức năng không hợp lệ.';
    END
END








CREATE PROCEDURE ThongKeDoanhThu
    @TuNgay DATE,
    @DenNgay DATE
AS
BEGIN
    SELECT
        CONVERT(VARCHAR(10), dh.NgayDat, 103) AS Ngay,
        SUM(ctdh.SoLuong * ctdh.GiaMua) AS DoanhThu
    FROM
        DonHang dh
        JOIN ChiTiet_DonHang ctdh ON dh.MaDonHang = ctdh.MaDonHang
    WHERE
        dh.NgayDat BETWEEN @TuNgay AND @DenNgay
    GROUP BY
        CONVERT(VARCHAR(10), dh.NgayDat, 103)
    ORDER BY
        Ngay;
END

EXEC ThongKeDoanhThu '2023-01-01', '2023-12-31';


CREATE PROCEDURE TongDoanhThuTrongKhoangNgay
    @TuNgay DATE,
    @DenNgay DATE
AS
BEGIN
    SELECT
        SUM(ctdh.SoLuong * ctdh.GiaMua) AS TongDoanhThu
    FROM
        DonHang dh
        JOIN ChiTiet_DonHang ctdh ON dh.MaDonHang = ctdh.MaDonHang
    WHERE
        dh.NgayDat BETWEEN @TuNgay AND @DenNgay;
END
exec TongDoanhThuTrongKhoangNgay '2023-01-01', '2023-12-31';


ALTER PROCEDURE sp_TongGiaNhap
    @from_ngaytao DATE,
    @to_ngaytao DATE
AS
BEGIN
    SELECT SUM(CTHDN.TongTien) AS TongGiaNhap
    FROM ChiTietHoaDonNhaps CTHDN
    JOIN HoaDonNhaps HDN ON CTHDN.MaHoaDon = HDN.MaHoaDon
    WHERE HDN.NgayTao >= @from_ngaytao AND HDN.NgayTao <= @to_ngaytao;
END;
exec sp_TongGiaNhap '2022-04-15', '2023-12-31';
select * from HoaDonNhaps
select * from ChiTietHoaDonNhaps

CREATE PROCEDURE sp_TongTienBanRa
    @from_ngaytao DATE,
    @to_ngaytao DATE
AS
BEGIN
    SELECT SUM(CTHD.SoLuongXuat * SP.Gia) AS TongTienBanRa
    FROM ChiTietHoaDons CTHD
    JOIN SanPhams SP ON CTHD.MaSanPham = SP.MaSanPham
    JOIN HoaDons HD ON CTHD.MaHoaDon = HD.MaHoaDon
    WHERE HD.NgayTao >= @from_ngaytao AND HD.NgayTao <= @to_ngaytao;
END;
exec sp_TongTienBanRa '2022-04-15', '2023-12-31';
select * from HoaDons
select * from ChiTietHoaDons




---gop 2 bang 
ALTER PROCEDURE sp_TongGiaNhapVaBanRa
    @fr_NgayTao DATE,
    @to_NgayTao DATE
AS
BEGIN
    DECLARE @TongGiaNhap DECIMAL(18, 0) = 0;
    DECLARE @TongTienBanRa DECIMAL(18, 0) = 0;
	DECLARE @TongSoSanPham INT;
    DECLARE @TongSoDonHang INT;
	DECLARE @SoDonBan INT;

    -- Tính tổng giá nhập
    SELECT @TongGiaNhap = SUM(CTHDN.TongTien)
    FROM ChiTietHoaDonNhaps CTHDN
    INNER JOIN HoaDonNhaps HDN ON CTHDN.MaHoaDon = HDN.MaHoaDon
    WHERE HDN.NgayTao >= @fr_NgayTao AND HDN.NgayTao <= @to_NgayTao;

    -- Tính tổng tiền bán ra
    SELECT @TongTienBanRa = SUM(CTHD.SoLuongXuat * SP.Gia)
    FROM ChiTietHoaDons CTHD
    JOIN SanPhams SP ON CTHD.MaSanPham = SP.MaSanPham
    JOIN HoaDons HD ON CTHD.MaHoaDon = HD.MaHoaDon
    WHERE HD.NgayTao >= @fr_NgayTao AND HD.NgayTao <= @to_ngaytao;

	 -- Tính tổng số sản phẩm
    SELECT @TongSoSanPham = COUNT(*)
    FROM SanPhams sp
	WHERE sp.NgayTao >= @fr_NgayTao AND sp.NgayTao <= @to_ngaytao;
    -- Tính tổng số đơn hàng
    SELECT @TongSoDonHang = COUNT(*)
    FROM DonHang dh
	WHERE dh.NgayDat >= @fr_NgayTao AND dh.NgayDat <= @to_ngaytao;

	--So don hang da dc ban
	SELECT @SoDonBan = COUNT(*)
    FROM ChiTietHoaDons CTHD
	INNER JOIN HoaDons HD ON CTHD.MaHoaDon = HD.MaHoaDon
    WHERE NgayTao >= @fr_NgayTao AND NgayTao <= @to_ngaytao;


    -- Trả kết quả về
    SELECT 
		@TongGiaNhap AS TongGiaNhap, 
		@TongTienBanRa AS TongTienBanRa,
		@TongSoSanPham AS TongSoSanPham, 
		@TongSoDonHang AS TongSoDonHang,
		@SoDonBan AS SoDonBan;
END;
exec sp_TongGiaNhapVaBanRa '2023-02-10', '2023-12-31';

select * from HoaDonNhaps
select * from HoaDons





ALTER PROCEDURE sp_SoDonHangTheoNgay
    @fr_NgayTao DATE,
    @to_NgayTao DATE
AS
BEGIN
    SELECT 
        CONVERT(VARCHAR(10), NgayDat, 23) AS Ngay,
        COUNT(MaDonHang) AS SoDonHang
    FROM DonHang
    WHERE NgayDat >= @fr_NgayTao AND NgayDat <= @to_NgayTao
	--note : type 23 la kieu 'yyyy-mm-dd
    GROUP BY CONVERT(VARCHAR(10), NgayDat, 23)
    ORDER BY Ngay;
END;


drop proc sp_SoDonHangTheoNgay
exec sp_SoDonHangTheoNgay '2023-01-01', '2023-12-31';



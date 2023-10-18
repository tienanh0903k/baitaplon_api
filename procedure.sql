
/****** Object:  StoredProcedure [dbo].[sp_khach_search]    Script Date: 9/18/2023 2:42:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_khach_search] 
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
                              k.Id,
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
                              k.Id,
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
	{
--  "page": "1",
--  "pageSize": "2",
--  "ten_khach": "Tien Anh",
--  "que_quan": "Hung Yen"
--}--



exec sp_khach_search 1,10, '',''


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



SELECT * FROM HoaDons

CREATE PROCEDURE [dbo].[sp_thong_ke_khach] (@page_index  INT, 
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
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  h.TenKH,
							  h.Diachi
                        INTO #Results1
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
							  c.SoLuong,
							  c.TongGia,
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

	exec sp_thong_ke_khach 1,4,'','2022/01/01','2024/01/01'
	/* api 
	{
  "page": "1",
  "pageSize": "4",
  "tenkhach": "",
  "fr_NgayTao":"2022/01/01",
"to_NgayTao":"2024/01/01"
}*/



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






--san pham

CREATE PROCEDURE [dbo].[sp_san_pham_search] 
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
							  sp.Gia,
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
							  sp.AnhDaiDien, 
							  sp.Gia,
							  sp.GiaGiam,
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



	exec sp_san_pham_search 1, 5, 'SamSung'

--	{
--  "page": "1",
--  "sizePage": "5",
--  "ten_sp": "SamSung"
--}





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








	---gio hang
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











/****** Object:  StoredProcedure [dbo].[sp_hoadon_create]    Script Date: 9/18/2023 4:47:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_hoadon_create]
(@TenKH              NVARCHAR(50), 
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDons
                (TenKH, 
                 Diachi, 
                 TrangThai               
                )
                VALUES
                (@TenKH, 
                 @Diachi, 
                 @TrangThai
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDons
						 (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia               
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.tongGia')    
                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
                END;
        SELECT '';
    END;




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

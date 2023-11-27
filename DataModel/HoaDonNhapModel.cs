using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonNhapModel
    {
        public int MaHoaDon { get; set; }
        public int MaNhaPhanPhoi { get; set; }
        public DateTime NgayTao { get; set; }
        public string KieuThanhToan { get; set; }
        public int MaTaiKhoan { get; set; }
        public decimal? TongTienHoaDon { get; set; }
        public List<ChiTietHoaDonNhapModel>? list_json_chitiet_hoa_don_nhap { get; set; }
        public string? TenNhaPhanPhoi { get; set; }
    }


    public class ChiTietHoaDonNhapModel
    {
        public int Id { get; set; }
        public int MaHoaDon { get; set; }
        public int MaSanPham { get; set; }
        public string? TenSanPham { get; set; }
        public int? SoLuongNhap { get; set; }
        public string? DonViTinh { get; set; }
        public decimal? GiaNhap { get; set; }
        public decimal? TongTien { get; set; }
        public string? status { get; set; }
    }
}

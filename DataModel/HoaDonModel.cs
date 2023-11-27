using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {
        public int MaHoaDon { get; set; }
        public int MaDonHang { get; set; }
        public string TenKH { get; set; }
        public string Diachi { get; set; }
        public DateTime NgayTao { get; set; }
        public decimal TongGia { get; set; }
        public bool TrangThai { get; set; }
        public string? SDT { get; set; }
        public List<ChiTietHoaDonModel> list_json_chitiethoadon { get; set; }
    }
    public class ChiTietHoaDonModel
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDon { get; set; }        
        public int MaSanPham { get; set; }
        public string? TenSanPham { get; set; }
        public decimal TongGia { get; set; } 
        public int SoLuongXuat { get; set; }
        public string? status   { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DonHangModel
    {
        public KhachModel? Khach { get; set; }
        public DateTime NgayDat { get; set; }
        public int? MaDonHang { get; set; }
        public int? MaTK { get; set; }
        public int? MaKH { get; set; }
        public string TrangThaiDonHang { get; set; }
        public List<ChiTietDonHang>? list_json_chitiet_donhang { get; set; }
        public string? TenKH { get; set; }
        public string? DiaChi { get; set; }
        public List<KhachHangModel>? list_json_chitiet_khachhang { get; set; }

    }
        
    public class ChiTietDonHang
    {
        public int MaChiTietDonHang { get; set; }
        public int MaDonHang { get; set; }
        public int MaSanPham { get; set; }
        public string? TenSanPham { get; set;}
        public int SoLuong { get; set; }
        public decimal GiaMua { get; set; }
    }

    public class KhachHangModel
    {
        public int Id { get; set; }
        public string TenKH { get; set; }
        public bool GioiTinh { get; set; }
        public string DiaChi { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }

    }




}

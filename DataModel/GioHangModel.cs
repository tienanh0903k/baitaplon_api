using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class GioHangModel
    {
        //public int CartID { get; set; }
        public int MaTaiKhoan { get; set; }
        //public decimal TongTien { get; set; }
        //public string TenSanPham { get; set; }
        //public string AnhDaiDien { get; set; }
        public List<ChiTietGioHang> list_ct_gio_hang { get; set; }
    }

    public class ChiTietGioHang
    {
        public int CartID { get; set;}
        public int MaSanPham { get; set; }  
        public DateTime NgayTao { get; set; }
        public int SoLuong { get; set; }
        public decimal Gia { get; set; }

    }

    public class SanPhamModels
    {
        public int MaChuyenMuc { get; set; }
        public string TenSanPham { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia { get; set; }
        public decimal GiaGiam { get; set; }
        public int SoLuong { get; set; }
        public bool TrangThai { get; set; }
        public int LuotXem { get; set; }
    }
}

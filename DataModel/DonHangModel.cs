using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DonHangModel
    {
        public KhachModel Khach { get; set; }
        public DateTime NgayDat { get; set; }
        public string TrangThaiDonHang { get; set; }
        public List<ChiTietDonHang> listchitiet { get; set; }
    }

    public class ChiTietDonHang
    {
        public int MaChiTietDonHang { get; set; }
        public int MaDonHang { get; set; }
        public int MaSanPham { get; set; }
        public int SoLuong { get; set; }
        public decimal GiaMua { get; set; }
    }
}

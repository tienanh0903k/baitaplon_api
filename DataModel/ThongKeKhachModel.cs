using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ThongKeKhachModel
    {
        public int MaSanPham { get; set; }
        public string TenSanPham { get; set; }
        public int SoLuong { get; set; }
        public Decimal TongGia { get; set; }
        public DateTime NgayTao { get; set; }
        public string TenKH { get; set; }   
        public string Diachi { get; set; }
    }

    public class ThongKeDon
    {
        public string Ngay { get; set; }
        public string SoDonHang { get; set; }
    }


    public class TongQuan
    {
        public string TongGiaNhap { get; set; }
        public string TongTienBanRa { get; set; }
        public string TongSoSanPham { get; set; }
        public string TongSoDonHang { get; set; }

    }

}

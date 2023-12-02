using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DanhMucModel
    {
        public int MaChuyenMuc { get; set; }
        public string TenChuyenMuc { get; set; }
        public string NoiDung { get; set; }
        public int MaSanPham { get; set; }
        public string TenSanPham { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia { get; set; }
        public decimal GiaGiam { get; set; }
        public int SoLuong { get; set; }
        public bool TrangThai { get; set; }
        public int LuotXem { get; set; }
    }

    public class LoaiSanPhamModel
    {
        public int MaChuyenMuc { get; set; }
        public string? TenChuyenMuc { get; set; }
        public string? NoiDung { get; set; }
    }
}

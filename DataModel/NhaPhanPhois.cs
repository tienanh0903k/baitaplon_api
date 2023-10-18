using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class NhaPhanPhois
    {
        public int MaNhaPhanPhoi { get; set; }
        public int MaSanPham { get; set; }
        public string TenNhaPhanPhoi { get; set; }
        public string DiaChi { get; set; }
        public string SoDienThoai { get; set; }
        public string Fax { get; set; }
        public string MoTa { get; set; }
    }

    public class NhaPhanPhois_SanPham
    {
        public int MaNhaPhanPhoi { get; set; }
        public int MaSanPham { get; set; }
 
    }

}

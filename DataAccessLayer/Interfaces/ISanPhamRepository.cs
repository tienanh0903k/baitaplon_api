using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public interface ISanPhamRepository
    {
        SanPhamModels GetDatabyID(int id);

        List<SanPhamModels> GetAll(string danh_muc);
        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp);
        List<AllProducts> GetAllHome();

        bool Create(SanPhamModels model);
    }
}

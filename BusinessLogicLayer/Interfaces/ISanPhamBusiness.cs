using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface ISanPhamBusiness
    {
        SanPhamModels GetDatabyID(int id);

        bool Create(SanPhamModels model);
        List<SanPhamModels> GetAll(string ten_cm);
        List<AllProducts> GetAllHome();
        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp);

    }
}

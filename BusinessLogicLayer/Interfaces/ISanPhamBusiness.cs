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
        List<SanPhamModels> GetAll(string ten_cm);
        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp);

    }
}

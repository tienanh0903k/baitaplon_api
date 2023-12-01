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
        List<SanPhamModels> GetAll();
        SanPhamModels GetDatabyID(int id);
        bool Create(SanPhamModels model); 
        bool Update(SanPhamModels model);
        //user
        List<SanPhamModels> GetByTheLoai(int ten_cm);
        List<AllProducts> GetAllHome();
        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp);

    }
}

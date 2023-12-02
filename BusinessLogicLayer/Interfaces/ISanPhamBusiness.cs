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
        bool Delete(int maSanPham);
        //user
        List<SanPhamModels> GetByTheLoai(int ten_cm);
        List<AllProducts> GetAllHome();
        List<SanPhamModels> GetSanPhamHot();

        List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp);
        List<SanPhamModels> Search1(int pageIndex, int pageSize, out long total,  string status, string ten_sp);

    }
}

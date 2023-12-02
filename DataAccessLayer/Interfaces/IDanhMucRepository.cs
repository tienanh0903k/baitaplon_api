using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public partial interface IDanhMucRepository
    {
        List<DanhMucModel> GetAllDanhMuc();
        List<DanhMucModel> GetDanhMuc(string name);
        List<DanhMucModel> GetSimilar(int maDM);

        //crud
        bool Create(LoaiSanPhamModel model);
        bool Update(LoaiSanPhamModel model);
        bool Delete(LoaiSanPhamModel model);

    }
}

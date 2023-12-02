using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class DanhMucBusiness: IDanhMucBusiness
    {
        private IDanhMucRepository _res;
        public DanhMucBusiness(IDanhMucRepository res)
        {
            _res = res;
        }

        public List<DanhMucModel> GetAllDanhMuc()
        {
            return _res.GetAllDanhMuc();
        }
        public List<DanhMucModel> GetDanhMuc(string name)
        {
            return _res.GetDanhMuc(name);
        }

        public List<DanhMucModel> GetSimilar(int tenDM)
        {
            return _res.GetSimilar(tenDM);
        }


        public bool Create(LoaiSanPhamModel model)
        {
            return _res.Create(model);
        }
        public bool Update(LoaiSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(LoaiSanPhamModel model)
        {
            return _res.Delete(model);
        }
    }
}

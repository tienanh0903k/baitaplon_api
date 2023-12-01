using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System.Reflection;

namespace BusinessLogicLayer
{
    public class SanPhamBusiness: ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }

        //for admin
        public SanPhamModels GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public List<SanPhamModels> GetByTheLoai(int ten_cm)
        {
            return _res.GetByTheLoai(ten_cm);
        }

        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_sp);
        }

        public bool Create(SanPhamModels model)
        {
            return _res.Create(model);
        }

        public bool Update(SanPhamModels model)
        {
            return _res.Update(model);
        }


        //get all trang chu cho nguoi dung
        public List<AllProducts> GetAllHome()
        {
            return _res.GetAllHome();
        }


        public List<SanPhamModels> GetAll()
        {
            return _res.GetAll();
        }
    }
}

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
        public SanPhamModels GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public List<SanPhamModels> GetAll()
        {
            return _res.GetAll();
        }
    }
}

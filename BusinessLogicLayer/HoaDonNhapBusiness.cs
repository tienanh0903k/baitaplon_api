using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class HoaDonNhapBusiness : IHoaDonNhapBusiness
    {
        private IHoaDonNhapRepository _res;

        public HoaDonNhapBusiness(IHoaDonNhapRepository res)
        {
            _res = res;
        }

        public List<HoaDonNhapModel> GetAll()
        {
            return _res.GetAll();
        }

        public HoaDonNhapModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public bool Create(HoaDonNhapModel model)
        {
            return _res.Create(model);
        }

        public bool Update(HoaDonNhapModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(HoaDonNhapModel model)
        {
            return _res.Delete(model);
        }
    }
}

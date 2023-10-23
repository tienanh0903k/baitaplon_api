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
        private IHoaDonNhapBusiness _bus;

        public HoaDonNhapBusiness(IHoaDonNhapBusiness bus)
        {
            _bus = bus;
        }

        public List<HoaDonNhapModel> GetAll()
        {
            return _bus.GetAll();
        }
    }
}

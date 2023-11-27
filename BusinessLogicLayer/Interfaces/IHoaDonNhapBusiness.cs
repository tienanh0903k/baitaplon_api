using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonNhapBusiness
    {
        List<HoaDonNhapModel> GetAll();
        HoaDonNhapModel GetDatabyID(int id);
        bool Create(HoaDonNhapModel model);
        bool Update(HoaDonNhapModel model);
        bool Delete(HoaDonNhapModel model);
    }
}

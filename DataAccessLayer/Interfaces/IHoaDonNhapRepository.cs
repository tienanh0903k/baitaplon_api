using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public partial interface IHoaDonNhapRepository
    {
        List<HoaDonNhapModel> GetAll();
        HoaDonNhapModel GetDatabyID(int id);
        bool Create(HoaDonNhapModel model);
        bool Update(HoaDonNhapModel model);
        bool Delete(HoaDonNhapModel model);
    }
}

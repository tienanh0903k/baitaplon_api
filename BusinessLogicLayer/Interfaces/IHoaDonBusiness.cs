using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonBusiness
    {
        List<HoaDonModel> GetAll();
        HoaDonModel GetDatabyID(int id);
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
        //bool Delete(HoaDonModel model);
        public bool Delete(int maHoaDon);
        public List<HoaDonModel> SearchKH(string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);

        public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}

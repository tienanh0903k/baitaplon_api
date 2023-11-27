using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System.Reflection;

namespace BusinessLogicLayer
{
    public class HoaDonBusiness:IHoaDonBusiness
    {
        private IHoaDonRepository _res;
        public HoaDonBusiness(IHoaDonRepository res)
        {
            _res = res;
        }

        public List<HoaDonModel> GetAll()
        {
            return _res.GetAll();
        }
        public HoaDonModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(HoaDonModel model)
        {
            return _res.Create(model);
        }
        public bool Update(HoaDonModel model)
        {
            return _res.Update(model);
        }

        //public bool Delete(HoaDonModel model)
        //{
        //    return _res.Delete(model);
        //}
        public bool Delete(int maHoaDon)
        {
            return _res.Delete(new HoaDonModel { MaHoaDon = maHoaDon });
        }

        public List<HoaDonModel> SearchKH(string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.SearchKH(ten_khach,fr_NgayTao,to_NgayTao);
        }

        public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_khach, fr_NgayTao, to_NgayTao);
        }
    }
}
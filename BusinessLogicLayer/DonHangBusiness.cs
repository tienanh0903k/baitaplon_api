using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;
using DataAccessLayer;

namespace BusinessLogicLayer
{
    public class DonHangBusiness : IDonHangBusiness
    {
        private IDonHangRepository _res;
        public DonHangBusiness(IDonHangRepository res)
        {
            _res = res;
        }
        public List<DonHangModel> GetTrangThai(int trangthai)
        {
            return _res.GetTrangThai(trangthai);
        }

        public List<DonHangModel> GetDonHangById(int maDH)
        {
            return _res.GetDonHangById(maDH);
        }

        public bool Create(DonHangModel model)
        {
            return _res.Create(model); 
        }

        public bool Update(DonHangModel model)
        {
            return _res.Update(model);
        }

        //thong ke
        public List<ThongKeDon> GetDonHangByDay(DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.GetDonHangByDay(fr_NgayTao, to_NgayTao);
        }

        public List<TongQuan> GetTongQuan(DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.GetTongQuan(fr_NgayTao, to_NgayTao);
        }
    }
}

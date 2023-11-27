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
    }
}

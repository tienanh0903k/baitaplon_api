using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface IDonHangBusiness
    {
        List<DonHangModel> GetDonHangById(int maDH);
        List<DonHangModel> GetTrangThai(int trangthai);
        bool Create(DonHangModel model);
        bool Update(DonHangModel model);
        List<ThongKeDon> GetDonHangByDay(DateTime? fr_NgayTao, DateTime? to_NgayTao);
        List<TongQuan> GetTongQuan(DateTime? fr_NgayTao, DateTime? to_NgayTao);

    }
}

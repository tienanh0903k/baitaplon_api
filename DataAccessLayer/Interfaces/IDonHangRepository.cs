using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public partial interface IDonHangRepository
    {
        List<DonHangModel> GetDonHangById(int maDH);
        List<DonHangModel> GetTrangThai(int trangthai);
        bool Create(DonHangModel model);

        
    }
}

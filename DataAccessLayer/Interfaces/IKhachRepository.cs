using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public partial interface IKhachRepository
    {
        KhachModel GetDatabyID(string id);
        bool Create(KhachModel model);
        bool Update(KhachModel model);
        public List<KhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi);
    }
}

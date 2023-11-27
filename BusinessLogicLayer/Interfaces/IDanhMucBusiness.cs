using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface IDanhMucBusiness
    {
        List<DanhMucModel> GetAllDanhMuc();
        List<DanhMucModel> GetDanhMuc(string name);
        List<DanhMucModel> GetSimilar(int tenDM);
    }
}

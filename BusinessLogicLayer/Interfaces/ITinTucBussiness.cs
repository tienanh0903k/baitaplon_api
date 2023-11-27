using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface ITinTucBussiness
    {
        List<TinTucModel> GetAllTinTuc();
        bool Create(TinTucModel model);
        bool Update(TinTucModel model);
        bool Delete(TinTucModel model);

    }
}

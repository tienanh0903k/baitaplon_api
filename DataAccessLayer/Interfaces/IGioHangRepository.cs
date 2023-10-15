using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public partial interface IGioHangRepository
    {
        bool Create(GioHangModel model);
    }
}

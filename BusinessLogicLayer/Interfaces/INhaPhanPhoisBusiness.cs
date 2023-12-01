using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface INhaPhanPhoisBusiness
    {
        public List<NhaPhanPhois> GetAll();
        bool Create(NhaPhanPhois model);
        bool Update(NhaPhanPhois model);
        bool Delete(int maNPP);
        bool Create(NhaPhanPhois_SanPham model);
    }
}

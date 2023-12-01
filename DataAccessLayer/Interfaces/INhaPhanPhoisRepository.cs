using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public partial interface INhaPhanPhoisRepository
    {
        //get 
        List<NhaPhanPhois> GetAll();
        bool Create(NhaPhanPhois model);

        bool Update(NhaPhanPhois model);
        bool Delete(NhaPhanPhois model);
        //Tao San Pham duoc phan phoi boi nha pp
        bool Create(NhaPhanPhois_SanPham model);
    }
}

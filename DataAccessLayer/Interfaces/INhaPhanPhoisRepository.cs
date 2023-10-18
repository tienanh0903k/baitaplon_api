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
        public bool Create(NhaPhanPhois model);


        //Tao San Pham duoc phan phoi boi nha pp
        public bool Create(NhaPhanPhois_SanPham model);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class NhaPhanPhoisBusiness: INhaPhanPhoisBusiness
    {
        private INhaPhanPhoisRepository _res;
        public NhaPhanPhoisBusiness(INhaPhanPhoisRepository res)
        {
            _res = res;
        }

        public List<NhaPhanPhois> GetAll()
        {
            return _res.GetAll();
        }
        public bool Create(NhaPhanPhois models)
        {
            return _res.Create(models);
        }

        public bool Create(NhaPhanPhois_SanPham models)
        {
            return _res.Create(models);
        }
    }
}

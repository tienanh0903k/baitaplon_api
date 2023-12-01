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

        public bool Update(NhaPhanPhois model)
        {
            return _res.Update(model);
        }


        public bool Delete(int maNPP)
        {
            return _res.Delete(new NhaPhanPhois { MaNhaPhanPhoi = maNPP });
        }

        public bool Create(NhaPhanPhois_SanPham models)
        {
            return _res.Create(models);
        }
    }
}

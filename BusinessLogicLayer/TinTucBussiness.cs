using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class TinTucBussiness: ITinTucBussiness
    {
        private ITinTucRepository _res;
        public TinTucBussiness(ITinTucRepository res)
        {
            _res = res;
        }


        public List<TinTucModel> GetAllTinTuc()
        {
            return _res.GetAllTinTuc();
        }

        public bool Create(TinTucModel model)
        {
            return _res.Create(model);
        }
        public bool Update(TinTucModel model)
        {
            return _res.Update(model);
        }
        
        public bool Delete(TinTucModel model)
        {
            return _res.Delete(model);
        }
    }
}


using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class GioHangBusiness : IGioHangBusiness
    {
        private IGioHangRepository _res;
        public GioHangBusiness(IGioHangRepository res)
        {
            _res = res;
        }
        public bool Create(GioHangModel model)
        {
            return _res.Create(model);
        }
    }
}

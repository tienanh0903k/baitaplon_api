using Microsoft.AspNetCore.Http;
using DataModel;
using BusinessLogicLayer;
using Microsoft.AspNetCore.Mvc;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinTucController : ControllerBase
    {
        private ITinTucBussiness _bus;

        public TinTucController(ITinTucBussiness bus)
        {
            _bus = bus;
        }

        [Route("get-news")]
        [HttpGet]
        public List<TinTucModel> GetAllTinTuc()
        {
            return _bus.GetAllTinTuc(); 
        }

    }
}

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private ISanPhamBusiness _bus;

        public HomeController(ISanPhamBusiness bus)
        {
            _bus = bus;
        }

        [Route("getAll-DM")]
        [HttpGet]
        public List<AllProducts> GetAllByDM()
        {
            return _bus.GetAllHome();
        }
    }
}

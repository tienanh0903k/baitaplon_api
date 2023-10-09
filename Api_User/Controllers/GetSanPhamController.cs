using BusinessLogicLayer;
using Microsoft.AspNetCore.Mvc;
using DataModel;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GetSanPhamController : ControllerBase
    {
        private ISanPhamBusiness _bus;

        public GetSanPhamController(ISanPhamBusiness bus)
        {
            _bus = bus; 
        }

        [HttpGet]
        public List<SanPhamModels> GetAll()
        {
            return _bus.GetAll();
        }
    }
}

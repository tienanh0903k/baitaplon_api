using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DonHangController : ControllerBase
    {
        private IDonHangBusiness _bus;

        public DonHangController(IDonHangBusiness bus)
        {
            _bus = bus;
        }
        [HttpPost]
        [Route("create-donhang")]
        public DonHangModel CreateItem([FromBody] DonHangModel model)
        {
            _bus.Create(model);
            return model;
        }
    }
}

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api_User
{
    [Route("api/[controller]")]
    [ApiController]
    public class GioHangController : ControllerBase
    {
        private IGioHangBusiness _bus;

        public GioHangController(IGioHangBusiness bus)
        {
            _bus = bus;
        }

        [Route("create-giohang")]
        [HttpPost]
        public GioHangModel CreateItem([FromBody] GioHangModel model)
        {
            _bus.Create(model);
            return model;
        }
    }
}

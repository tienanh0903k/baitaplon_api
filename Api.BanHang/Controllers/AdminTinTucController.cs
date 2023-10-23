using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataModel;
using BusinessLogicLayer;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminTinTucController : ControllerBase
    {
        private ITinTucBussiness _bus;

        public AdminTinTucController(ITinTucBussiness bus)
        {
            _bus = bus;
        }

        [HttpPost]
        [Route("post-news")]
        public TinTucModel CreateItem([FromBody] TinTucModel model)
        {
            _bus.Create(model);
            return model;
        }
    }
}

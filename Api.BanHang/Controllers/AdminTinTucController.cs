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

        [Route("get-news")]
        [HttpGet]
        public List<TinTucModel> GetAllTinTuc()
        {
            return _bus.GetAllTinTuc();
        }

        [HttpPost]
        [Route("create-news")]
        public TinTucModel CreateItem([FromBody] TinTucModel model)
        {
            _bus.Create(model);
            return model;
        }
        [HttpPut]
        [Route("update-news")]
        public TinTucModel UpdateItem([FromBody] TinTucModel model)
        {
            _bus.Update(model);
            return model;
        }

        [HttpDelete]
        [Route("delete-news")]
        public TinTucModel DeleteItem([FromBody] TinTucModel model)
        {
            _bus.Delete(model);
            return model;
        }

    }
}

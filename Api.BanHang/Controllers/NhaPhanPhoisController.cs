using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataModel;
using BusinessLogicLayer;
namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhaPhanPhoisController : ControllerBase
    {
        private INhaPhanPhoisBusiness _bus;
        public NhaPhanPhoisController(INhaPhanPhoisBusiness bus)
        {
            _bus = bus;
        }
        [HttpGet]
        [Route("get-all")]
        public List<NhaPhanPhois> GetAll()
        {
            return _bus.GetAll();
        }

        [Route("create-npp")]
        [HttpPost]
        public NhaPhanPhois CreateItem([FromBody] NhaPhanPhois model)
        {
            _bus.Create(model);
            return model;
        }

        [Route("update-npp")]
        [HttpPut]
        public NhaPhanPhois UpdateItem([FromBody] NhaPhanPhois model)
        {
            _bus.Update(model);
            return model;
        }

        [Route("delete/{id}")]
        [HttpDelete]
        public IActionResult DeleteItem(int id)
        {
            bool result = _bus.Delete(id);
            if (result)
            {
                return Ok(new
                {
                    message = "Xoa thanh cong"
                });
            }
            else
            {
                return BadRequest("Xóa không thành công.");
            }

        }


        [Route("create-nhacc-sp")]
        [HttpPost]
        public NhaPhanPhois_SanPham Create([FromBody] NhaPhanPhois_SanPham model)
        {
            _bus.Create(model);
            return model;
        }
    }
}

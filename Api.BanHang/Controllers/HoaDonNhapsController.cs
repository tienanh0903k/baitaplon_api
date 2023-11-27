using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataModel;
using BusinessLogicLayer;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonNhapsController : ControllerBase
    {
        private IHoaDonNhapBusiness _bus;

        public HoaDonNhapsController(IHoaDonNhapBusiness bus)
        {
            _bus = bus;
        }
        [Route("get-All")]
        [HttpGet]
        public List<HoaDonNhapModel> GetAll()
        {
            return _bus.GetAll();
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public HoaDonNhapModel GetDatabyID(int id)
        {
            return _bus.GetDatabyID(id);
        }


        [Route("create-hoadon")]
        [HttpPost]
        public HoaDonNhapModel CreateItem([FromBody] HoaDonNhapModel model)
        {
            _bus.Create(model);
            return model;
        }

        [Route("update-hoadon")]
        [HttpPut]
        public HoaDonNhapModel UpdateItem([FromBody] HoaDonNhapModel model)
        {
            _bus.Update(model);
            return model;
        }

        [Route("delete-hoadon")]
        [HttpDelete]
        public HoaDonNhapModel DeleteItem([FromBody] HoaDonNhapModel model)
        {
            _bus.Delete(model);
            return model;
        }
    }
}

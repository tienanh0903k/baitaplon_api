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
    }
}

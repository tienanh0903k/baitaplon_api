using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhMucController : ControllerBase
    {
        private IDanhMucBusiness _bus;
        public DanhMucController(IDanhMucBusiness bus)
        {
            _bus = bus;
        }

        [HttpGet]
        [Route("get-all")]
        public List<DanhMucModel> GetAllDanhMuc()
        {
            return _bus.GetAllDanhMuc();
        }
    }
}

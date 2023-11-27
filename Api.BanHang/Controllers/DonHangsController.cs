using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DonHangsController : ControllerBase
    {
        private IDonHangBusiness _bus;

        public DonHangsController(IDonHangBusiness bus)
        {
            _bus = bus;
        }
        [HttpGet]
        [Route("get-donhang/{trangthai}")]
        public List<DonHangModel> GetTrangThai(int trangthai)
        {
            return _bus.GetTrangThai(trangthai);
        }

        [HttpGet]
        [Route("get-detail/{maDH}")]
        public List<DonHangModel> GetDonHangById(int maDH)
        {
            return _bus.GetDonHangById(maDH);
        }
    }
}

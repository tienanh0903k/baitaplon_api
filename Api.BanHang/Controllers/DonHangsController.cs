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



        [Route("update-donhang")]
        [HttpPut]
        public DonHangModel Update([FromBody] DonHangModel model)
        {
            _bus.Update(model);
            return model;
        }



        [Route("getByDay")]
        [HttpPost]
        public IActionResult GetDonHangByDay([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                DateTime? fr_NgayTao = null;
                if (formData.Keys.Contains("fr_NgayTao") && formData["fr_NgayTao"] != null && formData["fr_NgayTao"].ToString() != "")
                {
                    var dt = Convert.ToDateTime(formData["fr_NgayTao"].ToString());
                    fr_NgayTao = new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0, 0);
                }
                DateTime? to_NgayTao = null;
                if (formData.Keys.Contains("to_NgayTao") && formData["to_NgayTao"] != null && formData["to_NgayTao"].ToString() != "")
                {
                    var dt = Convert.ToDateTime(formData["to_NgayTao"].ToString());
                    to_NgayTao = new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59, 999);
                }
                var data = _bus.GetDonHangByDay(fr_NgayTao, to_NgayTao);
                return Ok(
                    new
                    {
                        Data = data
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        [Route("getTongQuan")]
        [HttpPost]
        public IActionResult GetTongQuan([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                DateTime? fr_NgayTao = null;
                if (formData.Keys.Contains("fr_NgayTao") && formData["fr_NgayTao"] != null && formData["fr_NgayTao"].ToString() != "")
                {
                    var dt = Convert.ToDateTime(formData["fr_NgayTao"].ToString());
                    fr_NgayTao = new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0, 0);
                }
                DateTime? to_NgayTao = null;
                if (formData.Keys.Contains("to_NgayTao") && formData["to_NgayTao"] != null && formData["to_NgayTao"].ToString() != "")
                {
                    var dt = Convert.ToDateTime(formData["to_NgayTao"].ToString());
                    to_NgayTao = new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59, 999);
                }
                var data = _bus.GetTongQuan(fr_NgayTao, to_NgayTao);
                return Ok(
                    new
                    {
                        Data = data
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}

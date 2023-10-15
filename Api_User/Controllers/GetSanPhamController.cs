using BusinessLogicLayer;
using Microsoft.AspNetCore.Mvc;
using DataModel;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GetSanPhamController : ControllerBase
    {
        private ISanPhamBusiness _bus;

        public GetSanPhamController(ISanPhamBusiness bus)
        {
            _bus = bus; 
        }

        [HttpGet]
        [Route("DanhMuc")]
        public IActionResult GetAllSanPhamByDanhMuc([FromQuery] string? TenChuyenMuc)
        {
            try
            {
                List<SanPhamModels> data = _bus.GetAll(TenChuyenMuc);

                if (data != null && data.Count > 0)
                {
                    return Ok(data);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                // Xử lý hoặc ghi log cho lỗi
                return BadRequest("Lỗi: " + ex.Message);
            }
        }





        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());  
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_sp = "";
                if (formData.Keys.Contains("ten_sp") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_sp"]))) { ten_sp = Convert.ToString(formData["ten_sp"]); }
                string dia_chi = "";
                long total = 0;
                var data = _bus.Search(page, pageSize, out total, ten_sp);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
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

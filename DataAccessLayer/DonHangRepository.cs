using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public class DonHangRepository:IDonHangRepository
    {
        private IDatabaseHelper _dbHelper;

        public DonHangRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public bool Create(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_donhang_create",
                "@TenKH", model.Khach.TenKH,
                "@GioiTinh", model.Khach.GioiTinh,
                "@DiaChi", model.Khach.DiaChi,
                "@SDT", model.Khach.GioiTinh,
                "@Email", model.Khach.Email,
                "@NgayDat", model.NgayDat,
                "@TrangThaiDonHang", model.TrangThaiDonHang,
                "@list_json_chitiet_donhang", model.listchitiet != null ? MessageConvert.SerializeObject(model.listchitiet) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

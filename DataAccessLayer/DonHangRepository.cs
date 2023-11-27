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
        public List<DonHangModel> GetTrangThai(int trangthai)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_donhang_by_trangthai",
                    "@trangThai", trangthai
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<DonHangModel> GetDonHangById(int maDH)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_chitiet_donhang",
                    "@MaDonHang", maDH
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                    throw ex;
            }
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
                "@SDT", model.Khach.SDT,
                "@Email", model.Khach.Email,
                "@NgayDat", model.NgayDat,
                "@MaTK", model.MaTK,
                "@TrangThaiDonHang", model.TrangThaiDonHang,
                "@list_json_chitiet_donhang", model.list_json_chitiet_donhang != null ? MessageConvert.SerializeObject(model.list_json_chitiet_donhang) : null);
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

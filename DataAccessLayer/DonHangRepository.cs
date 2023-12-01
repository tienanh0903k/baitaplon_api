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

        public bool Update(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_donhang",
                "@MaDonHang", model.MaDonHang,
                "@NgayDat", model.NgayDat,
                "@TrangThaiDonHang", model.TrangThaiDonHang);
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


        //thong ke theo ngay
        public List<ThongKeDon> GetDonHangByDay(DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_SoDonHangTheoNgay",
                    "@fr_NgayTao", fr_NgayTao,
                    "@to_NgayTao", to_NgayTao
                     );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<ThongKeDon>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<TongQuan> GetTongQuan(DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_TongGiaNhapVaBanRa",
                    "@fr_NgayTao", fr_NgayTao,
                    "@to_NgayTao", to_NgayTao
                     );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<TongQuan>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

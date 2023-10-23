namespace DataModel
{
    public class UserModel
    {
        public int MaTaiKhoan { get; set; }
        public int LoaiTaiKhoan { get; set; }
        public string TenTaiKhoan { get; set; }
        public string MatKhau { get; set; }
        public string Email { get; set; }
        public string token { get; set; }
        public List<ChiTietTaiKhoan> ChiTietTaiKhoans { get; set; }
    }

    public class ChiTietTaiKhoan
    {
        public int MaChiTietTaiKhoan { get; set; }
        public string HoTen { get; set; }
        public string DiaChi { get; set; }
        public string SoDienThoai { get; set; }
        public string AnhDaiDien { get; set; }
      
    }

}
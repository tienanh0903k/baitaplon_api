var app = angular.module("AppBanHang", []);
app.controller("CheckOut", function ($scope, $http, AuthService) {
  $scope.donHangs = [];
  //thong tin khach hang
  $scope.TenKhachHang;
  $scope.DiaChi;
  $scope.GioiTinh;
  $scope.SoDienThoai;
  $scope.Email;
  $scope.total = 0;

  $scope.Load = function () {
    $scope.donHangs = JSON.parse(localStorage.getItem("cart"));
    $scope.userInfo = AuthService.getUserInfo();
  };
  //check user bat buoc
  $scope.CheckLogin = function () {
    $scope.isLogin = AuthService.checkLogin();
  };

  $scope.logOut = function () {
    AuthService.logOut();
    $scope.isLogin = false;
  };

  //function tinh tong tien
  $scope.TongTien = function () {
    $scope.total = 0;
    for (var i = 0; i < $scope.donHangs.length; i++) {
      var sanpham = $scope.donHangs[i];
      $scope.total += parseInt(sanpham.gia * sanpham.quantity);
    }
    console.log($scope.total);
  };

  //   data = {
  //     {
  //   "khach": {
  //     "id": 0,
  //     "tenKH": "string",
  //     "gioiTinh": true,
  //     "diaChi": "string",
  //     "sdt": "string",
  //     "email": "string"
  //   },
  //   "ngayDat": "2023-11-09T14:44:35.062Z",
  //   "maTK": 0,
  //   "trangThaiDonHang": "string",
  //   "listchitiet": [
  //     {
  //       "maChiTietDonHang": 0,
  //       "maDonHang": 0,
  //       "maSanPham": 0,
  //       "soLuong": 0,
  //       "giaMua": 0
  //     }
  //   ]
  // }
  //   }
  //them don hang
  $scope.ThemDonHang = function (event) {
     event.preventDefault();
    let obj = {};
    obj.khach = {};
    obj.khach.tenKH = $scope.TenKhachHang;
    obj.khach.gioiTinh = $scope.GioiTinh === "true" ? true : false;
    obj.khach.diaChi = $scope.DiaChi;
    obj.khach.sdt = $scope.SoDienThoai;
    obj.khach.email = $scope.Email;
    var currentDate = new Date();
    obj.ngayDat = currentDate;
    obj.maTK = $scope.userInfo.maTaiKhoan;
    obj.trangThaiDonHang = "Dang Xu Ly";
    obj.listchitiet=[];
    donHang = JSON.parse(localStorage.getItem("cart"));
    for (var i = 0; i < donHang.length; i++) {
      obj.listchitiet.push({
        maSanPham: donHang[i].maSanPham,
        soLuong: donHang[i].quantity,
        giaMua: donHang[i].gia,
      });
    }

      $http({
        method: "POST",
        data: obj,
        url: "https://localhost:44323/api/DonHang/create-donhang",
      })
        .then(function (response) {
          if (response.status === 200) {
            alert("Đặt hàng thành công");
            window.localStorage.removeItem("cart");
            $scope.donHangs = [];
          }
        })
        .catch(function (err) {
          console.log("Loi:", err);
        });
  };
  $scope.CheckLogin();
  $scope.Load();
  $scope.TongTien();

  //xoa don hang trong gio hang

  //   $scope.LoadCart = function () {
  //     $scope.listcart = JSON.parse(localStorage.getItem("cart")) || [];
  //     makeScript("js/main.js");
  //   };
  //   $scope.save = function () {
  //     let obj = {};
  //     obj.khach = {};
  //     obj.khach.TenKhachHang = $scope.TenKhachHang;
  //     obj.khach.DiaChi = $scope.DiaChi;
  //     obj.khach.SoDienThoai = $scope.SoDienThoai;
  //     obj.khach.Email = $scope.Email;
  //     obj.listchitiet = [];
  //     let list = JSON.parse(localStorage.getItem("cart"));
  //     for (var i = 0; i < list.length; i++) {
  //       obj.listchitiet.push({
  //         MaSanPham: list[i].maSanPham,
  //         SoLuong: list[i].quantity,
  //         GiaMua: 10,
  //         MaDonHangNavigation: {},
  //       });
  //     }
  //     $http({
  //       method: "POST",
  //       data: obj,
  //       url: current_url + "/api/KhachHang/create-donhang",
  //     }).then(function (response) {
  //       alert("Thêm đơn hàng thành công");
  //     });
  //   };

  //   $scope.LoadCart();
});

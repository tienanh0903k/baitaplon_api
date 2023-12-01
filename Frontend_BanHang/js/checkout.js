var app = angular.module("AppBanHang", []);
app.controller("CheckOut", function ($scope, $http, AuthService) {
  $scope.donHangs;
  //thong tin khach hang
  $scope.TenKhachHang;
  $scope.DiaChi;
  $scope.GioiTinh;
  $scope.SoDienThoai;
  $scope.Email;
  $scope.total = 0;

  $scope.userInfo = AuthService.getUserInfo();

$scope.Load = function () {
  console.log("Tai khoan:", $scope.userInfo);
  var cartData = localStorage.getItem("cart");
  $scope.items = cartData ? JSON.parse(cartData) : [];
   $scope.donHangs = $scope.items.filter(function (item) {
    if(item.customerId === $scope.userInfo.maTaiKhoan) {
      return item;
    }
  })
  // $scope.userInfo = AuthService.getUserInfo();
  if ($scope.donHangs) {
    $scope.TongTien();
  } else {
    $scope.total = 0;
  } 
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
  //xoa sp trong gio co ma
  $scope.DeleteCart = function () {
    var cartData = localStorage.getItem("cart");
    if(cartData) {
      var listCart = JSON.parse(cartData);
      //console.log(listCart); 
      //$scope.userInfo = AuthService.getUserInfo();
      var maSP = $scope.userInfo.maTaiKhoan;
      console.log(maSP);
      var newListCart = listCart.filter(function (item) {
        return item.customerId !== maSP;
      });
      localStorage.setItem("cart", JSON.stringify(newListCart));
    }
  }

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
    obj.trangThaiDonHang = "0";
    obj.list_json_chitiet_donhang = [];
    donHang = JSON.parse(localStorage.getItem("cart"));
    for (var i = 0; i < donHang.length; i++) {
      obj.list_json_chitiet_donhang.push({
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
             $scope.DeleteCart();
           //$scope.donHangs = [];
          }
        })
        .catch(function (err) {
          console.log("Loi:", err);
        });
  };
  $scope.CheckLogin();
  $scope.Load();
 

  //xoa don hang trong gio hang


});

var app = angular.module("AppBanHang", []);
app.controller("CartCtrl", function ($scope, $http, AuthService) {
  //khai bao cuc bo
  $scope.userInfo = AuthService.getUserInfo();
  $scope.listCart;
  $scope.total = 0;

  // Load du lieu tu local
  $scope.Load = function () {
    var cartData = localStorage.getItem("cart");
    if (cartData) {
      try {
        $scope.listCart = JSON.parse(cartData);
      } catch (error) {
        console.error("Error parsing cart data:", error);
        $scope.listCart = [];
        localStorage.setItem("cart", JSON.stringify([]));
      }
    } else {
      $scope.listCart = [];
    }
    var userInfo = AuthService.getUserInfo();
    var localId = userInfo ? userInfo.maTaiKhoan : null;
    console.log(localId);
    for (var i = 0; i < $scope.listCart.length; i++) {
      $scope.listCart[i].localId = localId;
    }
    if (userInfo) {
      var localId = userInfo.maTaiKhoan;
      $scope.listCart = $scope.listCart.filter(
        (item) => item.customerId === localId
      );
    }
  };

  // Function to calculate total
  $scope.TongTien = function () {
    $scope.total = 0;
    for (var i = 0; i < $scope.listCart.length; i++) {
      var sanpham = $scope.listCart[i];
      $scope.total += parseInt(sanpham.gia * sanpham.quantity);
    }
    console.log($scope.total);
  };

  // Check user login
  $scope.CheckLogin = function () {
    $scope.isLogin = AuthService.checkLogin();
  };
  $scope.logOut = function () {
    AuthService.logOut();
    $scope.isLogin = false;
  };

  $scope.Xoa = function (id) {
    var index = $scope.listCart.findIndex((x) => x.maSanPham === id);
    if (index >= 0) {
      $scope.listCart.splice(index, 1);
    }
    localStorage.setItem("cart", JSON.stringify($scope.listCart));
  };

  // Hàm cập nhật số lượng onchange
  $scope.updateQuantity = function (id) {
    var index = $scope.listCart.findIndex((x) => x.maSanPham === id);
    if (index >= 0) {
      var newQuantity = parseInt(document.getElementById("q_" + id).value);
      $scope.listCart[index].quantity = newQuantity;
      $scope.TongTien();
    }
    localStorage.setItem("cart", JSON.stringify($scope.listCart));
  };
  $scope.CheckLogin();
  $scope.Load();
  $scope.TongTien();
});

function ChuyenHuong() {
  var searchValue = document.getElementById("inputTxt").value;
  window.location.href = "timkiem.html?search=" + searchValue;
}

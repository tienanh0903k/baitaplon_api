var app = angular.module("AppBanHang", []);
app.controller("CartCtrl", function ($scope, $http, AuthService) {
  //$scope variable
  $scope.userInfo = AuthService.getUserInfo();
  $scope.listCart = [];
  $scope.listCart = JSON.parse(localStorage.getItem("cart"));
  $scope.total = 0;

  //lay data tu service

  //function handle
  $scope.TongTien = function () {
    $scope.total = 0;
    for (var i = 0; i < $scope.listCart.length; i++) {
      var sanpham = $scope.listCart[i];
      $scope.total += parseInt(sanpham.gia * sanpham.quantity);
    }
    console.log($scope.total);
  };

  $scope.CheckLogin = function () {
    $scope.isLogin = AuthService.checkLogin();
  };
  $scope.CheckLogin();

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

  $scope.updateQuantity = function (id) {
    // Tìm sản phẩm trong giỏ hàng và cập nhật số lượng
    var index = $scope.listCart.findIndex((x) => x.maSanPham === id);
    if (index >= 0) {
      var newQuantity = parseInt(document.getElementById("q_" + id).value);
      $scope.listCart[index].quantity = newQuantity;
      $scope.TongTien();
    }
    localStorage.setItem("cart", JSON.stringify($scope.listCart));
  };

  $scope.TongTien();
});




function ChuyenHuong() {
  var searchValue = document.getElementById("inputTxt").value;
  window.location.href = "timkiem.html?search=" + searchValue;
}

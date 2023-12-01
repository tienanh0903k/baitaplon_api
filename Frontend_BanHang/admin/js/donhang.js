var app = angular.module("AppBanHang", []);
app.controller("AdminDonHang", function ($scope, $http, $location) {
  // Lay danh sach don hang cua admin
  $scope.donHangs;
  $scope.madonhang;
  $scope.tenKhachHang;
  $scope.ngayDat;
  $scope.diaChi;
  $scope.slTrangThai = "1";
  $scope.optionStatus = "2";
  $scope.onChangeOption = function () {
    $http({
      method: "GET",
      url:
        "https://localhost:44306/api/DonHangs/get-donhang/" +
        $scope.optionStatus,
    }).then(function (response) {
      $scope.donHangs = response.data;
    });
  };
  $scope.onChangeOption();

  $scope.SuaDonHang = function (donhang) {
    $scope.madonhang = donhang.maDonHang;
    $scope.tenKhachHang = donhang.tenKH;
    $scope.ngayDat = donhang.ngayDat;
    $scope.diaChi = donhang.diaChi;
    $scope.slTrangThai = donhang.trangThaiDonHang;
  };

  $scope.LapHoaDon = function () {
    console.log($scope.madonhang);
    if (!$scope.madonhang || !$scope.tenKhachHang || !$scope.ngayDat || $scope.slTrangThai == 0) {
        alert('Chua thanh toan');
    }
    else {
        localStorage.setItem("madonhang", $scope.madonhang);
         window.location.href = "hoadonban.html";
    }
  };
});
 
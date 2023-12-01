var app = angular.module("AppBanHang", []);

app.controller("HomeCtrl", function ($scope, $http, AuthService, $location) {
  $scope.userInfo = AuthService.getUserInfo();
  //console.log($scope.userInfo);
  $scope.isLogin = false;
  $scope.products = [];

  $scope.CheckLogin = function () {
    $scope.isLogin = AuthService.checkLogin();
  };
  $scope.CheckLogin();

  $scope.logOut = function () {
    AuthService.logOut();
    $scope.isLogin = false;
  };

  $scope.getIndex = function (value) {
    $http({
      method: "GET",
      url: `https://localhost:44323/api/GetSanPham/DanhMuc/${value}`,
    })
      .then(function (response) {
        console.log(response.data);
        $scope.products = response.data;
      })
      .catch(function (error) {
        console.error("Lỗi khi tải dữ liệu sản phẩm boi danh muc:", error);
      });
  };
  $scope.getIndex(6);

  $scope.pageSize = "5";
  //ham tim kiem
  // $scope.TimKiem = () => {
  //   var urlParams = new URLSearchParams(window.location.search);
  //   var value = urlParams.get("search");
  // };
  // $scope.TimKiem();

  $scope.searchValue = "";

  // Hàm ChuyenHuong để thực hiện chuyển hướng
  $scope.ChuyenHuong = function () {
    window.location.href = "timkiem.html?search=" + $scope.searchValue;
  };
});




//phan trang san pham
$scope.getSanPhamPage = function () {
  
}




















// $scope.CheckLogin = function () {
//   var currentUsers = JSON.parse(window.localStorage.getItem("currentUser"));
//   console.log(currentUsers);
//   if (currentUsers) {
//     debugger;
//     $scope.isLogin = true;
//   } else {
//     debugger;
//     $scope.isLogin = false;
//   }
// };
// $scope.CheckLogin();

// $scope.logOut = function () {
//   localStorage.removeItem("currentUser");
//   $scope.isLogin = false;
//});
// };
// function ChuyenHuong() {
//   var searchValue = document.getElementById("inputTxt").value;
//   window.location.href = "timkiem.html?search=" + searchValue;
// }

//   $scope.GetBanChay = function () {
//     $http({
//       method: "POST",
//       data: { page: 1, pageSize: 10 },
//       url: current_url + "/api/khach/search",
//     }).then(function (response) {
//       debugger;
//       $scope.listItem = response.data.data;
//     });
//   };
//   $scope.GetBanChay();

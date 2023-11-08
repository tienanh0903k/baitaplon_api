var app = angular.module("AppBanHang", []);
  app.controller("CheckCtrl", function ($scope, $http) {
  $scope.CheckLogin = function () {
    var currentUsers = JSON.parse(window.localStorage.getItem("currentUser"));
    console.log(currentUsers);
    if (currentUsers) {
      debugger;
      $scope.isLogin = true;
    } else {
      debugger;
      $scope.isLogin = false;
    }
  };
  $scope.CheckLogin();

  $scope.logOut = function () {
    localStorage.removeItem("currentUser");
    $scope.isLogin = false;
  };
})
function ChuyenHuong() {
  var searchValue = document.getElementById("inputTxt").value;
  window.location.href = "timkiem.html?search=" + searchValue;
}



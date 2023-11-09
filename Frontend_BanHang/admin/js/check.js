// var app = angular.module("AppBanHang", []);
// app.controller("AdminSanPham", function ($scope, $http) {
//   // Lấy thông tin người dùng từ localStorage
//   var currentUserJSON = localStorage.getItem("currentUser");
//   $scope.currentUser = JSON.parse(currentUserJSON);
// console.log($scope.currentUser);
//   // Kiểm tra quyền của người dùng
//   $scope.isAdmin = function () {
//     if ($scope.currentUser && $scope.currentUser.loaiTaiKhoan === 1) {
//       return true;
//     } else {
//       return false;
//     }
//   };

// //   if (!$scope.isAdmin()) {
// //     alert("khong co quyen truy cap");
// //     $location.path("/index.html");
// //   }
// });

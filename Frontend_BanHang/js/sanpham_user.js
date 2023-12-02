var app = angular.module("AppBanHang", []);
app.controller("UserSanPham", function ($scope, $http) {
  $scope.products = [];
  $scope.pageSize = 8;
  $scope.totalItems = 0;
  $scope.pages = [];
  $scope.currentPage = 1;


  //phan trang
  $scope.getIndex = function () {
    let obj = {};
    //trang hien tai
    obj.page = $scope.currentPage;
    //so san phan tron 1 page
    obj.pageSize = $scope.pageSize;
    obj.ten_sp = $scope.tenSP;
    obj.status = $scope.status;
    $http({
      method: "POST",
      data: JSON.stringify(obj),
      url: "https://localhost:44323/api/GetSanPham/search-sort",
    }).then(function (response) {
      //tong ban ghi
      $scope.totalItems = response.data.totalItems;
      $scope.products = response.data.data;

      // Tính toán số trang
      $scope.pages = [];
      for (
        var i = 1;
        i <= Math.round($scope.totalItems / $scope.pageSize);
        i++
      ) {
        $scope.pages.push(i);
        console.log($scope.pages);
      }

      $scope.setPage = function (page) {
        //gan page hien tai khi an
        $scope.currentPage = page;
        $scope.getIndex();
      };
    });
  };
  $scope.getIndex();










  //get san pham ban chay









  var currentUserJSON = localStorage.getItem("currentUser");
  $scope.currentUser = JSON.parse(currentUserJSON);
  console.log($scope.currentUser);
  // Kiểm tra quyền của người dùng
  $scope.isAdmin = function () {
    if ($scope.currentUser && $scope.currentUser.loaiTaiKhoan === 1) {
      return true;
    } else {
      return false;
    }
  };

  if (!$scope.isAdmin()) {
    alert("khong co quyen truy cap");
    window.location.href = "../index.html";
  }
});

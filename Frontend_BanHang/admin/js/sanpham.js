var app = angular.module("AppBanHang", []);
app.controller("AdminSanPham", function ($scope, $http) {
  $scope.products = [];
  $scope.pageSize = 5;
  $scope.totalItems = 0;
  $scope.pages = [];
  $scope.currentPage = 1;
  $scope.getIndex = function () {
    let obj = {};
    //trang hien tai
    obj.page = $scope.currentPage;
    //so san phan tron 1 page
    obj.pageSize = $scope.pageSize;
    obj.ten_sp = "";
    $http({
      method: "POST",
      data: JSON.stringify(obj),
      url: "https://localhost:44323/api/GetSanPham/search",
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
        $scope.currentPage = page;
        $scope.getIndex();
      };
    });
  };
  $scope.getIndex();



$scope.selectItems = [];

$scope.getCategory = function () {
  $http({
    method: "GET",
    url: "https://localhost:44306/api/DanhMuc/get-all",
  }).then(function (response) {
    $scope.selectItems = response.data; 
    console.log("Danh mục:", $scope.selectItems);
  });
};

$scope.getCategory();


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

  //   $scope.TimKiem = () => {
  //     var urlParams = new URLSearchParams(window.location.search);
  //     $scope.searchValue = urlParams.get("search"); // vd: search = ao polo
  //     let obj = {};
  //     obj.page = "1";
  //     obj.pageSize = $scope.pageSize;
  //     obj.ten_sp = $scope.searchValue;
  //     //console.log(JSON.stringify(obj));
  //     $http({
  //       method: "POST",
  //       data: JSON.stringify(obj),
  //       url: "https://localhost:44323/api/GetSanPham/search",
  //     }).then(function (response) {
  //       //console.log(response.data.data);
  //       $scope.products = response.data.data;
  //     });
  //     // console.log(obj);
  //     //alert(value);
  //   };
});

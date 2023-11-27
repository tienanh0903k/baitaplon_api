
  //-----------------------------------header ------------------------------------------
  function addHeader() {
    document.write(`
    <header>
        <div class="logo">
            <a href="index.html">NTASPORTS</a>
        </div>
        <nav>
            <ul>
                <li><a style="text-decoration: none;" href="./index.html">Trang chủ</a></li>
                <li><a href="./news.html">Sản phẩm</a></li>
                <li><a href="./news.html">Tin tức</a></li>
                <li><a href="#">Liên Hệ</a></li>
            </ul>
        </nav>
        <div class="search-cart">
           <form id="login-form" ng-submit="ChuyenHuong()">   
                <div class="search">
                    <!-- Sử dụng ng-model để liên kết giá trị của input với $scope.searchValue -->
                    <input id="inputTxt" type="text" placeholder="Tìm kiếm..." ng-model="searchValue">
                    <!-- Sử dụng type="button" thay vì type="submit" để tránh gửi form -->
                    <button type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </div>
            </form>

            <div class="user">
                    <a href="./login.html"><i class="fa-solid fa-user" ng-hide="isLogin"></i></a>
                    <a  ng-show="isLogin" class="avatar-img" href="./login.html">
                    <img class="hide" style="height: 35px; width: 35px; object-fit: cover; border-radius: 50%;" src="{{userInfo.anhDaiDien}}" ng-hide="!isLogin" ng-show="isLogin">
                    </a>
                    <div class="option">
                         <ul>
                             <li><a href="chitiettaikhoan.html">Thong tin</a></li>
                             <li><a href="#">Don hang</a></li>
                             <li><a href="login.html" ng-click="logOut()">Log Out</a></li>
                         </ul>
                     </div>   
               
            </div>
            <div class="cart">
                <a href="./card.html"><i class="fas fa-shopping-cart"></i></a>
            </div>
        </div>
    </header>
`);
}

  //----------------------danh muc --------------------------------
  


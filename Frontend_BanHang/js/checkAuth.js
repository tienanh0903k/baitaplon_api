app.service("AuthService", function () {
  var authService = {};

  authService.checkLogin = function () {
    var currentUsers = JSON.parse(window.localStorage.getItem("currentUser"));
    return currentUsers !== null;
  };

  authService.logOut = function () {
    localStorage.removeItem("currentUser");
  };

  authService.getUserInfo = function () {
    var currentUser = JSON.parse(window.localStorage.getItem("currentUser"));
    var userDetail = currentUser ? currentUser.detail[0] : null;

    var userInfo = Object.assign({}, currentUser, userDetail);

    return userInfo;
  };

  return authService;
});

var app = angular.module("admin", []);

app.controller(
  "AdminCtrl",
  function ($scope, $httpParamSerializer, $http, $window) {
    $scope.AdminProfile = true;

    var storedData = sessionStorage.getItem("myData");
    $scope.studs = JSON.parse(storedData);
    console.log("Data in sessionStorage:", $scope.studs);

    if ($scope.studs.studs.role === "admin") {
      $scope.admin = {
        username: "",
        email: "",
        role: "role",
        siri: "siri",
        password: "",
      };

      $scope.updateProfile = function () {
        $scope.AdminUpdateProfile = true;
        $scope.AdminProfile = false;
      };

      $scope.loadData = function () {
        let id = $httpParamSerializer({ siri: $scope.studs.studs.siri });

        $http.get("http://localhost:3000/LoadUpdateProfile?" + id).then(
          function (response) {
            console.log("Data  before:", $scope.studs);
            $scope.studs.studs = response.data;
            console.log("Data after updated:", $scope.studs);
          },

          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.SavedProfile = function () {
        let newdata = $httpParamSerializer({
          username: $scope.admin.username,
          email: $scope.admin.email,
          role: $scope.studs.studs.role,
          siri: $scope.studs.studs.siri,
          password: $scope.admin.password,
        });

        $http.get("http://localhost:3000/updateCoor?" + newdata).then(
          function (response) {
            $scope.AdminProfile = true;
            $scope.AdminUpdateProfile = false;
            $scope.loadData();
            // $scope.loadData();
          },
          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.loadUser = function () {
        $http.get("http://localhost:3000/readUser").then(
          function (response) {
            $scope.userListss = response.data;
            let length = $scope.userListss.length;

            for (let i = 0; i < length; i++) {
              $scope.userListss[i].num = i + 1;
              // console.log("WHAT", $scope.userListss[i].programme);
            }
            $scope.UserList = true;
            $scope.ListFilterUser = false;
            $scope.SearchUsers = false;
          },
          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.filterUserz = function () {
        if ($scope.selectedRoles != "ALL") {
          let filter = $httpParamSerializer({
            role: $scope.selectedRoles,
          });

          //   console.log("Yuhuu", filter);
          $http.get("http://localhost:3000/FilterUsers?" + filter).then(
            function (response) {
              $scope.userFilterList = response.data;
              //   console.log("yeay", $scope.userFilterList);
              let length = $scope.userFilterList.length;

              for (let i = 0; i < length; i++) {
                $scope.userFilterList[i].num = i + 1;
                //   console.log("yoo", $scope.userFilterList[i]);
              }
              $scope.UserList = false;
              $scope.SearchUsers = false;
              $scope.DeleteUsersz = false;
              $scope.ListFilterUser = true;
            },
            function (response) {
              // 2nd function to handle connection error
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.loadUser();
        }
      };

      $scope.searchIDs = function () {
        let search = $httpParamSerializer({ siri: $scope.searchID });

        $http.get("http://localhost:3000/SearchIDusew?" + search).then(
          function (response) {
            $scope.searchuse = response.data;

            let length = $scope.searchuse.length;

            for (let i = 0; i < length; i++) {
              $scope.searchuse[i].num = i + 1;
            }

            $scope.UserList = false;
            $scope.ListFilterUser = false;
            $scope.DeleteUsersz = false;
            $scope.SearchUsers = true;
          },
          function (response) {
            alert("Ajax connection error!");
          }
        );
      };

      $scope.deleteUsers = function (tab, step) {
        // console.log("try to delete " + stud.name);

        if (step == 0) {
          $scope.tableT = tab;
          $scope.UserList = false;
          $scope.ListFilterUser = false;
          $scope.SearchUsers = false;
          $scope.DeleteUsersz = true;
        } else if (step == 1 && tab.role === "admin") {
          alert("Admin cannot be deleted");
        } else {
          // let del = $httpParamSerializer(
          //   { id_user: tab.id_user },
          //   { role: tab.role },
          //   { siri: tab.siri }
          // );

          let del = $httpParamSerializer({
            id_user: tab.id_user,
            role: tab.role,
            siri: tab.siri,
          });

          $http.get("http://localhost:3000/DeletingUsers?" + del).then(
            function (response) {
              $scope.UserList = true;
              $scope.DeleteUsersz = false;
              $scope.loadUser();
            },

            function (response) {
              alert("Ajax connection error!");
            }
          );
        }
      };

      $scope.AddLectAndCoor = function () {
        $scope.role = $scope.admin.rolez;

        let datL = $httpParamSerializer({
          siri: $scope.admin.IDz,
          username: $scope.admin.Name,
          email: $scope.admin.emailz,
          role: $scope.admin.rolez,
          prog: $scope.admin.programmez,
        });

        let datU = $httpParamSerializer({
          username: $scope.admin.Name,
          email: $scope.admin.emailz,
          role: $scope.admin.rolez,
          siri: $scope.admin.IDz,
          password: $scope.admin.passwordz,
        });

        if ($scope.role == "lecturer") {
          $http.get("http://localhost:3000/createUser?" + datU).then(
            function (response) {},
            function (response) {
              alert("Ajax connection error!");
            }
          );

          $http.get("http://localhost:3000/createLect?" + datL).then(
            function (response) {},
            function (response) {
              alert("Ajax connection error!");
            }
          );
          alert("Lecturer successfully added");

          // console.log("See : " + dat);
        } else if ($scope.role == "coordinator") {
          $http.get("http://localhost:3000/createUser?" + datU).then(
            function (response) {},
            function (response) {
              alert("Ajax connection error!");
            }
          );
          alert("Coordinator successfully added");
        } else if (
          $scope.admin.Name == "" ||
          $scope.admin.IDz == "" ||
          $scope.admin.emailz == "" ||
          $scope.admin.passwordz == "" ||
          $scope.admin.programmez == "" ||
          $scope.admin.rolez == ""
        ) {
          alert("data Incomplete");
        }
      };

      $scope.CheckUsersz = function () {
        let Dats = $httpParamSerializer({
          username: $scope.admin.Name,
          email: $scope.admin.emailz,
          siri: $scope.admin.IDz,
        });

        $http.get("http://localhost:3000/checkUser?" + Dats).then(
          function (response) {
            $scope.mew = response.data;
            console.log("How many? " + $scope.mew);
            if ($scope.mew >= 1) {
              alert("Username or Email or ID already exists");
            } else {
              $scope.AddLectAndCoor();
            }
          },

          function (response) {
            // 2nd function to handle connection error
            alert("Invalid User");
          }
        );
      };

      // Function to check if the password is strong
      $scope.isStrongPassword = function (password) {
        // Example: Password should be at least 8 characters long, with at least one uppercase letter, one lowercase letter, one digit, and one special character
        var passwordRegex = /^(?=.*\d)[A-Za-z\d]{8,}$/;
        return passwordRegex.test(password);
      };

      // Function to check if the email is valid
      $scope.isValidEmail = function (email) {
        // Example: Using a simple regex for email validation
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
      };

      // Function to check if the username contains only characters
      $scope.isValidUsername = function (username) {
        // Allow only alphabetical characters
        var usernameRegex = /^[A-Za-z]+$/;
        return usernameRegex.test(username);
      };

      // Function to check user input and perform sign up if validations pass
      $scope.CheckCheck = function () {
        if (!$scope.isValidUsername($scope.admin.Name)) {
          alert("Please enter a username with only characters.");
          return;
        } else if (!$scope.isValidEmail($scope.admin.emailz)) {
          alert("Please enter a valid email address.");
          return;
        } else if (!$scope.isStrongPassword($scope.admin.passwordz)) {
          alert("Please enter a strong password.");
          return;
        } else {
          $scope.CheckUsersz();
        }
      };

      $scope.logout = function () {
        sessionStorage.removeItem("myData");
        $scope.studs = null;

        $window.location.href = "/LoginDux.html";
      };

      $scope.loadData();
    } else {
      alert("Invalid Session!!!");
      $window.location.href = "/LoginDux.html";
    }
  }
);

// sessionStorage.removeItem('myData');

// $scope.studs = null;
// console.log("Data in sessionStorage:", $scope.studs);

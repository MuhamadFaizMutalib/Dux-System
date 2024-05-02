var app = angular.module("user", []);

app.controller(
  "userCtrl",
  function ($scope, $http, $httpParamSerializer, $window) {
    $scope.oprSignUp = false;
    $scope.oprSignIn = true;

    $scope.emailauth = "???";
    $scope.passwordauth = "???";

    $scope.user = {
      username: "",
      email: "",
      role: "",
      siri: "",
      password: "",
    };

    $scope.createUser = function () {
      var serializedData = $httpParamSerializer($scope.user);
      // console.log(serializedData);

      $http.get("http://localhost:3000/createUser?" + serializedData).then(
        function (response) {
          if ($scope.user.role === "student") {
            $scope.createStudent();
          }
          // else{
          //   $scope.createLect();
          // }
        },

        function (response) {
          alert("Ajax connection error!");
        }
      );
    };

    $scope.createStudent = function () {
      var serializedData = $httpParamSerializer($scope.user);
      // console.log(serializedData);

      $http.get("http://localhost:3000/createStudent?" + serializedData).then(
        function (response) {
          $scope.oprSignUp = false;
          $scope.oprSignIn = true;
        },

        function (response) {
          alert("Ajax connection error!");
        }
      );
    };

    // $scope.createLect = function () {
    //   var serializedData = $httpParamSerializer($scope.user);
    //   console.log(serializedData);

    //   $http.get("http://localhost:3000/createLect?" + serializedData).then(
    //     function (response) {
    //       $scope.oprSignUp = false;
    //       $scope.oprSignIn = true;
    //     },

    //     function (response) {
    //       alert("Ajax connection error!");
    //     }
    //   );
    // };

    $scope.SignIn = function () {
      let authData = $httpParamSerializer({
        username: $scope.user.username,
        password: $scope.user.passwordauth,
      });

      $http.get("http://localhost:3000/read?" + authData).then(
        function (response) {
          $scope.studs = response.data;

          var dataToPass = { studs: $scope.studs };

          // Store data in sessionStorage
          sessionStorage.setItem("myData", JSON.stringify(dataToPass));

          // console.log('Username:', $scope.user.username);
          // console.log("Response Data:", $scope.studs.role);

          if (
            $scope.studs.role === "admin" ||
            $scope.studs.role === "coordinator" ||
            $scope.studs.role === "lecturer" ||
            $scope.studs.role === "student"
          ) {
            if ($scope.studs.role === "admin") {
              $window.location.href = "/Admin.html";
            } else if ($scope.studs.role === "coordinator") {
              $window.location.href = "/Coordinator.html";
            } else if (
              $scope.studs.role === "lecturer" ||
              $scope.studs.role === "student"
            ) {
              $window.location.href = "/DuxInterface.html";
            }
          } else {
            alert("Invalid User");
          }
        },

        function (response) {
          // 2nd function to handle connection error
          alert("Your Username or Password is wrong!!!");
        }
      );
    };

    $scope.CheckUsersz = function () {
      let Dats = $httpParamSerializer({
        username: $scope.user.username,
        email: $scope.user.email,
        siri: $scope.user.siri,
      });

      $http.get("http://localhost:3000/checkUser?" + Dats).then(
        function (response) {
          $scope.mew = response.data;
          // console.log("How many? " + $scope.mew);
          if ($scope.mew >= 1) {
            alert("Username or Email or ID already exists");
          } else {
            $scope.createUser();
            // $scope.sendEmail();
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

    $scope.sendEmail = function () {
      let Dats = $httpParamSerializer({
        To_Email: $scope.user.email,
        Subject: "Dux Registration",
        Message: "Welcome to Dux! Thank you for registering into our system!",
      });

      $http
        .get("http://localhost:3000/SendEmailz?" + Dats)
        .then(function (response) {
          console.log(response.data);
        })
        .catch(function (error) {
          console.error(error);
        });
    };

    // Function to check user input and perform sign up if validations pass
    $scope.CheckCheck = function () {
      if (!$scope.isValidUsername($scope.user.username)) {
        alert("Please enter a username with only characters.");
        return;
      } else if (!$scope.isValidEmail($scope.user.email)) {
        alert("Please enter a valid email address.");
        return;
      } else if (!$scope.isStrongPassword($scope.user.password)) {
        alert("Please enter a strong password.");
        return;
      } else {
        $scope.CheckUsersz();
      }
    };
  }
);

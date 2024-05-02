var app = angular.module("DuxInterface", []);

app.controller(
  "duxCtrl",
  function ($scope, $httpParamSerializer, $http, $window) {
    $scope.coorProfile = true;

    var storedData = sessionStorage.getItem("myData");
    $scope.studs = JSON.parse(storedData);
    console.log("Data in sessionStorage:", $scope.studs);

    if (
      $scope.studs.studs.role === "student" ||
      $scope.studs.studs.role === "lecturer"
    ) {
      $scope.Usersz = {
        username: "",
        email: "",
        role: "role",
        siri: "siri",
        password: "",
      };

      $scope.DuxInterface = {
        Session: "",
        Semester: "",
        Category: "",
        student_name: "",
        student_MatricNo: "",
        title: "",
        marks: "",
        Supervisor: "",
        psm_link: "",
      };

      $scope.updateProfile = function () {
        $scope.coorUpdateProfile = true;
        $scope.coorProfile = false;
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
          username: $scope.Usersz.username,
          email: $scope.Usersz.email,
          role: $scope.studs.studs.role,
          siri: $scope.studs.studs.siri,
          password: $scope.Usersz.password,
        });

        $http.get("http://localhost:3000/updateCoor?" + newdata).then(
          function (response) {
            $scope.coorProfile = true;
            $scope.coorUpdateProfile = false;
            $scope.loadData();
            // $scope.loadData();
          },
          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.loadTimeTable = function () {
        $http.get("http://localhost:3000/readTimeTable").then(
          function (response) {
            $scope.timetables = response.data;
            // console.log("WHAT", $scope.timetables);
            let length = $scope.timetables.length;

            for (let i = 0; i < length; i++) {
              $scope.timetables[i].num = i + 1;
            }

            $scope.ListTimeTable = true;
          },

          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.logout = function () {
        sessionStorage.removeItem("myData");
        $scope.studs = null;

        $window.location.href = "/LoginDux.html";
      };

      $scope.filterTimetable = function () {
        if ($scope.selectedLectProgramme != "ALL") {
          let filter = $httpParamSerializer({
            Category: $scope.selectedLectProgramme,
          });

          $http.get("http://localhost:3000/FilterTimeTable?" + filter).then(
            function (response) {
              $scope.TimetableFilterlist = response.data;
              // console.log("yeay", $scope.TimetableFilterlist);
              let length = $scope.TimetableFilterlist.length;
              // console.log("yeay", length);

              for (let i = 0; i < length; i++) {
                $scope.TimetableFilterlist[i].num = i + 1;
                // console.log("yoo", $scope.TimetableFilterlist[i]);
              }
            },
            function (response) {
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.loadTimeTable();
        }
      };

      $scope.searchSession = function () {
        let search = $httpParamSerializer({ Session: $scope.searchTTableS });

        $http.get("http://localhost:3000/SearchTimeTable?" + search).then(
          function (response) {
            $scope.searchTablesSession = response.data;
            let length = $scope.searchTablesSession.length;

            for (let i = 0; i < length; i++) {
              $scope.searchTablesSession[i].num = i + 1;
              // console.log("yoo", $scope.searchTablesSession[i]);
            }

            $scope.ListTimeTable = false;
            $scope.ListFilterTable = false;
            $scope.SearchTables = true;
          },
          function (response) {
            alert("Ajax connection error!");
          }
        );
      };

      $scope.loadEvent = function () {
        $http.get("http://localhost:3000/readEventList").then(
          function (response) {
            $scope.eventss = response.data;

            let length = $scope.eventss.length;

            for (let i = 0; i < length; i++) {
              $scope.eventss[i].num = i + 1;
            }

            $scope.listEvent = true;
            $scope.ListFilterEvent = false;
            $scope.SearchEventse = false;
          },

          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.filterEvent = function () {
        if ($scope.selectedEvent != "ALL") {
          let filter = $httpParamSerializer({
            Category: $scope.selectedEvent,
          });

          $http.get("http://localhost:3000/FilterEvents?" + filter).then(
            function (response) {
              $scope.EventFilter = response.data;
              // console.log("yeay", $scope.EventFilter);
              let length = $scope.EventFilter.length;
              // console.log("yeay", length);
              $scope.ListFilterEvent = true;
              $scope.listEvent = false;
              $scope.SearchEventse = false;

              for (let i = 0; i < length; i++) {
                $scope.EventFilter[i].num = i + 1;
                // console.log("yoo", $scope.EventFilter[i]);
              }
            },
            function (response) {
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.loadEvent();
        }
      };

      $scope.searchSessionEvent = function () {
        let search = $httpParamSerializer({ Session: $scope.searchSESSION });

        $http.get("http://localhost:3000/SearchEvent?" + search).then(
          function (response) {
            $scope.searchEve = response.data;
            let length = $scope.searchEve.length;

            for (let i = 0; i < length; i++) {
              $scope.searchEve[i].num = i + 1;
              // console.log("yoo", $scope.searchEve[i]);
            }

            $scope.listEvent = false;
            $scope.ListFilterEvent = false;
            $scope.SearchEventse = true;
          },
          function (response) {
            alert("Ajax connection error!");
          }
        );
      };

      $scope.DuxInterface = {
        Session: "",
        Semester: "",
        Category: "",
        student_name: "",
        student_MatricNo: "",
        title: "",
        marks: "",
        Supervisor: "",
        psm_link: "",
      };
      $scope.CreatePSMz = function () {
        let datPSM = $httpParamSerializer({
          Session: $scope.session,
          Semester: $scope.semester,
          Category: $scope.category,
          student_name: $scope.studname,
          student_MatricNo: $scope.studeMatric,
          title: $scope.title,
          marks: $scope.mark,
          Supervisor: $scope.studs.studs.username,
          psm_link: $scope.psmlink,
        });

        $http.get("http://localhost:3000/createPSM?" + datPSM).then(
          function (response) {
            $scope.loadPSM();
            $scope.ListPSM = true;
            $scope.AddPSM = false;
          },

          function (response) {
            // 2nd function to handle connection error
            alert("error");
          }
        );
      };

      $scope.loadPSM = function () {
        if ($scope.studs.studs.role === "lecturer") {
          $scope.ListPSM = true;
          let datloadPSM = $httpParamSerializer({
            Supervisor: $scope.studs.studs.username,
            Role: $scope.studs.studs.role,
          });
          // console.log("What datloadPSM: " + datloadPSM);

          $http.get("http://localhost:3000/readPSM?" + datloadPSM).then(
            function (response) {
              $scope.dataPSM = response.data;
              let length = $scope.dataPSM.length;

              for (let i = 0; i < length; i++) {
                $scope.dataPSM[i].num = i + 1;
                // console.log("What data: " + $scope.dataPSM[i]);
              }
            },

            function (response) {
              // 2nd function to handle connection error
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.ListPSMStud = true;
          let datloadPSM = $httpParamSerializer({
            student_name: $scope.studs.studs.username,
            Role: $scope.studs.studs.role,
          });
          // console.log("What datloadPSM: " + datloadPSM);

          $http.get("http://localhost:3000/readPSM?" + datloadPSM).then(
            function (response) {
              $scope.dataPSMStudent = response.data;
              let length = $scope.dataPSMStudent.length;
              // console.log("What data: " + $scope.dataPSM);

              for (let i = 0; i < 1; i++) {
                $scope.dataPSMStudent[i].num = i + 1;
              }
            },

            function (response) {
              // 2nd function to handle connection error
              alert("Ajax connection error!");
            }
          );
        }
      };

      $scope.psmL = {
        Session: "???",
        Semester: "???",
        Category: "???",
        student_name: "???",
        student_MatricNo: "???",
        title: "???",
        marks: "???",
        Supervisor: $scope.studs.studs.username,
        psm_link: "???",
      };

      $scope.UpdatePSM = function (tab, step) {
        // console.log("try to update " + tab.name);

        if (step == 0) {
          $scope.psmL = tab;
          $scope.ListPSM = false;
          $scope.UpdatePSMzs = true;
        } else {
          var serializedData = $httpParamSerializer($scope.psmL);
          // console.log(serializedData);

          $http
            .get("http://localhost:3000/readupdatePSM?" + serializedData)
            .then(
              function (response) {
                $scope.ListPSM = true;
                $scope.UpdatePSMzs = false;
                $scope.loadPSM();
              },

              function (response) {
                // 2nd function to handle connection error
                alert("Ajax connection error!");
              }
            );
        }
      };

      $scope.DeletePSMz = function (tab, step) {
        // console.log("try to delete " + stud.name);

        if (step == 0) {
          $scope.psmL = tab;
          $scope.ListPSM = false;
          $scope.DeletePSM = true;
        } else {
          $http
            .get("http://localhost:3000/deletePSMzs?id_psm=" + tab.id_psm)
            .then(
              function (response) {
                $scope.ListPSM = true;
                $scope.DeletePSM = false;
                $scope.loadPSM();
              },

              function (response) {
                alert("Ajax connection error!");
              }
            );
        }
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

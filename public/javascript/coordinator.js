var app = angular.module("coordinator", []);

app.controller(
  "coorCtrl",
  function ($scope, $httpParamSerializer, $http, $window) {
    $scope.coorProfile = true;

    var storedData = sessionStorage.getItem("myData");
    $scope.studs = JSON.parse(storedData);
    console.log("Data in sessionStorage:", $scope.studs);

    if ($scope.studs.studs.role === "coordinator") {
      // console.log("Data in sessionStorage:", $scope.studs.studs.siri);

      // sessionStorage.removeItem('myData');
      // $scope.studs = null;
      // console.log("Data in sessionStorage:", $scope.studs);

      $scope.coordinator = {
        username: "",
        email: "",
        role: "role",
        siri: "siri",
        password: "",
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
          username: $scope.coordinator.username,
          email: $scope.coordinator.email,
          role: $scope.studs.studs.role,
          siri: $scope.studs.studs.siri,
          password: $scope.coordinator.password,
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

      $scope.ListStudent = true;

      $scope.loadStudent = function () {
        $http.get("http://localhost:3000/readStudent").then(
          function (response) {
            $scope.studList = response.data;
            let length = $scope.studList.length;

            for (let i = 0; i < length; i++) {
              $scope.studList[i].num = i + 1;
              // console.log("WHAT", $scope.studList[i].programme);
            }
            $scope.ListStudent = true;
            $scope.ListFilterStudent = false;
            $scope.SearchStudent = false;
          },
          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.filterStudents = function () {
        if ($scope.selectedProgramme != "ALL") {
          let filter = $httpParamSerializer({
            programme: $scope.selectedProgramme,
          });

          //   console.log("Yuhuu", filter);
          $http.get("http://localhost:3000/FilterStudent?" + filter).then(
            function (response) {
              $scope.studFilterList = response.data;
              //   console.log("yeay", $scope.studFilterList);
              let length = $scope.studFilterList.length;

              for (let i = 0; i < length; i++) {
                $scope.studFilterList[i].num = i + 1;
                //   console.log("yoo", $scope.studFilterList[i]);
              }
              $scope.ListStudent = false;
              $scope.SearchStudent = false;
              $scope.ListFilterStudent = true;
            },
            function (response) {
              // 2nd function to handle connection error
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.loadStudent();
        }
      };

      $scope.searchMatric = function () {
        let search = $httpParamSerializer({ matric: $scope.searchmatric });

        $http.get("http://localhost:3000/Search?" + search).then(
          function (response) {
            $scope.searchstuds = response.data;

            // let length = $scope.searchstuds.length;

            // for (let i = 0; i < length; i++) {
            //     $scope.searchstuds[i].num = i + 1;
            // }
            $scope.ListStudent = false;
            $scope.ListFilterStudent = false;
            $scope.SearchStudent = true;
          },
          function (response) {
            alert("Ajax connection error!");
          }
        );
      };

      $scope.loadLecturer = function () {
        $http.get("http://localhost:3000/readLecturer").then(
          function (response) {
            $scope.lectList = response.data;
            let length = $scope.lectList.length;

            for (let i = 0; i < length; i++) {
              $scope.lectList[i].num = i + 1;
              // console.log("WHAT", $scope.lectList[i].programme);
            }
            $scope.Listlecturer = true;
            // $scope.ListLecturer = true;
            // $scope.ListFilterLecturer = false;
            // $scope.SearchLecturer = false;
          },
          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.filterLecturer = function () {
        if ($scope.selectedLectProgramme != "ALL") {
          let filter = $httpParamSerializer({
            programme: $scope.selectedLectProgramme,
          });

          //   console.log("Yuhuu", filter);
          $http.get("http://localhost:3000/FilterLecturers?" + filter).then(
            function (response) {
              $scope.lectFilterList = response.data;
              // console.log("yeay", $scope.lectFilterList);
              let length = $scope.lectFilterList.length;
              // console.log("yeay", length);

              for (let i = 0; i < length; i++) {
                $scope.lectFilterList[i].num = i + 1;
                // console.log("yoo", $scope.lectFilterList[i]);
              }
              //   $scope.ListFilterLecturer = true;
              //   $scope.ListLecturer = false;
              //   $scope.SearchLecturer = false;
            },
            function (response) {
              // 2nd function to handle connection error
              alert("Ajax connection error!");
            }
          );
        } else {
          $scope.loadLecturer();
        }
      };

      $scope.searchID = function () {
        let search = $httpParamSerializer({ LectID: $scope.searchlectID });

        $http.get("http://localhost:3000/SearchLect?" + search).then(
          function (response) {
            $scope.searchlects = response.data;
            // console.log("aaaa", $scope.searchlects);

            // $scope.ListLecturer = false;
            // $scope.ListFilterLecturer = false;
            // $scope.SearchLecturer = true;
          },
          function (response) {
            alert("Ajax connection error!");
          }
        );
      };

      $scope.CreateTimeTable = function () {
        let tabledata = $httpParamSerializer({
          Session: $scope.SessionT,
          Semester: $scope.SemesterT,
          Category: $scope.CategoryT,
          Programme: $scope.ProgrammeT,
          TimeTable_Link: $scope.TimetableLink,
        });

        $http.get("http://localhost:3000/createTimeTable?" + tabledata).then(
          function (response) {
            $scope.AddTimetable = false;
            $scope.listTimeTable = true;
            $scope.loadTimeTable();
          },

          function (response) {
            // 2nd function to handle connection error
            alert("error");
          }
        );
      };

      $scope.loadTimeTable = function () {
        $http.get("http://localhost:3000/readTimeTable").then(
          function (response) {
            $scope.timetables = response.data;
            let length = $scope.timetables.length;

            for (let i = 0; i < length; i++) {
              $scope.timetables[i].num = i + 1;
            }
          },

          function (response) {
            // 2nd function to handle connection error
            alert("Ajax connection error!");
          }
        );
      };

      $scope.tableT = {
        Session: "???",
        Semester: "???",
        Category: "???",
        Programme: "???",
        TimeTable_Link: "???",
      };

      $scope.UpdateTtable = function (tab, step) {
        // console.log("try to update " + tab.name);

        if (step == 0) {
          $scope.tableT = tab;
          $scope.listTimeTable = false;
          $scope.UpdateTimeTable = true;
        } else {
          var serializedData = $httpParamSerializer($scope.tableT);
          // console.log(serializedData);

          $http
            .get("http://localhost:3000/readupdateTimeTable?" + serializedData)
            .then(
              function (response) {
                $scope.listTimeTable = true;
                $scope.UpdateTimeTable = false;
                $scope.loadTimeTable();
              },

              function (response) {
                // 2nd function to handle connection error
                alert("Ajax connection error!");
              }
            );
        }
      };

      $scope.deleteTimeTable = function (tab, step) {
        // console.log("try to delete " + stud.name);

        if (step == 0) {
          $scope.tableT = tab;
          $scope.listTimeTable = false;
          $scope.DeleteTimeTable = true;
        } else {
          $http
            .get(
              "http://localhost:3000/deleteTTable?id_TimeTable=" +
                tab.id_TimeTable
            )
            .then(
              function (response) {
                $scope.listTimeTable = true;
                $scope.DeleteTimeTable = false;
                $scope.loadTimeTable();
              },

              function (response) {
                alert("Ajax connection error!");
              }
            );
        }
      };

      $scope.CreateEvent = function () {
        let EventData = $httpParamSerializer({
          Session: $scope.SessionE,
          Semester: $scope.SemesterE,
          Date: $scope.DateE,
          Category: $scope.CategoryE,
          ProgramName: $scope.ProgName,
          Programme_Link: $scope.ProgLink,
        });

        $http.get("http://localhost:3000/CreateEvents?" + EventData).then(
          function (response) {
            // $scope.AddTimetable=false;
            // $scope.listTimeTable=true;
            $scope.loadEventlist();
          },

          function (response) {
            alert("error");
          }
        );
      };

      $scope.loadEventlist = function () {
        $http.get("http://localhost:3000/readEventList").then(
          function (response) {
            $scope.Eventss = response.data;
            let length = $scope.Eventss.length;

            for (let i = 0; i < length; i++) {
              $scope.Eventss[i].num = i + 1;
            }
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

      $scope.eventC = {
        Session: "???",
        Semester: "???",
        Date: "???",
        Category: "???",
        ProgramName: "???",
        Programme_Link: "???",
      };

      $scope.UpdateEvents = function (eve, step) {
        // console.log("try to update " + eve.name);

        if (step == 0) {
          $scope.eventC = eve;
          $scope.ListOfEvents = false;
          $scope.UpdateEventC = true;
        } else {
          var serializedData = $httpParamSerializer($scope.eventC);
          // console.log(serializedData);

          $http
            .get("http://localhost:3000/readupdateEvent?" + serializedData)
            .then(
              function (response) {
                $scope.ListOfEvents = true;
                $scope.UpdateEventC = false;
                $scope.loadEventlist();
              },

              function (response) {
                // 2nd function to handle connection error
                alert("Ajax connection error!");
              }
            );
        }
      };

      $scope.deleteEvents = function (eve, step) {
        // console.log("try to delete " + stud.name);

        if (step == 0) {
          $scope.eventC = eve;
          $scope.ListOfEvents = false;
          $scope.DeleteEvent = true;
        } else {
          $http
            .get("http://localhost:3000/DeleteEvents?id_event=" + eve.id_event)
            .then(
              function (response) {
                $scope.ListOfEvents = true;
                $scope.DeleteEvent = false;
                $scope.loadEventlist();
              },

              function (response) {
                alert("Ajax connection error!");
              }
            );
        }
      };

      //$scope.loadStudent();
      $scope.loadEventlist();
      $scope.loadTimeTable();
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

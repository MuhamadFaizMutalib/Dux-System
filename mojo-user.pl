use strict;
use warnings;


use Mojolicious::Lite -signatures;
use Mojolicious::Lite;
use Email::Send::SMTP::Gmail;
use JSON;

use DBI;

my $database = "DuxSys";
my $hostname = "localhost";
my $username = "DuxSys";
my $password = "DuxSys";

my $dsn = "DBI:mysql:database=$database;host=$hostname";

my $dbh = DBI->connect( $dsn, $username, $password );

use lib './';
use ModelStudent;
use ModelUser;
use ModelLect;
use ModelDuxInterface;


get '/' => sub ($c) {

if ($c->session->{username} eq "") {
        $c->redirect_to('/LoginDux.html');
    }
    else {
        #$c->render( text => "Current user : " . $c->session->{username} );
        # $c->redirect_to('/Coordinator.html');
    }

};


get '/SendEmailz' => sub ($c) {
   
    my $to_email  = $c->param('To_Email') // '';
    my $subject   = $c->param('Subject')   // '';
    my $message   = $c->param('Message')   // '';

    my $gmail_user = 'gengcangkui@gmail.com';

    my ($mail, $error) = Email::Send::SMTP::Gmail->new(
        -layer => 'ssl',
        -port  => '465',
        -smtp  => 'smtp.gmail.com',
        -login => $gmail_user,
        -pass  => '???'
    );

 
    unless ($mail) {
        $c->render(json => { error => "Error creating email session: $error" }, status => 500);
        return;
    }


    $mail->send(
        -to          => $to_email,
        -contenttype => 'text/html',
        -subject     => $subject,
        -body        => $message
    );


    if ($mail->{error}) {
        $c->render(json => { error => "Error sending email: $mail->{error}" }, status => 500);
    } else {
        $c->render(json => { success => "Email sent successfully!" });
    }


    $mail->bye;
};




get '/auth' => sub ($c) {
    my $username = $c->param('username');
    my $password = $c->param('password');

    my $u = new ModelUser;
    

    my $auth = $u->auth( $dbh, $username, $password );

    if ($auth) {
        ### need to update session info first before render 
        ### operation or it will not really updated
        $c->session->{username} = $auth->{'username'};
        $c->session->{role} = $auth->{'role'};

        #$c->render( text => JSON->new->pretty->encode($auth) );
        $c->redirect_to('/Admin.html');
    }
    else {
        #$c->render( text => "Invalid auth" );
        $c->redirect_to('/DUX.html');
    }

    # print "username = " . $c->session->{username} . "\n";

};


get '/createUser' => sub ($c) {
    my $username    = $c->param('username');
    my $email  = $c->param('email');
    my $role     = $c->param('role');
    my $siri     = $c->param('siri');
    my $password      = $c->param('password');

    my $s = new ModelUser();
    $s->setUser($username, $email, $role , $siri, $password);
    $s->createUser($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $username - $email - $role - $siri - $password");
};

get '/createStudent' => sub ($c) {

    my $MatricNum     = $c->param('siri');
    my $username    = $c->param('username');
    my $email  = $c->param('email');
    my $role     = $c->param('role');
     my $prog     = $c->param('prog');
    
    my $s = new ModelStudent();
    $s->setStudent($MatricNum, $username, $email, $role,$prog );
    $s->createStudent($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $MatricNum - $username - $email - $role - $prog");
};



get '/createLect' => sub ($c) {

    my $LectID    = $c->param('siri');
    my $username    = $c->param('username');
    my $email  = $c->param('email');
    my $role     = $c->param('role');
    my $prog     = $c->param('prog');
    
    my $s = new ModelLect();
    $s->setLect($LectID , $username, $email, $role, $prog);
    $s->createLect($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $LectID  - $username - $email - $role - $prog");
};



get '/read' => sub ($c) {
    #   my $id_student = $c->param("id_student");
      my $username = $c->param("username");
      my $password = $c->param("password");

    my $s = new ModelUser;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    
    $c->render( text => $s->read( $dbh, $username, $password ) );
    
};


get '/updateCoor' => sub ($c) {
    my $username = $c->param("username");
    my $email       = $c->param('email');
    my $role       = $c->param('role');
    my $siri     = $c->param('siri');
    my $password     = $c->param('password');
    my $s = new ModelUser;
    $s->setUser( $username, $email ,$role, $siri,$password);
    $s->updateUser( $dbh, $siri);

    if($role eq "lecturer"){
        my $l = new ModelLect;
         $l->setLect($siri,$username, $email ,$role);
         $l->updateLect( $dbh, $siri);

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... siri=$siri" );  
    }
    elsif($role eq "student"){
         my $k = new ModelStudent;
         $k->setStudent($siri,$username, $email ,$role);
         $k->updateStudent( $dbh, $siri);

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... siri=$siri" );  

    }
    else{
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... siri=$siri" );
    }
};


get '/LoadUpdateProfile' => sub ($c) {
    my $siri = $c->param("siri");

    my $s = new ModelUser;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->readProfile( $dbh, $siri ) );
    
};

get '/readUser' => sub ($c) {
    my $id_user = $c->param("id_user");

    my $s = new ModelUser;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    if ( $id_user eq "" ) {
        $c->render( text => $s->readUsers($dbh) );
    }
    else {
        $c->render( text => $s->reaUsers( $dbh, $id_user) );
    }
    
};


get '/readStudent' => sub ($c) {
    my $id_student = $c->param("id_student");

    my $s = new ModelStudent;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    if ( $id_student eq "" ) {
        $c->render( text => $s->readStudent($dbh) );
    }
    else {
        $c->render( text => $s->readStudent( $dbh, $id_student ) );
    }
    
};

get '/FilterStudent' => sub ($c) {
    # my $id_student = $c->param("id_student");
    my $programme = $c->param("programme");

     print "programme = ".$programme. "\n";

    my $s = new ModelStudent;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->FilterStudent( $dbh, $programme) );

    # if ( $id_student eq "" ) {
    #     $c->render( text => $s->FilterStudent($dbh) );
    # }
    # else {
    #     $c->render( text => $s->FilterStudent( $dbh, $id_student, $programme ) );
    # }
    
};


get '/Search' => sub ($c) {
    my $matric = $c->param("matric");
    #  print "programme = ".$programme. "\n";

    my $s = new ModelStudent;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->SearchStudent( $dbh, $matric) );    
};


# get '/FilterStudent' => sub ($c) {
#     my $programme  = $c->param("programme");
 
#     my $s = new ModelStudent;

#     $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
#      $c->render( text => $s->FilterStudent($dbh, $programme) ); 
# };



get '/readLecturer' => sub ($c) {
    my $id_lecturer = $c->param("id_lecturer");

    my $s = new ModelLect;
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    if ( $id_lecturer eq "" ) {
        $c->render( text => $s->readLecturer($dbh) );
    }
    else {
        $c->render( text => $s->readLecturer( $dbh, $id_lecturer ) );
    }
    
};

get '/FilterLecturers' => sub ($c) {

    my $programme = $c->param("programme");
    my $s = new ModelLect;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->FilterLecturer( $dbh, $programme) );  
};


get '/SearchLect' => sub ($c) {
    my $LectID  = $c->param("LectID");
    my $s = new ModelLect;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->SearchLecturer( $dbh, $LectID ) );    
};


get '/createTimeTable' => sub ($c) {
    my $Session  = $c->param("Session");
    my $Semester = $c->param('Semester');
    my $Category = $c->param('Category');
    my $Programme = $c->param('Programme');
    my $TimeTable_Link = $c->param('TimeTable_Link');
    my $s = new ModelDuxInterface;

    $s->setTimetable($Session, $Semester,$Category, $Programme,$TimeTable_Link);
    $s->createTimetables($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $Session - $Semester - $Category - $Programme - $TimeTable_Link");
};




get '/readTimeTable' => sub ($c) {
    my $id_TimeTable = $c->param("id_TimeTable");

    my $s = new ModelDuxInterface;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    if ( $id_TimeTable eq "" ) {
        $c->render( text => $s->readTimeTables($dbh) );
    }
    else {
        $c->render( text => $s->readTimeTables( $dbh, $id_TimeTable ) );
    }
    
};


# get '/readupdateTimeTable' => sub ($c) {
#     my $TimeTable_Link = $c->param("TimeTable_Link");

#     my $s = new ModelDuxInterface;

#     $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

#     $c->render( text => $s->readUpdateTimeTables( $dbh, $TimeTable_Link) );
    
    
# };




get '/readupdateTimeTable' => sub ($c) {
    my $id_TimeTable = $c->param("id_TimeTable");
    my $Session       = $c->param('Session');
    my $Semester     = $c->param('Semester');
    my $Category         = $c->param('Category');
    my $Programme         = $c->param('Programme');
    my $TimeTable_Link         = $c->param('TimeTable_Link');

    # print "user with group " . $c->session->{usergroup} . " try to update\n";

        my $s = new ModelDuxInterface;
        $s->setTimetable( $Session, $Semester, $Category, $Programme, $TimeTable_Link);
        $s->UpdateTimesTables( $dbh, $id_TimeTable );
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... id_TimeTable=$id_TimeTable" );
};


get '/deleteTTable' => sub ($c) {
    my $id_TimeTable = $c->param("id_TimeTable");

        if ( $id_TimeTable ne "" ) {
            my $s = new ModelDuxInterface;
            $s->deleteTimeTables( $dbh, $id_TimeTable );
        }
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Delete row... id_TimeTable=$id_TimeTable" );
};



get '/FilterTimeTable' => sub ($c) {

    my $Category = $c->param("Category");
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->FilterTimeTables( $dbh, $Category) );  
};


get '/SearchTimeTable' => sub ($c) {

    my $Session = $c->param("Session");
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->SearchTimetables( $dbh, $Session) );  
};




get '/CreateEvents' => sub ($c) {
    my $Session  = $c->param("Session");
    my $Semester = $c->param('Semester');
    my $Date = $c->param('Date');
    my $Category = $c->param('Category');
    my $ProgramName = $c->param('ProgramName');
    my $Programme_Link = $c->param('Programme_Link');

      print "DataH = ". $ProgramName. "\n";



    my $s = new ModelDuxInterface;

    $s->setEvent($Session, $Semester,$Date, $Category,$ProgramName,$Programme_Link);
    $s->createEventss($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $Session - $Semester - $Date - $Category - $ProgramName - $Programme_Link");
};






get '/readEventList' => sub ($c) {
    my $id_event = $c->param("id_event");

    my $s = new ModelDuxInterface;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    if ( $id_event eq "" ) {
        $c->render( text => $s->readEvent($dbh) );
    }
    else {
        $c->render( text => $s->readEvent( $dbh, $id_event ) );
    }
    
};



get '/readupdateEvent' => sub ($c) {
    my $id_event = $c->param("id_event");
    my $Session       = $c->param('Session');
    my $Semester     = $c->param('Semester');
    my $Date         = $c->param('Date');
    my $Category         = $c->param('Category');
    my $ProgramName         = $c->param('ProgramName');
    my $Programme_Link         = $c->param('Programme_Link');

    # print "user with group " . $c->session->{usergroup} . " try to update\n";

        my $s = new ModelDuxInterface;
        $s->setEvent( $Session, $Semester,$Date, $Category, $ProgramName, $Programme_Link);
        $s->UpdateEvents( $dbh, $id_event );
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... id_event=$id_event" );
};





get '/DeleteEvents' => sub ($c) {
    my $id_event = $c->param("id_event");

        if ( $id_event ne "" ) {
            my $s = new ModelDuxInterface;
            $s->deleteEvent( $dbh, $id_event );
        }
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Delete row... id_event=$id_event" );
};





get '/FilterEvents' => sub ($c) {

    my $Category = $c->param("Category");
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->FilterEventss( $dbh, $Category) );  
};



get '/SearchEvent' => sub ($c) {

    my $Session = $c->param("Session");
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->SearchEventS( $dbh, $Session) );  
};




get '/FilterUsers' => sub ($c) {

    my $role = $c->param("role");
    my $s = new ModelUser;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->FilterUsersz( $dbh, $role) );  
};




get '/SearchIDusew' => sub ($c) {
    my $siri  = $c->param("siri");
    my $s = new ModelUser;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->SearchUserIds( $dbh, $siri ) );    
};





get '/DeletingUsers' => sub ($c) {
    my $id_user = $c->param("id_user");
    my $role = $c->param("role");
    my $siri = $c->param("siri");

        if ( $id_user ne "" && $role eq "coordinator") {
            my $s = new ModelUser;
            $s->deleteUsersz( $dbh, $id_user);
        }

        elsif ($id_user ne "" && $role eq "lecturer"){
            my $s = new ModelUser;
            $s->deleteUsersz( $dbh, $id_user);
            my $g = new ModelLect;
            $g->deleteLect( $dbh, $siri);

        }
        elsif ($id_user ne "" && $role eq "student"){
            my $s = new ModelUser;
            $s->deleteUsersz( $dbh, $id_user);
            my $h = new ModelStudent;
            $h->deleteStudent( $dbh, $siri);

        }
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Delete row... id_user=$id_user" );
};









get '/createPSM' => sub ($c) {
    my $Session  = $c->param("Session");
    my $Semester = $c->param('Semester');
    my $Category = $c->param('Category');
    my $student_name = $c->param('student_name');   
    my $student_MatricNo = $c->param('student_MatricNo');
    my $title = $c->param('title');
    my $marks = $c->param('marks');
    my $Supervisor = $c->param('Supervisor');
    my $psm_link = $c->param('psm_link');

    my $s = new ModelDuxInterface;

    $s->setPSM($Session, $Semester,$Category,$student_name,$student_MatricNo,$title ,$marks , $Supervisor,$psm_link);
    $s->createPSMs($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render(text => "Create row for $Session - $Semester - $Category - $student_name - $student_MatricNo - $title - $marks - $Supervisor - $psm_link");
};







# get '/readPSM' => sub ($c) {
#     my $id_psm = $c->param("id_psm");
#     my $Supervisor = $c->param("Supervisor");

   
#     print "Super = ".$Supervisor. "\n";

#     my $s = new ModelDuxInterface;

#     ### Disable CORS policy by browser
#     $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

#     if ($id_psm eq "") {
#         $c->render( text => $s->readPSMss($dbh,$Supervisor) );
#     }
#     else {
#         $c->render( text => $s->readPSMss($dbh, $id_psm,$Supervisor) );
#     }
    
# };


get '/readPSM' => sub ($c) {

    my $Supervisor = $c->param("Supervisor");
    my $student_name = $c->param("student_name");
    my $Role = $c->param("Role");

    if($Role eq "lecturer"){
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->readPSMss( $dbh, $Supervisor,$Role) );  

    }
    else{
    my $s = new ModelDuxInterface;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => $s->readPSMss( $dbh, $student_name,$Role) );  
    }
};





get '/readupdatePSM' => sub ($c) {
    my $id_psm = $c->param("id_psm");
    my $Session = $c->param('Session');
    my $Semester = $c->param('Semester');
    my $Category = $c->param('Category');
    my $student_name = $c->param('student_name'); 
    my $student_MatricNo = $c->param('student_MatricNo');
    my $title = $c->param('title');
    my $marks = $c->param('marks');
    my $Supervisor = $c->param('Supervisor');
    my $psm_link = $c->param('psm_link');

    # print "user with group " . $c->session->{usergroup} . " try to update\n";

        my $s = new ModelDuxInterface;
        $s->setPSM( $Session, $Semester, $Category,$student_name, $student_MatricNo, $title,$marks,$Supervisor,$psm_link);
        $s->UpdatePSM( $dbh, $id_psm );
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... id_psm =$id_psm" );
};







get '/deletePSMzs' => sub ($c) {
    my $id_psm = $c->param("id_psm");

        if ( $id_psm ne "" ) {
            my $s = new ModelDuxInterface;
            $s->deletePSMx( $dbh, $id_psm );
        }
    
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Delete row... id_psm=$id_psm" );
};
























get '/checkUser' => sub ($c) {
    my $username = $c->param('username');
    my $entered_email = $c->param('email');
    my $entered_siri = $c->param('siri');

    my $s = new ModelUser;
    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    
    $c->render( text => $s->readCheckUserz( $dbh, $entered_email, $entered_siri,$username ) );

    
    # my $sth = $dbh->prepare('SELECT COUNT(*) FROM user WHERE email = ? OR siri = ?');
    # $sth->execute($entered_email, $entered_siri);
    # my ($count) = $sth->fetchrow_array;

    
    # $c->render(JSON => { exists => $count > 0 });
};

app->start;

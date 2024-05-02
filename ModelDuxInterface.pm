use strict;
use warnings;
use JSON;


package ModelDuxInterface;

sub new {
    my $class = shift @_;
    return bless {
        "Session"  => "???",
        "Semester"     => "???",
        "Category" => "???",
        "Programme" => "???",
        "TimeTable_Link" => "???"
    }, $class;
}

sub setTimetable {
  my $this = shift @_;
  
  my $Session = shift @_;
  my $Semester = shift @_;
  my $Category = shift @_;
  my $Programme = shift @_;
  my $TimeTable_Link = shift @_;
  
  $this->{'Session'} = $Session;
  $this->{'Semester'} = $Semester;
  $this->{'Category'} = $Category;
  $this->{'Programme'} = $Programme;
  $this->{'TimeTable_Link'} = $TimeTable_Link;
  
}

sub createTimetables {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    
    if ($sth = $dbh->prepare('INSERT INTO Timetable(Session, Semester, Category, Programme,TimeTable_Link) values (?, ?, ?, ?, ?)')) {
        if ($sth->execute($this->{'Session'}, $this->{'Semester'}, $this->{'Category'}, $this->{'Programme'}, $this->{'TimeTable_Link'})) {
            print "Success create new TimeTable...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}


sub readTimeTables {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_TimeTable = shift @_;
    my $sth = undef;
    
    if ($id_TimeTable eq "") {
        if ($sth = $dbh->prepare('SELECT * FROM Timetable')) {
            if ($sth->execute()) {
                my @rows = ();

                while (my $ref = $sth->fetchrow_hashref()) {
                    push(@rows, $ref);
                }

                return JSON->new->pretty->encode(\@rows);

            } else {
                print "Error: $dbh->errstr()\n";
            }
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        if ($sth = $dbh->prepare('SELECT * FROM Timetable WHERE id_TimeTable=?')) {
            if ($sth->execute($id_TimeTable)) {
                my $ref = $sth->fetchrow_hashref();
                return JSON->new->pretty->encode($ref);

            } else {
                print "Error: $dbh->errstr()\n";
            }
        } else {
            print "Error: $dbh->errstr()\n";
        }
    }
}





sub FilterTimeTables {
    my $this = shift @_;
    my $dbh = shift @_;
    my $Category  = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('SELECT * FROM Timetable WHERE Category=?')) {
        if ($sth->execute($Category)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}



sub SearchTimetables {
    my $this = shift @_;
    my $dbh = shift @_;
    my $Session  = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('SELECT * FROM Timetable WHERE Session=?')) {
        if ($sth->execute($Session)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}





sub UpdateTimesTables {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_TimeTable = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('UPDATE Timetable SET Session=?, Semester=?, Category=?, Programme=?, TimeTable_Link=? WHERE id_TimeTable=?')) {
        if ($sth->execute($this->{'Session'}, $this->{'Semester'}, $this->{'Category'}, $this->{'Programme'},$this->{'TimeTable_Link'}, $id_TimeTable)) {
            print "Success update new Timetable...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}




sub deleteTimeTables {
    my $this = shift @_;  
    my $dbh = shift @_;
    my $id_TimeTable = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('DELETE FROM Timetable WHERE id_TimeTable=?')) {
        if ($sth->execute($id_TimeTable)) {
            print "Success delete time table...\n";
            
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }

}




sub setEvent {
  my $this = shift @_;
  
  my $Session = shift @_;
  my $Semester = shift @_;
  my $Date = shift @_;
  my $Category = shift @_;
  my $ProgramName = shift @_;
  my $Programme_Link = shift @_;
  
  $this->{'Session'} = $Session;
  $this->{'Semester'} = $Semester;
  $this->{'Date'} = $Date;
  $this->{'Category'} = $Category;
  $this->{'ProgramName'} = $ProgramName;
  $this->{'Programme_Link'} = $Programme_Link;
  
}





sub createEventss {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    
    if ($sth = $dbh->prepare('INSERT INTO Event(Session, Semester, Date, Category, ProgramName ,Programme_Link) values (?, ?, ?, ?, ?,?)')) {
        if ($sth->execute($this->{'Session'}, $this->{'Semester'}, $this->{'Date'}, $this->{'Category'}, $this->{'ProgramName'}, $this->{'Programme_Link'})) {
            print "Success create new Event...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}



sub readEvent {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_event = shift @_;
    my $sth = undef;
    
    if ($id_event eq "") {
        if ($sth = $dbh->prepare('SELECT * FROM Event')) {
            if ($sth->execute()) {
                my @rows = ();

                while (my $ref = $sth->fetchrow_hashref()) {
                    push(@rows, $ref);
                }

                return JSON->new->pretty->encode(\@rows);

            } else {
                print "Error: $dbh->errstr()\n";
            }
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        if ($sth = $dbh->prepare('SELECT * FROM Event WHERE id_event=?')) {
            if ($sth->execute($id_event)) {
                my $ref = $sth->fetchrow_hashref();
                return JSON->new->pretty->encode($ref);

            } else {
                print "Error: $dbh->errstr()\n";
            }
        } else {
            print "Error: $dbh->errstr()\n";
        }
    }
}




sub UpdateEvents {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_event = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('UPDATE Event SET Session=?, Semester=?,Date=?, Category=?, ProgramName=?, Programme_Link=? WHERE id_event=?')) {
        if ($sth->execute($this->{'Session'}, $this->{'Semester'},$this->{'Date'}, $this->{'Category'}, $this->{'ProgramName'},$this->{'Programme_Link'}, $id_event)) {
            print "Success update new Event...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}




sub deleteEvent {
    my $this = shift @_;  
    my $dbh = shift @_;
    my $id_event = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('DELETE FROM Event WHERE id_event=?')) {
        if ($sth->execute($id_event)) {
            print "Success delete time table...\n";
            
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }

}




sub FilterEventss {
    my $this = shift @_;
    my $dbh = shift @_;
    my $Category  = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('SELECT * FROM Event WHERE Category=?')) {
        if ($sth->execute($Category)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}




sub SearchEventS {
    my $this = shift @_;
    my $dbh = shift @_;
    my $Session  = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('SELECT * FROM Event WHERE Session=?')) {
        if ($sth->execute($Session)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}




sub setPSM {
  my $this = shift @_;
  my $Session = shift @_;
  my $Semester = shift @_;
  my $Category = shift @_;
  my $student_name = shift @_;
  my $student_MatricNo = shift @_;
  my $title = shift @_;
  my $marks = shift @_;
  my $Supervisor = shift @_;
  my $psm_link = shift @_;
  
    $this->{'Session'} = $Session;
    $this->{'Semester'} = $Semester;
    $this->{'Category'} = $Category;
    $this->{'student_name'} = $student_name;
    $this->{'student_MatricNo'} = $student_MatricNo;
    $this->{'title'} = $title;
    $this->{'marks'} = $marks;
    $this->{'Supervisor'} = $Supervisor;
    $this->{'psm_link'} = $psm_link;
  
}



sub createPSMs {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('INSERT INTO PSM(Session, Semester, Category, student_name, student_MatricNo, title, marks, Supervisor, psm_link) values (?, ?, ?, ?, ?, ?, ?, ?, ?)')) {
        if ($sth->execute(
            $this->{'Session'},
            $this->{'Semester'},
            $this->{'Category'},
            $this->{'student_name'},
            $this->{'student_MatricNo'},
            $this->{'title'},
            $this->{'marks'},
            $this->{'Supervisor'},
            $this->{'psm_link'}
        )) {
            print "Success create new PSM...\n";
        } else {
            print "Error: " . $dbh->errstr() . "\n";
        }
    } else {
        print "Error: " . $dbh->errstr() . "\n";
    }
}








sub readPSMss {
    my $this = shift @_;
    my $dbh = shift @_;
    my $user  = shift @_;
    my $Role = shift @_;
    my $sth = undef;

    print "Values: roles=$user\n";
    
    if($Role eq "lecturer"){
    if ($sth = $dbh->prepare('SELECT * FROM PSM WHERE Supervisor=?')) {
        if ($sth->execute($user)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
     }

    else{
    if ($sth = $dbh->prepare('SELECT * FROM PSM WHERE student_name=?')) {
        if ($sth->execute($user)) {
            my @result;  

            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            if (@result) {
                return JSON->new->pretty->encode(\@result);
            } else {
                return JSON->new->pretty->encode({ error => 'No users found with the specified program' });
            }
        } else {
            return JSON->new->pretty->encode({ error => $dbh->errstr() });
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
     }
}





sub UpdatePSM {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_psm = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('UPDATE PSM SET Session=?, Semester=?,Category=?, student_name=?, student_MatricNo=?, title=?, marks=?, Supervisor=?, psm_link=? WHERE id_psm=?')) {
        if ($sth->execute($this->{'Session'}, $this->{'Semester'},$this->{'Category'}, $this->{'student_name'},$this->{'student_MatricNo'},$this->{'title'},$this->{'marks'},$this->{'Supervisor'},$this->{'psm_link'}, $id_psm)) {
            print "Success update new PSM...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}




sub deletePSMx {
    my $this = shift @_;  
    my $dbh = shift @_;
    my $id_psm = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('DELETE FROM PSM WHERE id_psm=?')) {
        if ($sth->execute($id_psm)) {
            print "Success delete PSM...\n";
            
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }

}

return 1;
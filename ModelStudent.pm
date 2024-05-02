use strict;
use warnings;
use JSON;

package ModelStudent;

sub new {
  my $class = shift @_;
  return bless {"S_name" => "???", "matric" => "???", "S_email" => "???", "S_role" => "???","programme" => "???"}, $class;
}

sub setStudent {
  my $this = shift @_;

  my $matric = shift @_;
  my $S_name = shift @_;
  my $S_email = shift @_;
  my $S_role = shift @_;
  my $programme  = shift @_;

 
  $this->{'matric'} = $matric;
  $this->{'S_name'} = $S_name;
  $this->{'S_email'} = $S_email;
  $this->{'S_role'} = $S_role;
  $this->{'programme'} = $programme;
}

sub updateStudent {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $matric = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('UPDATE student SET matric=?, S_name=?, S_email=?, S_role=? WHERE matric=?')) {
        if ($sth->execute($this->{'matric'}, $this->{'S_name'}, $this->{'S_email'},$this->{'S_role'}, $matric)) {
            print "Success update student...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}


sub createStudent {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('INSERT INTO student(matric, S_name , S_email, S_role,programme) values (?, ?, ?, ?,?)')) {
        if ($sth->execute( $this->{'matric'}, $this->{'S_name'}, $this->{'S_email'}, $this->{'S_role'},$this->{'programme'})) {
            print "Success create new student...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}

sub readStudent {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_student = shift @_;
    my $sth = undef;
    
    if ($id_student eq "") {
        if ($sth = $dbh->prepare('SELECT * FROM student')) {
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
        if ($sth = $dbh->prepare('SELECT * FROM student WHERE id_student=?')) {
            if ($sth->execute($id_student)) {
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

sub FilterStudent {
    my $this = shift @_;
    my $dbh = shift @_;
    my $programme  = shift @_;
    my $sth = undef;

    # print "Values DLM PM: programme=$programme\n";

    if ($sth = $dbh->prepare('SELECT * FROM student WHERE programme=?')) {
        if ($sth->execute($programme)) {
            my @result;  # Array to store multiple rows

            # Loop through all rows in the result set
            while (my $ref = $sth->fetchrow_hashref()) {
                push @result, $ref;
            }

            # Check if any rows were found
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




sub SearchStudent {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $matric = shift @_;

    my $sth = undef; 
        if ($sth = $dbh->prepare('SELECT * FROM student WHERE matric=?')) {

            if ($sth->execute($matric)) {
                        my $ref = $sth->fetchrow_hashref();        
                        if ($ref) {
                            return JSON->new->pretty->encode($ref);
                        } else {
                                  
                            return JSON->new->pretty->encode({ error => 'User not found' });
                        }

                    } else {
                        return JSON->new->pretty->encode({ error => $dbh->errstr() });
                    }
        }    
        else {
            print "Error: $dbh->errstr()\n";
        }  
}




sub deleteStudent {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $matric = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('DELETE FROM student WHERE matric=?')) {
        if ($sth->execute($matric)) {
            print "Success delete student...\n";
            
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }

}























# sub update {
#     my $this = shift @_;
    
#     my $dbh = shift @_;
#     my $id_student = shift @_;
#     my $sth = undef;
    
#     if ($sth = $dbh->prepare('UPDATE student SET S_name=?, matric=?, S_email=?, S_role=? WHERE id_student=?')) {
#         if ($sth->execute($this->{'S_name'}, $this->{'matric'}, $this->{'S_email'}, $this->{'S_role'}, $id_student)) {
#             print "Success create new student...\n";
#         } else {
#             print "Error: $dbh->errstr()\n";
#         }
#     } else {
#         print "Error: $dbh->errstr()\n";
#     }
# }



return 1;


# sub FilterStudent {
#     my $this = shift @_;
#     my $dbh = shift @_;
#     my $id_student = shift @_;
#     my $programme = shift @_;
#     my $sth = undef;
    
#     if ($id_student eq "") {
#         if ($sth = $dbh->prepare('SELECT * FROM student WHERE programme=?')) {
#             if ($sth->execute($programme)) {
#                 my @rows = ();

#                 while (my $ref = $sth->fetchrow_hashref()) {
#                     push(@rows, $ref);
#                 }

#                 return JSON->new->pretty->encode(\@rows);

#             } else {
#                 print "Error: $dbh->errstr()\n";
#             }
#         } else {
#             print "Error: $dbh->errstr()\n";
#         }
#     } else {
#         if ($sth = $dbh->prepare('SELECT * FROM student WHERE id_student=? AND programme=?')) {
#             if ($sth->execute($id_student,$programme)) {
#                 my $ref = $sth->fetchrow_hashref();
#                 return JSON->new->pretty->encode($ref);

#             } else {
#                 print "Error: $dbh->errstr()\n";
#             }
#         } else {
#             print "Error: $dbh->errstr()\n";
#         }
#     }
# }

# sub FilterStudent{
#     my $this = shift @_;
#     my $dbh = shift @_;
#     my $programme  = shift @_;
#     my $sth = undef;

#     print "Values DLM PM: programme=$programme\n";
    
        # if ($sth = $dbh->prepare('SELECT * FROM student WHERE programme=?')) {
        #     if ($sth->execute($programme)) {
        #         my $ref = $sth->fetchrow_hashref();
        #         return JSON->new->pretty->encode($ref);

        #     } else {
        #         print "Error: $dbh->errstr()\n";
        #     }
        # } else {
        #     print "Error: $dbh->errstr()\n";
        # }


#          if ($sth = $dbh->prepare('SELECT * FROM student WHERE programme=?')) {

#             if ($sth->execute($programme)) {
#                         my $ref = $sth->fetchrow_hashref();        
#                         if ($ref) {
#                             return JSON->new->pretty->encode($ref);
#                         } else {
                                  
#                             return JSON->new->pretty->encode({ error => 'User not found' });
#                         }

#                     } else {
#                         return JSON->new->pretty->encode({ error => $dbh->errstr() });
#                     }
#         }    
#         else {
#             print "Error: $dbh->errstr()\n";
#         }
# }
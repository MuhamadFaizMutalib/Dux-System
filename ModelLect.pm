use strict;
use warnings;
use JSON;

package ModelLect;

sub new {
  my $class = shift @_;
  return bless {"L_name" => "???", "LectID" => "???", "L_email" => "???", "L_role" => "???", "programme" => "???"}, $class;
}

sub setLect {
  my $this = shift @_;

  my $LectID = shift @_;
  my $L_name = shift @_;
  my $L_email = shift @_;
  my $L_role = shift @_;
  my $programme = shift @_;

 
  $this->{'LectID'} = $LectID;
  $this->{'L_name'} = $L_name;
  $this->{'L_email'} = $L_email;
  $this->{'L_role'} = $L_role;
  $this->{'programme'} = $programme;
  
}

sub updateLect {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $LectID = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('UPDATE lecturer SET LectID=?, L_name=?, L_email=?, L_role=? WHERE LectID=?')) {
        if ($sth->execute($this->{'LectID'}, $this->{'L_name'}, $this->{'L_email'},$this->{'L_role'}, $LectID)) {
            print "Success update lecturer...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}


sub createLect {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('INSERT INTO lecturer(LectID, L_name , L_email, L_role, programme)  values (?, ?, ?, ?, ?)')) {
        if ($sth->execute( $this->{'LectID'}, $this->{'L_name'}, $this->{'L_email'}, $this->{'L_role'}, $this->{'programme'})) {
            print "Success create new lecturer...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}


sub readLecturer {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_lecturer = shift @_;
    my $sth = undef;
    
    if ($id_lecturer eq "") {
        if ($sth = $dbh->prepare('SELECT * FROM lecturer')) {
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
        if ($sth = $dbh->prepare('SELECT * FROM lecturer WHERE id_lecturer=?')) {
            if ($sth->execute($id_lecturer)) {
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

sub FilterLecturer {
    my $this = shift @_;
    my $dbh = shift @_;
    my $programme  = shift @_;
    my $sth = undef;

    print "Values DLM PM: programme=$programme\n";

    if ($sth = $dbh->prepare('SELECT * FROM lecturer WHERE programme=?')) {
        if ($sth->execute($programme)) {
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


sub SearchLecturer {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $LectID  = shift @_;

    print "Values DLM PM: LectID=$LectID\n";

    my $sth = undef; 
        if ($sth = $dbh->prepare('SELECT * FROM lecturer WHERE LectID=?')) {

            if ($sth->execute($LectID)) {
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



sub deleteLect {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $LectID = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('DELETE FROM lecturer WHERE LectID=?')) {
        if ($sth->execute($LectID)) {
            print "Success delete lecturer...\n";
            
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }

}



return 1;
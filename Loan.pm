package Finance::Loan;

require 5.005_62;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Finance::Loan ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.02';


# Technique for new class borrowed from Effective Perl Programming by Hall / Schwartz pp 211
sub new{
  my $pkg = shift;
  # bless package variables
  bless{
  principle => 0.00,
  interest_rate => 0.00,
  number_of_months => 0,
  @_}, $pkg;
}

# Forecasting With Your Microcomputer pp 198
sub getMonthlyPayment{
  my $self = shift;
  my $flag = shift || 1;
  # P = Principle
  # r = interest Rate Per Month (eg. 14%/12)
  # S = Monthly Payemnt
  # n = Number of Months

  my $P = $self->{principle};
  my $r = $self->{interest_rate}/12;
  my $n = $self->{number_of_months};
  if ($flag==1)
  {
    my $almost_val = ($P*$r*((1+$r)**$n))/(((1+$r)**$n)-1.0);
    my $retval = sprintf("%0.2f",$almost_val);
    return($retval);
  }
  else
  {
    return($P*$r*((1+$r)**$n))/(((1+$r)**$n)-1.0);
  }
}

# Forecasting With Your Microcomputer pp198
sub getInterestPaid{
  my $self = shift;  
  # (n*s)-P
  my $n = $self->{number_of_months};
  my $S = getMonthlyPayment($self,2);
  my $P = $self->{principle};
  my $almost_val = ($n*$S)-$P;
  my $retval = sprintf("%0.2f",$almost_val);
  return($retval);
}

# Forecasting With Your Microcomputer pp198
sub getBalanceAfterPaymentN{
  my $self = shift;
  my $payment = shift;
  # B = S * ((1-(1-r)^-x)/r)
  my $S = getMonthlyPayment($self,2);
  my $r = $self->{interest_rate}/12;
  my $x = -($self->{number_of_months} - $payment);
  my $almost_val = $S*((1-((1-$r)**($x)))/$r);
  my $retval = sprintf("%0.2f",$almost_val);
  return($retval);
}

1;
__END__

=head1 NAME

Finance::Loan - Calculates monthly payment, interest paid, and unpaid balance on a loan.

=head1 SYNOPSIS

  use Finance::Loan;
  my $loan = new Finance::Loan(principle=>1000,interest_rate=>.07,number_of_months=>36); # 7% interest rate 
  my $monthlyPayment = $loan->getMonthlyPayment();
  my $interestPaid=$loan->getInterestPaid();
  my $balanceAfterPaymentN = $loan->balanceAfterPayementN(n);

=head1 DESCRIPTION

=head2 new Finance::Loan(principle=>1000,interest_rate=>.07,number_of_months=>36)

Creates a new loan object.  Ensure that interest_rate is a decimal.  So, a 7 percent interest rate is .07 while a 14 percent
interest rate is .14

=head2 $loan->getMonthlyPayment()

Returns the monthly payment on the loan.

=head2 $loan->getInterestPaid()

Returns the total amount of interest that needs to be paid on the loan.

=head2 $loan->balanceAfterPaymentN(n)

Returns the unpaid balance on the account after payment n, if no additional principle payment on the loan is received.

=head1 BUGS

None known.

=head1 DISCLAIMER

Calculations are presumed to be reliable, but not guaranteed.  

=head1 AUTHOR

Zachary Zebrowski zaz@mitre.org

=head1 SEE ALSO

Nickell, Daniel - Forecasting With Your Microcomputer, Tab Books (C) 1983.

=cut



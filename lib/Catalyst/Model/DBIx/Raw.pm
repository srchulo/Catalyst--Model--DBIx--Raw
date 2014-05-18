package Catalyst::Model::DBIx::Raw;
use strict;
use warnings;

use Carp ();
use DBIx::Raw;
use Moose;
extends 'Catalyst::Model';
with 'Catalyst::Component::InstancePerContext';
no Moose;

#ABSTRACT: A Catalyst Model for DBIx::Raw

sub new {
	my $self  = shift->next::method(@_);
	my $class = ref($self);
    
	my ($c) = @_;	
	$self->_create_raw($c);
    return $self;
}

sub _create_raw { 
	my ($self, $c) = @_;

	my %options;
	if($self->{dbix_class_model}) { 
		my $model = $c->model($self->{dbix_class_model});
		#catalyst will throw it's own error if model does not exist
		$options{dbh} = $c->model($self->{dbix_class_model})->storage->dbh;
	}
	else { 
		Carp::croak("Must provide either dbix_class_model, or (dsn, user, password), or conf") unless $self->{dbix_class_model}
					or ($self->{dsn} and $self->{user} and $self->{password}) or $self->{conf};
		%options =	(
						dns => $self->{dsn},
						user => $self->{user},
						password => $self->{password},
						conf => $self->{conf},
					);
	}

    # Instantiate a new DBIx::Raw object...
    $self->{raw} = DBIx::Raw->new(%options);
}

sub raw { shift->{raw} }

sub build_per_context_instance {
	my ($self, $c) = @_;
 
	return $self unless ref $c;
	$self->_create_raw($c);
	return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my %args = @_;
 
    our $AUTOLOAD;
 
    my $program = $AUTOLOAD;
    $program =~ s/.*:://;
 
    # pass straight through to our DBIx::Raw object
    return $self->{raw}->$program(%args);
}

1;

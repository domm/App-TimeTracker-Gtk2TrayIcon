package App::TimeTracker::Gtk2TrayIcon;
use 5.010;
use strict;
use warnings;
use Gtk2 -init;
use AnyEvent;
use App::TimeTracker;
use App::TimeTracker::Data::Task;
use Gtk2::TrayIcon;
use FindBin qw($Bin);

my $storage_location = App::TimeTracker->storage_location;

my $window= Gtk2::TrayIcon->new("test");
my $eventbox = Gtk2::EventBox->new;
my $img= Gtk2::Image->new_from_file("$Bin/lazy.png");
$eventbox->add($img);

my $current;
my $t = AnyEvent->timer(after => 0, interval => 5, cb => sub {
    my $task = App::TimeTracker::Task->get_current($storage_location);
    if ($task) {
        $img->set_from_file("$Bin/busy.png");
        $current = $task->project.$task->nice_tags;
    }
    else {
        $img->set_from_file("$Bin/lazy.png");
        $current = 'nothing';
    }
});



$eventbox->signal_connect( 'enter-notify-event' => sub { 
    unless ($current eq 'nothing') {
    
        my $dialog = Gtk2::MessageDialog->new ($window,
            [qw/modal destroy-with-parent/],
            'other',
            'none',
            $current
        );
    
        $dialog->set_decorated (0);
        $dialog->set_gravity ('south-west');

        my $t = AnyEvent->timer(after => 5, cb => sub {
            $dialog->destroy;
        });			
        my $retval = $dialog->run;
        $dialog->destroy;
    }
});

$window->add($eventbox);
$window->show_all;


Gtk2->main;


package App::TimeTracker::Gtk2TrayIcon;
use 5.010;
use strict;
use warnings;
our $VERSION = "1.000";
# ABSTRACT: Show TimeTracker status in a GTK tray applet

use Gtk2 -init;
use AnyEvent;
use App::TimeTracker::Proto;
use App::TimeTracker::Data::Task;
use Gtk2::TrayIcon;
use FindBin qw($Bin);
use File::ShareDir qw(dist_file);

sub init {

    my $storage_location = App::TimeTracker::Proto->new->home;

    my $lazy =
        -e 'share/lazy.png'
        ? 'share/lazy.png'
        : dist_file( 'App-TimeTracker-Gtk2TrayIcon', 'lazy.png' );
    my $busy =
        -e 'share/busy.png'
        ? 'share/busy.png'
        : dist_file( 'App-TimeTracker-Gtk2TrayIcon', 'busy.png' );
    my $img      = Gtk2::Image->new_from_file($lazy);
    my $window   = Gtk2::TrayIcon->new(__PACKAGE__);
    my $eventbox = Gtk2::EventBox->new;
    $eventbox->add($img);

    my $current;
    my $t = AnyEvent->timer(
        after    => 0,
        interval => 5,
        cb       => sub {
            my $task =
                App::TimeTracker::Data::Task->current($storage_location);
            if ($task) {
                $img->set_from_file($busy);
                $current = $task->say_project_tags;
            }
            else {
                $img->set_from_file($lazy);
                $current = 'nothing';
            }
        } );

    $eventbox->signal_connect(
        'enter-notify-event' => sub {
            unless ( $current eq 'nothing' ) {

                my $dialog =
                    Gtk2::MessageDialog->new( $window,
                    [qw/modal destroy-with-parent/],
                    'other', 'none', $current );

                $dialog->set_decorated(0);
                $dialog->set_gravity('south-west');

                my $t = AnyEvent->timer(
                    after => 5,
                    cb    => sub {
                        $dialog->destroy;
                    } );
                my $retval = $dialog->run;
                $dialog->destroy;
            }
        } );

    $window->add($eventbox);
    $window->show_all;
}

1;

__END__

=head1 DESCRIPTION

Backend for L<tracker_gtk_trayicon.pl>

=method init

Initialize the GTK app.



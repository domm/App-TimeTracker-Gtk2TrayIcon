use strict;
use warnings;
use App::TimeTracker::Gtk2TrayIcon;
use Test::Most;

lives_ok {
    App::TimeTracker::Gtk2TrayIcon->init;
} 'init seems to work';

done_testing();

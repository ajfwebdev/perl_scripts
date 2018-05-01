#!/usr/bin/perl

use strict;

my $old_dir = $ARGV[0];

opendir (my $dh, $old_dir) or die "Cannot open $old_dir: $!";

# fix the directory name.
my $new_dir = $old_dir;
$new_dir =~ s/\s+/_/g;
$new_dir =~ s/[^a-zA-Z_0-9.]//g;

print "Directory:\n";
print "Old: $old_dir\n";
print "New: $new_dir\n\n";

my @files = sort grep { ! -d } readdir $dh;
closedir $dh;

# Rename the directory.
rename($old_dir, $new_dir) || die "Cannot rename dir, $old_dir: $!";

print "Files:\n";
foreach my $old_name (@files) {

  # fix the filename.
  my $new_name = $old_name;
  $new_name =~ s/\s+/_/g;
  $new_name =~ s/[^a-zA-Z_0-9.]//g;

  # Rename the file from the old to the new filename.
  my $old_file_path = $new_dir . '/' . $old_name;
  my $new_file_path = $new_dir . '/' . $new_name;
  rename($old_file_path, $new_file_path) || die "Cannot rename file, $old_file_path: $!";

  print "Old: $old_name\n";
  print "New: $new_name\n";
}


# == Class: wuala
#
# Full description of class wuala here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { wuala:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Thomas Schubert (FunThomas424242) <funthomas424242@gmail.com>
#
# === Copyright
#
# Copyright 2014  Thomas Schubert (FunThomas424242), initial project owner
#

class wuala  (
	$user 				= 'huluvu424242',
	$wualaVersion 		= 'olympus',
    $tmpDir 			= '/tmp',
	$srcURL 			= undef,
	$homeDir 			= undef,
	$libName			= undef,
	$targetDir 			= undef,
	$checksum			= false,
){
 
	# init srcURL
	if $srcURL == undef {
    	$_srcURL = "https://cdn.wuala.com/repo/other/wuala.tar.gz"
  	}
  	else {
    	$_srcURL = $srcURL
  	}

	# init homeDir
	if $homeDir == undef {
    	$_homeDir = "/home/$user"
  	}
  	else {
    	$_homeDir = $homeDir
  	}

	# init libName
	if $libName == undef {
    	$_libName = "wuala-$wualaVersion"
  	}
  	else {
    	$_libName = $libName
  	}

	# init targetDir
	if $targetDir == undef {
    	$_targetDir = "$_homeDir"
  	}
  	else {
    	$_targetDir = $targetDir
  	}


	notice( "_srcURL: $_srcURL")
	notice( "_homeDir: $_homeDir")
	notice( "_libName: $_libName")
	notice( "_targetDir: $_targetDir")

	file { $tmpDir:
		ensure => directory,
		#mode => 666,
		# owner => www-data,
		# group => www-data
	}


	archive { $_libName:
	  ensure => present,
	  url    => $_srcURL,
	  src_target => $tmpDir,
	  target => $_targetDir,
	  checksum => $checksum,
    require => File[$tmpDir],
	}

	file { 'wuala.desktop':
		ensure => file,
		path => "$_homeDir/Schreibtisch/wuala.desktop",
		content => template('wuala/wuala.desktop.erb'),
		require => Archive[$_libName],
	}
}



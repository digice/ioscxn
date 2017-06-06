<?php

/**
  * @package   iOSCxn
  * @author    Roderic Linguri <linguri@digices.com>
  * @copyright 2017 Digices LLC
  * @license   https://digices.com/license/mit.txt
  **/

/** iOSCxn Autoload **/

namespace ioscxn;

function load_vendor() {
  $path = __DIR__.DIRECTORY_SEPARATOR.'vendor';
  $di = new \DirectoryIterator($path);
  foreach ($di as $item) {
    $dn = $item->getFilename();
    if (substr($dn, 0, 1) != '.') {
      require_once $path.DIRECTORY_SEPARATOR.$dn.DIRECTORY_SEPARATOR.'autoload.php';
    }
  }
}

function load_lib() {
  $path = __DIR__.DIRECTORY_SEPARATOR.'lib';
  $di = new \DirectoryIterator($path);
  foreach ($di as $item) {
    $fn = $item->getFilename();
    if (substr($fn, 0, 1) != '.') {
      require_once $path.DIRECTORY_SEPARATOR.$fn;
    }
  }
}

$config_path =  __DIR__.DIRECTORY_SEPARATOR.'etc'.DIRECTORY_SEPARATOR.'config.php';

require_once $config_path;

\ioscxn\load_vendor();

\ioscxn\load_lib();

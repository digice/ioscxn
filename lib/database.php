<?php

/**
 * @package   iOSCxn
 * @author    Roderic Linguri <linguri@digices.com>
 * @copyright 2017 Digices LLC
 * @license   https://digices.com/license/mit.txt
 **/

namespace ioscxn;

class Database extends \sqlayr\Database
{
  /** @property Database instance **/
  protected static $shared;

  /** @method Database getter **/
  public static function shared()
  {
    if (!isset(self::$shared)) {
      self::$shared = new self();
    }
    return self::$shared;
  } // ./shared

  /** @method constructor **/
  public function __construct()
  {
    $this->host = DB_HOST;
    $this->name = DB_NAME;
    $this->user = DB_USER;
    $this->pass = DB_PASS;
    parent::__construct();
  } // ./construct

} // ./Database

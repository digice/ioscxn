<?php

/**
 * @package   iOSCxn
 * @author    Roderic Linguri <linguri@digices.com>
 * @copyright 2017 Digices LLC
 * @license   https://digices.com/license/mit.txt
 **/

namespace ioscxn;

class Test extends \paqure\Object
{
  /** @property Test instance **/
  protected static $shared;

  /** @method Test getter **/
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
    $this->database = \ioscxn\Database::shared();
    $this->name = 'test';
    $this->columns = array('first','last');
    parent::__construct();
  } // ./construct

} // ./Test

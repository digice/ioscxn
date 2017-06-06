<?php

/**
  * @package   iOSCxn
  * @author    Roderic Linguri <linguri@digices.com>
  * @copyright 2017 Digices LLC
  * @license   https://digices.com/license/mit.txt
  **/

namespace ioscxn;

class App extends \paqure\Query
{

  /** @method constructor **/
  public function __construct()
  {
    parent::__construct();

    $reply = \paqure\Reply::shared();
    $reply->meta->object = $this->table;
    $reply->meta->action = $this->method;

    switch ($this->table) {
      case 'test';
        $class = \ioscxn\Test::shared();
        $method = $this->method;
        $class->$method();
        break;
      default:
        break;
    }
    
    header('Content-Type: application/json');
    echo json_encode($reply);
  
  } // ./construct

} // ./App

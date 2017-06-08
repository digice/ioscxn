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

    $parse = \paqure\Parse::shared();

    if ($api_key = $parse->post->params['api_key']) {

      if ($api_key == API_KEY) {
        switch ($this->table) {
          case 'test';
            $class = \ioscxn\Test::shared();
            $method = $this->method;
            $class->$method();
            break;
          default:
            break;
        }
      } // ./API Key match

      else {
        $reply->meta->message = 'Invalid API Key.';
      } // ./API Key mismatch

    } // ./API Key was provided

    else {
      $reply->meta->message = 'API Key is required.';
    } // ./API Key was not provided

    header('Content-Type: application/json');
    echo json_encode($reply, JSON_PRETTY_PRINT);
  
  } // ./construct

} // ./App

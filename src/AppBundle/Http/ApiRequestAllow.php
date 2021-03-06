<?php

namespace AppBundle\Http;

use Symfony\Component\Routing\Exception\MethodNotAllowedException;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;
use Symfony\Component\Routing\Matcher\UrlMatcher;
use Symfony\Component\Routing\RequestContext;
use Symfony\Component\Routing\RouteCollection;
use Symfony\Component\Routing\Route;
use Symfony\Component\HttpFoundation\Response;

use AppBundle\Util\YamlFileLoader;


/**
 * Class ApiRequestAllow
 * @package Ant\CoreBundle\Http
 */
class ApiRequestAllow extends YamlFileLoader
{

    private $allowedByRoute = array();
    private $current_route = "";

    public function isAllow($uri){
        $matcher = new UrlMatcher($this->getRouteCollection(),new RequestContext());
      try{
          $result = $matcher->match($uri);
          $this->current_route = $result["_route"];
          return $result != null;
      }catch (MethodNotAllowedException $e){
          return false;
      }catch (ResourceNotFoundException $e){
        return false;
      }

    }

    private function getRouteCollection()
    {
        $routes = new RouteCollection();
        $routesInfFile = $this->getParameters();
        $i=0;

        foreach($routesInfFile as $route2){
            $route = new Route($route2["url"]);
            $routeName = 'route_name_'.$i++;
            $this->allowedByRoute[$routeName] = $route2["fields"];

            $routes->add($routeName,$route);
        }
        return $routes;
    }

    public function splitFields($data)
    {
        $fields= $this->allowedByRoute[$this->current_route];

        $data  = json_decode($data, true);

        //convert ["username", "email"] to ["username" => "", "email" => ""] for use
        // in array_intersect_key function
        $fields = array_fill_keys($fields, "");

        /*
         * We change this function for native instruction to improve performance.
         *
         * We use array_intersect_key native function to improve them.
         *
         *   New code 0.013470480998357 sec/serialize
         *  ----------------------------------
         *   Old code 0.014336290677389 sec/serialize
         *
         */

        $data2 = array_intersect_key($data, $fields);
        $json_data = json_encode($data2);

        return $json_data;
    }
} 
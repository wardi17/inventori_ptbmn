<?php

class RestApi{

	public function model($model)
	{
		require_once '../app/models/' . $model . '.php';
		return new $model;
	}
}
<?php

class InvTransferFG extends Controller{


	public function __construct()
	{	
	
        if($_SESSION['login_user'] == '') {
			Flasher::setMessage('Login','Tidak ditemukan.','danger');
			header('location: '. base_url . '/login');
			exit;
		}
	} 
	

    public function getListtype(){
        $data= $this->model('TransTypeModel')->TampilDataType();
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }


    public function getwarehouse(){
      
        $data= $this->model('TransTypeModel')->TampilDataWarehouse();
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }


    
    public function getpartid(){
      
       
        $data= $this->model('TransTypeModel')->TampilDatapartid($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }



    public function Simpandata(){
        
        $data= $this->model('MutasiTransferModel')->SaveDatatempt($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }


    public function listdata(){
     
        $data= $this->model('MutasiTransferModel')->TampilListdata($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }
   



    
    public function Tampildata(){
       
        $data= $this->model('MutasiTransferModel')->TampildataMutasiTemp($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }


	public function UpdatedataHider(){
	$data= $this->model('MutasiTransferModel')->UpdatedataHider($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
		
	}


    public function Updatedata(){
        
        $data= $this->model('MutasiTransferModel')->UpdateDatatempt($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        }
    }
    


    public function postingsave(){
        
        $data= $this->model('MutasiTransferModel')->PostingMutasiData($_POST);
					
        if(empty($data)){
            $data = null;
            echo json_encode($data);
        }else{
            echo json_encode($data);
        } 
    }
}
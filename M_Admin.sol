contract admin {
    
	address public admin;

	function admin() public {
		admin = msg.sender;
	}

	modifier isAdmin(){
		require(msg.sender == admin) ;
		_;
	}

	function transferAdminship(address _admin) isAdmin public  {
		admin = _admin;
	}

}
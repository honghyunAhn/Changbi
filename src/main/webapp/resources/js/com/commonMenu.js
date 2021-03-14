/**
 * 화면 생성 시 메뉴 기능 제공 - jQuery 기준
 * @author 김준석(2015-06-03)
 */

function Navigation(menuList, menuLevel) {
	// 1차 메뉴 리스트
	this.menuList = menuList ? menuList : new ArrayList();
	this.menuLevel = menuLevel ? menuLevel : 0;
	
	this.currentMenu = null;
	
	this.pageName = "";
	this.subIndex = 0;
	this.url = window.location.pathname;
}

Navigation.prototype.setPageInfo = function(pageName, subIndex, url) {
	this.pageName = pageName;
	this.subIndex = subIndex ? subIndex : 0;
	this.url = url ? url : window.location.pathname;
	
	this.currentMenu = this.getMenu();
};

Navigation.prototype.getCurrentMenu = function() {
	return this.currentMenu;
};

Navigation.prototype.getMenuTitle = function() {
	var title = "";
	
	if(this.currentMenu) {
		title = this.currentMenu.getTitle(); 
	} else {
		alert("메뉴가 정상적으로 생성되지 않았습니다.");
	}
	
	return title;
};

Navigation.prototype.getMenuInfo = function(idx) {
	return this.menuList.get(idx);
};

Navigation.prototype.getPageName = function() {
	return this.pageName;
};

Navigation.prototype.getSubIndex = function() {
	return this.subIndex;
};

Navigation.prototype.setUrl = function(url) {
	this.url = url;
};

Navigation.prototype.getUrl = function() {
	return this.url;
};

Navigation.prototype.setMenuList = function(menuList) {
	this.menuList = menuList;
};

Navigation.prototype.getMenuList = function() {
	return this.menuList;
};

Navigation.prototype.addMenu = function(menu) {
	this.menuList.add(menu);
};

Navigation.prototype.getMenu = function(url) {
	var menu = null;

	if(this.pageName) {
		for(var i=0; i<this.menuList.size(); ++i) {
			var temp = this.menuList.get(i);

			// 1뎁스 메뉴
			if(temp.getPageName() == this.pageName) {
				menu = temp;
				break;
			}
		}
		
		// 1뎁스 메뉴 중 pageName이 같은 메뉴를 얻어온다.
		if(menu) {
			// 1뎁스의 서브 메뉴(2뎁스 메뉴의 사이즈 체크 - 2뎁스 메뉴가 없는 경우 나 subIndex가 큰 경우 
			if(menu.menuSize() > 0) {
				if(menu.menuSize() > this.subIndex) {
					menu.setSelectMenuIndex(this.subIndex);
					menu = this.fineMenu(menu.getMenu(this.subIndex));
				} else {
					alert("잘못 된 서브페이지를 호출 했습니다.");
					menu = null;
				}
			}
		} else {
			alert("해당 메뉴를 찾을 수 없습니다.");
		}
	} else {
		alert("setPageInfo 함수를 호출해서 page를 세팅해주세요.");
	}
	
	return menu;
};

// 2뎁스 이하의 메뉴들을 트리 구조 형태로 검색 해 나감.
Navigation.prototype.fineMenu = function(menu) {
	var fineMenu = menu;
	
	if(menu.menuSize() > 0) {
		var menuList = menu.getMenuList();
		
		for(var i=0; i<menuList.size(); ++i) {
			var temp = menuList.get(i);
				
			if(temp.menuSize() > 0) {
				fineMenu = this.fineMenu(temp);
					
				if(fineMenu) {
					temp.setSelectMenuIndex(i);
					break;
				}
			} else {
				if(temp.getUrl() == this.url) {
					fineMenu = temp;
					break;
				}
			}
		}
	}
	
	return fineMenu;
};

// 1뎁스부터 마지막 뎁스까지의 
Navigation.prototype.getMenuRoute = function() {
	var menuRoute = new ArrayList();
	var menu = null;
	
	if(this.pageName) {
		for(var i=0; i<this.menuList.size(); ++i) {
			var temp = this.menuList.get(i);
			
			if(temp.getPageName() == this.pageName) {
				menu = temp;
				break;
			}
		}
		
		if(menu) {
			this.makeMenuRoute(menuRoute, menu);
		} else {
			alert("해당 메뉴를 찾을 수 없습니다.");
		}
	} else {
		alert("setPage함수를 호출하여 pageName을 세팅해주세요!");
	}
	
	return menuRoute;
};

Navigation.prototype.makeMenuRoute = function(menuRoute, menu) {
	menuRoute.add(menu);
	
	if(menu.getSelectMenuIndex() > -1) {
		this.makeMenuRoute(menuRoute, menu.getMenu(menu.getSelectMenuIndex()));
	}
};

Navigation.prototype.menuSize = function() {
	return this.menuList.size();
};

Navigation.prototype.setLevel = function(menuLevel) {
	this.menuLevel = menuLevel;
};

Navigation.prototype.getLevel = function() {
	return this.menuLevel;
};

function Menu(pageName, title, url, menuIndex, subIndex) {
	this.pageName = pageName ? pageName : "";			// 페이지 정보 세팅 시 필요 하며 메뉴 구성 시 필요
	this.subIndex = (subIndex > -1) ? subIndex : -1;	// 2뎁스 index를 메뉴 마다 가지고 있자!! 페이지 정보 세팅 시 필요!! 1뎁스 메뉴인 경우 2뎁스 index 가 필요없으므로 subIndex는 -1로 
	this.title = title ? title : "";
	this.name = title ? title : "";
	this.url = url ? url : "";
	this.menuIndex = (menuIndex > -1) ? menuIndex : -1;	// 저장 된 메뉴가 동일 선상에서 몇번째 메뉴 index 인지 저장
	this.type = 1;										// 1 : sub, 2 : popup, 3 : layer popup
	this.addItems = new Object();						// Object 형태로 어떤 값이든 추가로 넣을 수 있다.
	this.menuList = new ArrayList();
	this.selectMenuIndex = -1;
}

Menu.prototype.setPageName = function(pageName) {
	this.pageName = pageName;
};

Menu.prototype.getPageName = function() {
	return this.pageName;
};

Menu.prototype.setSubIndex = function(subIndex) {
	this.subIndex = subIndex;
};

Menu.prototype.getSubIndex = function() {
	return this.subIndex;
};

Menu.prototype.setSelectMenuIndex = function(selectMenuIndex) {
	this.selectMenuIndex = selectMenuIndex;
};

Menu.prototype.getSelectMenuIndex = function() {
	return this.selectMenuIndex;
};

Menu.prototype.setTitle = function(title) {
	this.title = title;
};

Menu.prototype.getTitle = function() {
	return this.title;
};

Menu.prototype.setName = function(name) {
	this.name = name;
};

Menu.prototype.getName = function() {
	return this.name ? this.name : this.title;
};

Menu.prototype.setUrl = function(url) {
	this.url = url;
};

Menu.prototype.getUrl = function() {
	return this.url;
};

Menu.prototype.setMenuIndex = function(menuIndex) {
	this.menuIndex = menuIndex;
};

Menu.prototype.getMenuIndex = function() {
	return this.menuIndex;
};

Menu.prototype.setType = function(type) {
	this.type = type;
};

Menu.prototype.getType = function() {
	return this.type;
};

Menu.prototype.setMenuList = function(menuList) {
	this.menuList = menuList;
};

Menu.prototype.getMenuList = function() {
	return this.menuList;
};

Menu.prototype.addMenu = function(menu) {
	this.menuList.add(menu);
};

Menu.prototype.getMenu = function(index) {
	index = (index && index > -1) ? index : 0;
	return (this.menuList.size() > index) ? this.menuList.get(index) : null;
};

Menu.prototype.isExistMenu = function() {
	return (this.menuList.size() > 0) ? true : false;
};

Menu.prototype.menuSize = function() {
	return this.menuList.size();
};

Menu.prototype.setAddItems = function(addItems) {
	this.addItems = addItems;
};

Menu.prototype.getAddItems = function() {
	return this.addItems;
};

Menu.prototype.setAddItem = function(itemName, item) {
	this.addItems[itemName] = item;
};

Menu.prototype.getAddItem = function(itemName) {
	var result = "";
	
	if(itemName in this.addItems) {
		result = this.addItems[itemName];
	}
	
	return result;
};

Menu.prototype.isAddItem = function(itemName) {
	return itemName in this.addItems;
};
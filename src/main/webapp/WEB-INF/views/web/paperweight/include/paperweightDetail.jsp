<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- 1.2.3.1 서브-헤더 -->
<div class="sub-header">
	<h2 class="sub-title"><spring:message code='main.menu.onlinepw'/></h2>
	<h4 class="sub-detail-title"><c:out value="${selectGubun.getName(localeLanguage)}" /></h4> 
</div>

<div class="tab-group">
	<div class="section-group-header center">
		<h3 class="sr-only"></h3>
		<ul class="step-nav">
			<li class="nav on"><a href="javascript:void(0);" class="step-item openStep" data-depth="1"><span class="step-num">1<small class="pc-only"><spring:message code='text.step'/></small></span><strong class="step-name"><spring:message code='text.basicInfo'/></strong></a></li>
			<li class="nav"><a href="javascript:void(0);" class="step-item" data-depth="1"><span class="step-num">2<small class="pc-only"><spring:message code='text.step'/></small></span><strong class="step-name"><spring:message code='text.commonExam'/></strong></a></li>
			<li class="nav"><a href="javascript:void(0);" class="step-item openStep" data-depth="1"><span class="step-num">3<small class="pc-only"><spring:message code='text.step'/></small></span><strong class="step-name"><spring:message code='text.deepExam'/></strong></a></li>
			<li><a class="step-item-end" data-depth="1">END</a></li>
		</ul>
	</div> <!--//.section-group-header-->
	
	<!-- 1.2.3.2 서브-본문 Tab -->
	<div class="sub-body tab on" id="user_info">
		<form class="tab-group byStep" id='paperweightForm' name='paperweightForm' method="post">
			<input type='hidden' name='gubun.idx'	value='<c:out value="${selectGubun.idx}" />' />
			<input type='hidden' name='commonText'	value='' />
			<input type='hidden' name='examText'	value='' />
			
			<section class="tab on" id="pw_user">  
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.gender'/>/<spring:message code='text.age'/></strong>
					<select name='gender'>
						<option value='M'><spring:message code='text.male'/></option>
						<option value='F'><spring:message code='text.female'/></option>
					</select>
					<label class="inline"><input type="text" maxlength="3" name='age' placeholder="<spring:message code='text.age'/>" /></label>
				</p> 
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.name'/></strong>
					<input type="text" name='name' placeholder="<spring:message code='text.name'/>">
				</p> 
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.phone'/></strong>
					<input type="tel" name='phone' placeholder="<spring:message code='text.phone'/>">
				</p> 
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.email'/></strong>
					<input type="email" name='email' placeholder="<spring:message code='text.email'/>">
				</p> 
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.tall'/>/<spring:message code='text.kg'/></strong>
					<label class="inline"><input type="text" maxlength="5" name='tall' placeholder="<spring:message code='text.tall'/>"> cm</label>
					<label class="inline"><input type="text" maxlength="5" name='kg' placeholder="<spring:message code='text.kg'/>"> Kg</label>
				</p>
				<p class="row-group">
					<label>
						<strong class="row-group-label"><spring:message code='text.job'/></strong>
						<input type="text" size="100" name='job' placeholder="<spring:message code='text.job'/>">
					</label>
				</p>               
			</section>
		</form>
	</div><!--//.sub-body#user_info-->
	
	<!--.sub-body#pw_basic-->
	<div class="sub-body tab" id="pw_basic">
		<div class="tab-group byStep">
			<div class="section-group"></div><!--//.section-group-->
		</div>
	</div><!--//.sub-body#pw_basic-->

	<!--.sub-body#pw_deep-->
	<div class="sub-body tab" id="pw_deep">
		<div class="tab-group byStep">
			<div class="section-group"></div><!--//.section-group-->
		</div>
	</div><!--//.sub-body#pw_deep-->
	
	<div class="section-footer">
		<a href="javascript:void(0);" class="btn line step-change prev" id="prevBtn" style="display:none">◀</a>
		<a href="javascript:void(0);" class="btn impt openStep page-next" id="pageNextBtn"><spring:message code='button.next'/></a>
		<a href="javascript:void(0);" class="btn line step-change next" id="nextBtn" style="display:none">▶</a>
	</div>
	
	<!--.sub-body#tab-footer-->
	<div class="sub-body tab-footer">
		<a href="javascript:void(0);" class="float-left btn" id="pwListBtn"><spring:message code='button.list'/></a>
		<div class="jumpmenu right">
			<select id='paperweightList'>
			<c:forEach items="${gubunList}" var="gubun" varStatus="status">
				<option value='<c:out value="${gubun.idx}" />' <c:if test="${gubun.idx eq selectGubun.idx}">selected='selected'</c:if>><c:out value="${gubun.getName(localeLanguage)}" /></option>
			</c:forEach>
			</select>
			<button class="btn" style="cursor: pointer;" id="pwDetailBtn"><spring:message code='button.change'/></button>
		</div> 
	</div><!--//.sub-body#tab-footer-->
	
</div><!--.tab-group-->
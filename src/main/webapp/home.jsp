<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tm-section tm-bg-img" id="tm-section-1">
    <div class="tm-bg-white ie-container-width-fix-2">
        <div class="container ie-h-align-center-fix">
            <div class="row">
                <div class="col-xs-12 ml-auto mr-auto ie-container-width-fix">
                    <form action="index.jsp" method="get" class="tm-search-form tm-section-pad-2">
                        <div class="form-row tm-search-form-row">
					        <div class="form-group tm-form-element" style="width: 20%;">
					            <i class="fa fa-map-marker fa-2x tm-form-element-icon"></i>
					            <select name="adult" class="form-control tm-select" id="inputCity">
					                <option value="" disabled selected hidden>국가 선택</option> 
					                <option value="1">영국</option>
					                <option value="2">독일</option>
					                <option value="3">러시아</option>
					                <option value="4">미국</option>
					                <option value="5">프랑스</option>
					                <option value="6">오스트리아</option>
					                <option value="7">중국</option>
					                <option value="8">일본</option>
					                <option value="9">조선</option>
					            </select>
					        </div>
					
					        <div class="form-group tm-form-element" style="width: 20%;">
					            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
					            <input name="check-in" type="text" class="form-control" id="inputCheckIn" placeholder="시작 연도(1836~)">
					        </div>
					
					        <div class="form-group tm-form-element" style="width: 20%;">
					            <i class="fa fa-calendar fa-2x tm-form-element-icon"></i>
					            <input name="check-out" type="text" class="form-control" id="inputCheckOut" placeholder="종료 연도(~1936)">
					        </div>
					
					        <div class="form-group tm-form-element" style="width: 20%;">
					             <i class="fa fa-2x fa-user tm-form-element-icon"></i> 
					             <select name="event_type" class="form-control tm-select" id="adult"> 
					             	<option value="" disabled selected hidden>이벤트 유형</option>
					                <option value="1">분쟁</option>
					                <option value="2">전쟁</option>
					                <option value="3">조약</option>
					                <option value="4">사회</option>
					                <option value="5">문화, 기술</option>
					            </select>
					        </div>
					
					        <div class="form-group tm-form-element" style="width: 20%;">
					            <button type="submit" class="btn btn-primary tm-btn-search">검색</button>
					        </div>
					    </div>                        
                            
                            <!--<div class="form-group tm-form-element tm-form-element-2">                                            
                                <select name="children" class="form-control tm-select" id="children">
                                    <option value="">법률</option>
                                    <option value="0">농노제</option>
                                    <option value="1">간섭주의</option>
                                </select>
                                <i class="fa fa-user tm-form-element-icon tm-form-element-icon-small"></i>
                            </div>
                            <div class="form-group tm-form-element tm-form-element-2">
                                <select name="room" class="form-control tm-select" id="room">
                                    <option value="">난이도</option>
                                    <option value="1">쉬움</option>
                                    <option value="2">보통</option>
                                    <option value="3">어려움</option>
                                </select>
                                <i class="fa fa-2x fa-bed tm-form-element-icon"></i>
                            </div>-->
                            
                          
                          <div class="form-row clearfix pl-2 pr-2 tm-fx-col-xs">
                              <p class="tm-margin-b-0">원하는 국가의 역사적 이벤트를 검색해 보세요.</p>
                          </div>
                    </form>
                </div>                        
            </div>      
        </div>
    </div>                  
</div>

<div class="tm-section-2">
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h2 class="tm-section-title">Vic3 Archive에 오신 것을 환영합니다</h2>
                <p class="tm-color-white tm-section-subtitle">최신 공략과 패치 노트를 받아보세요</p>
                <a href="#" class="tm-color-white tm-btn-white-bordered">뉴스레터 구독</a>
            </div>                
        </div>
    </div>        
</div>


<div class="tm-section tm-position-relative">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" class="tm-section-down-arrow">
        <polygon fill="#ee5057" points="0,0  100,0  50,60"></polygon>                   
    </svg> 
    <div class="container tm-pt-5 tm-pb-4">
        <div class="row text-center">
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">                            
                <i class="fa tm-fa-6x fa-legal tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1">법률 & 개혁</h3>
                <p>각 국가별 최적의 법률 제정 순서와 혁명 관리법을 공유합니다.</p>
                <a href="#" class="text-uppercase tm-color-primary tm-font-semibold">자세히 보기...</a>
            </article>
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">                           
                <i class="fa tm-fa-6x fa-plane tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1">경제 & 무역</h3>
                <p>건설 부문 최적화부터 관세 설정까지, 경제 대국이 되는 비결.</p>
                <a href="#" class="text-uppercase tm-color-primary tm-font-semibold">자세히 보기...</a>             
            </article>
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">                           
                <i class="fa tm-fa-6x fa-life-saver tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1">전쟁 & 외교</h3>
                <p>악명 관리와 열강 승인, 그리고 효과적인 전선 관리 팁.</p>
                <a href="#" class="text-uppercase tm-color-primary tm-font-semibold">자세히 보기...</a>                           
            </article>
        </div>        
    </div>
</div>
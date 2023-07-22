let movieResult;

function getMovieList(apiRes) {
	if (apiRes != null) {
		movieResult = apiRes.Data[0].Result.filter(res => res.rating != "" && res.company != "" && res.genre.includes("에로") == false && res.staffs.staff.length > 4 && res.posters.split("|")[0] != "" && res.company.includes('학교') == false && res.prodYear > 1990);
	}
	return movieResult;
}

let removeSpace = (content) => content.replace(/\!HS/g, "").replace(/\!HE/g, "").replace(/^\s+|\s+$/g, "").replace(/ +/g, " ").replace(" ", "");
let checkValue = (value, keyWord) => removeSpace(value).includes(decodeURI(keyWord).replace("+", ""));
let checkAllValues = (obj, keyWord) => {
	return Object.values(obj)
		.some(value => checkValue(value, keyWord))
};

function checkMovieList(movieResult, searchWord) {
	movieTitleResult = movieResult.filter(res => checkValue(res.title, searchWord)
		|| checkValue(res.titleEng, searchWord)
	)
	
	const movieActorResult = movieResult.filter(res => res.directors.director
		.filter(obj => checkAllValues(obj, searchWord))
		.length > 0
		|| res.actors.actor
			.filter(obj => checkAllValues(obj, searchWord))
			.length > 0
	)
	movieResult = movieTitleResult.concat(movieActorResult)
	movieResult=movieResult.filter((movie, i)=> movieResult.indexOf(movie)===i)
	movieResult = editMovieObject(movieResult);
	return movieResult;
}

function checkActorList(movieResult, actorId) {

	movieResult = movieResult.filter(res => res.actors.actor
		.filter(obj => checkAllValues(obj, actorId))
		.length > 0
	)
	movieResult = editMovieObject(movieResult);
	return movieResult;
}

function checkDirectorList(apiRes, directorId,  director2Id) {

	let movieResult = apiRes;
	movieResult = movieResult.filter(res => res.directors.director
		.filter(obj => checkAllValues(obj, directorId) || (obj, director2Id))
		.length > 0
	)
	movieResult = editMovieObject(movieResult);
	showMovieList_dir(movieResult);
}

function editMovieObject(movieResult) {
	removeSpace = ((content) => content.replace(/\!HS/g, "").replace(/\!HE/g, "").replace(/^\s+|\s+$/g, "").replace(/ +/g, " "));
	movieResult = movieResult.map(obj => {
		let actors = obj.actors.actor.filter((act, i) => i < 10);
		return {
			movie_id: obj.DOCID,
			movie_title: removeSpace(obj.title),
			movie_img: obj.posters.split("|")[0],
			movie_stills: obj.stlls,
			movie_info: obj.plots.plot[0].plotText,
			movie_year: obj.prodYear,
			movie_director: obj.directors.director.map(director => removeSpace(director.directorNm) + "|" + removeSpace(director.directorId)).toString(),
			movie_actors: actors.map((actor) => removeSpace(actor.actorNm) + "|" + removeSpace(actor.actorId)).toString(),

			movie_genre: obj.genre,
			movie_rating: obj.rating,
			movie_runtime: obj.runtime,
			movie_seq: obj.movieSeq,
		}
	});
	return movieResult;
}

function showMovieList(type, movieList) {
   const moviecontainer = document.getElementById("SL_Movie_result_list");
   movieList.forEach(movie => {
      const item = document.createElement("div");
      item.classList.add("item");
      const itemWrap = document.createElement("div");
      itemWrap.classList.add("SL_Movie_result");
      item.appendChild(itemWrap);
      $(document).ready(function(){
           $.ajax({
               url: "./movie_insert",
               type: "POST",
               data: JSON.stringify(movie),
               contentType: "application/json",
               success: function(){
                   console.log('인서트완료');
               },
               error: function(request, status, error){ 
                   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
               } // 에러가 발생했을 때, 호출될 함수
           });
        });

      itemWrap.addEventListener("click", function() {
            window.location.href = "./movie_view?movie_id=" + movie.movie_id;
            
//         if (type === 'search') {
//         } else if (type === 'hash') {
//            window.location.href = "./movie_view?movie_id=" + movie.movie_id;
//         }
      });

      if (movie.movie_rating.includes('18') || movie.movie_rating.includes('관람불가')) {
         const itemRating = document.createElement("div");
         itemRating.classList.add("SL_movie_rating");
         const itemRating_mark = document.createElement("img");
         itemRating_mark.classList.add("SL_rating_mark");
         itemRating_mark.setAttribute("src", "./etc/" + movie.movie_rating + ".svg")
         itemRating.appendChild(itemRating_mark);
         itemWrap.appendChild(itemRating);
      }

      const itemImg = document.createElement("img");
      itemImg.classList.add("SL_Movie_result_img");
      itemImg.src = movie.movie_img;
      itemWrap.appendChild(itemImg);

      const itemInfo = document.createElement("div");
      itemInfo.innerText = movie.movie_title;
      itemInfo.classList.add("SL_result_list_title");
      itemWrap.appendChild(itemInfo);

      moviecontainer.appendChild(itemWrap);
   })
};


function showMovieList_dir(movieList) {
   const moviecontainer = document.getElementById("MV_contentList");
   movieList.forEach(movie => {
      const item = document.createElement("div");
      item.classList.add("MV_Movie_dirList");
      const itemWrap = document.createElement("div");
      itemWrap.classList.add("MV_MovieCard");
      item.appendChild(itemWrap);
      moviecontainer.appendChild(item);
	  
	        $(document).ready(function(){
           $.ajax({
               url: "./movie_insert",
               type: "POST",
               data: JSON.stringify(movie),
               contentType: "application/json",
               success: function(){
                   console.log('인서트완료');
               },
               error: function(request, status, error){ 
                   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) 
               } // 에러가 발생했을 때, 호출될 함수
           });
        });

      itemWrap.addEventListener("click", function() {
      
      window.location.href = "./movie_view?movie_id=" + movie.movie_id;
         
      });

      if (movie.movie_rating.includes('18') || movie.movie_rating.includes('관람불가')) {
         const itemRating = document.createElement("div");
         itemRating.classList.add("MV_movie_rating");
         const itemRating_mark = document.createElement("img");
         itemRating_mark.classList.add("MV_rating_mark");
         itemRating_mark.setAttribute("src", "./etc/" + movie.movie_rating + ".svg")
         itemRating.appendChild(itemRating_mark);
         itemWrap.appendChild(itemRating);
      }
      
      const MV_Card_inner = document.createElement("div");
      MV_Card_inner.classList.add("MV_MovieCard_inner");
      itemWrap.appendChild(MV_Card_inner);
      
      const MV_Card_front = document.createElement("div");
      MV_Card_front.classList.add("MV_MovieCard_front");
      MV_Card_inner.appendChild(MV_Card_front);
      
      const itemImg = document.createElement("img");
      itemImg.classList.add("MV_director_MovieCard_img");
      itemImg.src = movie.movie_img;
      MV_Card_front.appendChild(itemImg);
      
      const MV_Card_back = document.createElement("div");
      MV_Card_back.classList.add("MV_MovieCard_back");
      MV_Card_inner.appendChild(MV_Card_back);
      const MV_Card_back_p = document.createElement("p");
      MV_Card_back_p.innerText = movie.movie_info;
      MV_Card_back.appendChild(MV_Card_back_p);
      


      const itemInfo = document.createElement("div");
      itemInfo.innerText = movie.movie_title;
      itemInfo.classList.add("MV_result_list_title");
      item.appendChild(itemInfo);
   })
};





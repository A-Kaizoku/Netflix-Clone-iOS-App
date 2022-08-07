//
//  Movie.swift
//  Netflix Clone
//
//  Created by Mayank on 07/08/22.
//

import Foundation

struct TrendingTitleResponse:Codable{
    let results:[Title]
    
}

struct Title:Codable{
    let id:Int
    let media_type:String?
    let original_name:String?
    let original_title:String?
    let poster_path:String?
    let overview:String?
    let vote_count:Int
    let release_date:String?
    let vote_average:Double
    let first_air_date:String?
}



// Movies
/** {
adult = 0;
"backdrop_path" = "/27Mj3rFYP3xqFy7lnz17vEd8Ms.jpg";
"genre_ids" =             (
28,
53
);
id = 725201;
"media_type" = movie;
"original_language" = en;
"original_title" = "The Gray Man";
overview = "When a shadowy CIA agent uncovers damning agency secrets, he's hunted across the globe by a sociopathic rogue operative who's put a bounty on his head.";
popularity = "3002.843";
"poster_path" = "/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg";
"release_date" = "2022-07-13";
title = "The Gray Man";
video = 0;
"vote_average" = "7.012";
"vote_count" = 1249;
},
*/

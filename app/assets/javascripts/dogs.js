$(function(){
    if ($('.index.dogs').length){
        $.get('/api/dogs', function(data){

        });
    }
});

class Dog {
    constructor(id, name, breed, age, city, rating, bio){
        this.id = id;
        this.name = name;
        this.breed = breed;
        this.age = age;
        this.city = city;
        this.rating = rating;
        this.bio = bio;
    }

    linkToDogProfile(){
        return `<span class='dog-info-span dog-name-link'><a href='/dogs/${this.id}'>${this.name}</a></span>`;
    }

    dogInfoSpan(content){
        return `<span class='dog-info-span'>${content}</span>`;
    }

    dogRatingDisplay(){
        return `${this.rating}/5.0 stars!`;
    }

    createDogProfileCard(){
        let card = '<div>';
        card += this.linkToDogProfile();
        card += this.dogInfoSpan(this.breed);
        card += this.dogInfoSpan(this.city);
        card += this.dogInfoSpan(this.dogRatingDisplay());
        card += '</div>';
        return card;
    }
}
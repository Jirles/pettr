$(function(){
    $(document).on('turbolinks:load', function(){
        if ($('.index.dogs').length){
            $.get('/api/dogs', function(data){
                dogCards = $.map(data, function(dog){
                    const doggo = new Dog(dog.id, dog.name, dog.breed, dog.age, dog.city, dog.user_rating, dog.bio);
                    return doggo.createDogProfileCard();
                }).join('');
                $('#dog-profile-cards').html(dogCards);
            });
        };
        
        if ($('.show.dogs').length){
            const pageDataset = $('.show.dogs').data();
            $.get(`/api/dogs/${pageDataset.recordid}`, function(data){
                const dog = new Dog(data.id, data.name, data.breed, data.age, data.city, data.user_rating, data.bio, data.pettings);
                $('#dog-name-title').text(dog.name);
                $('#dog-city').text(dog.city);
                $('#dog-details-div').html(dog.createDogDetailsForProfile());
                $('#dog-pats-tagline').text(`${dog.name}'s Pats`);
                const pettingCards = Petting.createTrunacatedPetCardCollection(data.pettings);
                $('#dog-pettings-div').html(pettingCards);
                $('#owner-editing-options').html(dog.profileEditDeleteButtons());
            });
        };
    });
    
});

class Dog {
    constructor(id, name, breed, age, city, rating, bio, pettings = []){
        this.id = id;
        this.name = name;
        this.breed = breed;
        this.age = age;
        this.city = city;
        this.rating = rating;
        this.bio = bio;
        this.pettings = pettings;
    }

    linkToDogProfile(){
        return `<span class='dog-info-span dog-name-link'><a href='/dogs/${this.id}'>${this.name}</a></span>`;
    }

    dogInfoSpan(content){
        return `<span class='dog-info-span'>${content}</span>`;
    }

    dogProfileSpan(content){
        return `<span class='dog-profile-span'>${content}</span>`
    }

    dogRatingDisplay(){
        return `${this.rating}/5.0 stars!`;
    }

    createDogProfileCard(){
        let card = '<div>';
        card += this.linkToDogProfile();
        card += this.dogProfileSpan(this.breed);
        card += this.dogProfileSpan(this.city);
        card += this.dogProfileSpan(this.dogRatingDisplay());
        card += '</div><br><br>';
        return card;
    }

    createDogDetailsForProfile(){
        let htmlBlock = this.dogProfileSpan(this.breed);
        htmlBlock += this.dogProfileSpan(`${this.age} years old`);
        htmlBlock += this.dogProfileSpan(this.bio);
        htmlBlock += this.dogProfileSpan(this.dogRatingDisplay());
        return htmlBlock;
    }

    profileEditDeleteButtons(){
        const editButton = `<a href='/owner/dogs/${this.id}/edit'><button>Edit</button></a>`;
        const deleteButton = `<form action='/owner/dogs/${this.id}' method='post'><input type='hidden' name='authenticity_token' value='${$('meta[name="csrf-token"]').attr('content')}'><input type='hidden' name='_method' value='delete'><button type='submit'>Delete</button></form>`;
        return editButton + deleteButton;
    }
}
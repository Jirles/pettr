$('.home.pettings').ready(function(){
    $.get('/api/pettings', function(data){
        
        pettingCards = $.map(data, function(petting){
            const record = new Petting(petting.id, petting.dog_id, petting.name, petting.pet_rating, petting.description, petting.location, petting.breed, userFirstName = petting.user.first_name, userLastName = petting.user.last_name, userId = petting.user.id)
            return record.createPetCard()
        }).join('');
        $('#petting-cards-container').html(pettingCards);
    });
});

$('.show.pettings').ready(function(){

});

class Petting {
    constructor(id, dogId, name, rating, description, location, breed, userFirstName, userLastName, userId){
        this.id = id;
        this.dogId = dogId;
        this.name = name;
        this.rating = rating;
        this.description = description;
        this.location = location;
        this.breed = breed;
        this.userName = userFirstName + " " + userLastName;
        this.userId = userId;
    }

    indexRatingFormatter(){
        return `<span class='petting-info-span'>${this.rating}/5.0 would pet again</span>`;
    }

    indexPetFormatter(){
        return `<span class='petting-info-span'><a href='/users/${this.userId}'>${this.userName}</a> pet ${this.name}</span>`;
    }

    descriptionLinkFormatter(){
        return `<span class='petting-info-span petting-description-link'><a href='/pettings/${this.id}'>${this.description}</a></span>`;
    }

    createPetCard(){
        let card = '<div class="petting-card" >';
        card += this.descriptionLinkFormatter();
        card += this.indexPetFormatter();
        card += this.indexRatingFormatter();
        card += `<span class='petting-info-span'>${this.location}</span></div>`;
        return card;
    }

}

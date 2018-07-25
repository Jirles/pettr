$('.home.pettings').click(function(){
    $.get('/api/pettings', function(data){
        
      pettingCards = $.map(data, function(petting){
        const record = new Petting(petting.id, petting.dog_id, petting.name, petting.pet_rating, petting.description, petting.location, petting.breed, petting.user.first_name, petting.user.last_name, petting.user.id)
        return record.createPetCard()
      }).join('');
      $('#petting-cards-container').html(pettingCards);
    });
});

$(function(){
    const pageDataset = $('.show.pettings').data();
    $.get(`/api/pettings/${pageDataset.recordid}`, function(data){
        const record = new Petting(data.id, data.dog_id, data.name, data.pet_rating, data.description, data.location, data.breed, data.user.first_name, data.user.last_name, data.user.id)
        $('#description').text(record.description);
        $('#rating-tagline').text(`${record.rating}/5.0 would pet again`);
        $('#dog-name').text(`Doggo: ${record.name}`);
        $('#dog-breed').text(`Breed: ${record.breed}`);
        $('#link-to-user-page').html(`Pet by ${record.linkToUserPage()}`);
        $('#petting-location').text(record.location);
        $('#edit-delete-btns').html(record.setEditDeleteButtons(pageDataset.currentuserid));
    });
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

    indexRating(){
        return `${this.rating}/5.0 would pet again`;
    }

    pettingInfoSpan(content){
        return `<span class='petting-info-span'>${content}</span>`
    }

    linkToUserPage(){
        return `<a href='/users/${this.userId}'>${this.userName}</a>`
    }

    indexPetFormatter(){
        return `<span class='petting-info-span'>${this.linkToUserPage()} pet ${this.name}</span>`;
    }

    descriptionLinkFormatter(){
        return `<span class='petting-info-span petting-description-link'><a href='/pettings/${this.id}'>${this.description}</a></span>`;
    }

    createPetCard(){
        let card = '<div class="petting-card" >';
        card += this.descriptionLinkFormatter();
        card += this.indexPetFormatter();
        card += this.pettingInfoSpan(this.indexRating());
        card += this.pettingInfoSpan(this.location);
        card += '</div>'
        return card;
    }

    setEditDeleteButtons(id){
        if (this.userId === id){
            let editButton = `<a href='/pettings/${this.id}/edit'><button>Edit</button></a>`;
            let deleteButton = `<form action='/pettings/${this.id}' method='post'><input type='hidden' name='_method' value='delete'><button type='submit'>Delete</button></form>`;
            return editButton + deleteButton;
        }
    }

}

$(function(){
    $(document).on('turbolinks:load', function(){
        if ($('.home.pettings').length){
            $.get('/api/pettings', function(data){
                pettingCards = Petting.createPetCardCollectionFromJSON(data)
                $('#petting-cards-container').html(pettingCards);
              });
        };
    
        if ($('.show.pettings').length){
            const pageDataset = $('.show.pettings').data();
            $.get(`/api/pettings/${pageDataset.recordid}`, function(data){
                const record = new Petting(data.id, data.dog_id, data.name, data.pet_rating, data.description, data.location, data.breed, data.comments, data.user.first_name, data.user.last_name, data.user.id)
                $('#description').text(record.description);
                $('#rating-tagline').text(record.indexRating());
                $('#dog-name').text(`Doggo: ${record.name}`);
                $('#dog-breed').text(`Breed: ${record.breed}`);
                $('#link-to-user-page').html(`Pet by ${record.linkToUserPage()}`);
                $('#petting-location').text(record.location);
                $('#edit-delete-btns').html(record.setEditDeleteButtons(pageDataset.currentuserid));
                const comments = record.createCommentCards();
                $('#comments-collection').prepend(comments);
            });
        };
    });

    $(document).on('submit', '#comments-submission-form', function(e){
        e.preventDefault();
        const data = $('textarea').val();
        const id = $('.show.pettings').data('recordid');
        const posting = $.post(`/api/pettings/${id}/comments`, { 'petting_id': id, 'content': data });
        posting.done(function(data){
            $('#comments-collection').prepend(`<div class='comment-card'>${data.content}</div>`);
        });
    });

    $(document).on('click', '.js-expand-petting', function(e){
        const id = $(this).data('id');
        $.get(`/api/pettings/${id}`, function(data){
            const record = new Petting(data.id, data.dog_id, data.name, data.pet_rating, data.description, data.location, data.breed, data.comments, data.user.first_name, data.user.last_name, data.user.id)
            $(`#petting-card-${id}`).html(record.createExpandedPettingCard());
        });
    });

    $(document).on('click', '.js-shrink-petting', function(e){
        const id = $(this).data('id');
        $.get(`/api/pettings/${id}`, function(data){
            const record = new Petting(data.id, data.dog_id, data.name, data.pet_rating, data.description, data.location, data.breed, data.comments, data.user.first_name, data.user.last_name, data.user.id)
            $(`#petting-card-${id}`).html(record.createRegularPettingCardContent());
        });
    });
});

class Petting {
    constructor(id, dogId, name, rating, description, location, breed, comments, userFirstName, userLastName, userId){
        this.id = id;
        this.dogId = dogId;
        this.name = name;
        this.rating = rating;
        this.description = description;
        this.location = location;
        this.breed = breed;
        this.comments = comments;
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
        return this.pettingInfoSpan(`${this.linkToUserPage()} pet ${this.name}`);
    }

    descriptionLinkFormatter(){
        return `<span class='petting-info-span petting-description-link'><a href='/pettings/${this.id}'>${this.description}</a></span>`;
    }

    createExpandedPettingCard(){
        let card = this.descriptionLinkFormatter();
        card += this.pettingInfoSpan(`Doggo: ${this.name}`);
        card += this.pettingInfoSpan(`Breed: ${this.breed}`);
        card += this.pettingInfoSpan(`Pet by ${this.linkToUserPage()}`);
        card += this.pettingInfoSpan(this.location);
        card += this.pettingInfoSpan(`<em>${this.comments.length} Comments</em>`)
        card += this.pettingInfoSpan(`<button class='js-shrink-petting' data-id='${this.id}'>See Less</button>`)
        return card;
    }

    createRegularPettingCardContent(){
        let card = this.descriptionLinkFormatter();
        card += this.indexPetFormatter();
        card += this.pettingInfoSpan(this.indexRating());
        card += this.pettingInfoSpan(this.location);
        card += this.pettingInfoSpan(`<button class='js-expand-petting' data-id='${this.id}'>See More</button>`)
        return card;
    }

    createCommentCards(){
        return $.map(this.comments, function(comment){
            return `<div class='comment-card'>${comment.content}</div>`
        }).join('');
    }

    createPetCard(){
        let card = `<div class='petting-card' id="petting-card-${this.id}" data-id="${this.id}">`;
        card += this.createRegularPettingCardContent();
        card += '</div>'
        return card;
    }

    createTrunacatedPetCard(){
        let card = '<div class="petting-card">';
        card += this.descriptionLinkFormatter();
        card += this.pettingInfoSpan(this.indexRating());
        card += '</div>'
        return card;
    }

    static createPetCardCollectionFromJSON(json){
       return  $.map(json, function(petting){
            const record = new Petting(petting.id, petting.dog_id, petting.name, petting.pet_rating, petting.description, petting.location, petting.breed, petting.comments, petting.user.first_name, petting.user.last_name, petting.user.id)
            return record.createPetCard()
          }).join('');
    }

    static createTrunacatedPetCardCollection(json){
        return  $.map(json, function(petting){
            const record = new Petting(petting.id, petting.dog_id, petting.name, petting.pet_rating, petting.description, petting.location, petting.breed)
            return record.createTrunacatedPetCard()
          }).join('');
    }

    setEditDeleteButtons(id){
        if (this.userId === id){
            const editButton = `<a href='/pettings/${this.id}/edit'><button>Edit</button></a>`;
            const deleteButton = `<form action='/pettings/${this.id}' method='post'><input type='hidden' name='authenticity_token' value='${$('meta[name="csrf-token"]').attr('content')}'><input type='hidden' name='_method' value='delete'><button type='submit'>Delete</button></form>`;
            return editButton + deleteButton;
        }
    }

}

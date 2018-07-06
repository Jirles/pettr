# Pettr
- Human-Dog FourSquare site or social networking site
- keeps track of the dogs you Pet(join?), including location, and rating
- Users and Dogs have profiles
- Users can pet many dogs and dogs can be pet by many humans (Petting)
- Owner-Pet relation is also a belongs_to, has_many

## MODELS
- User - first_name, last_name, username:uniq:present, email:present, password_digest (has_one :owner_account)
- Dog - name:present, breed, age, city,  user_rating:integer, owner_id (has_one :pet_account)
	- child_friendly:boolean, cat_friendly:boolean, dog_friendly:boolean (maybe later)
- Petting - user_id, dog_id:optional, name:present, breed, location, pet_rating:integer, description
- PetAccount - dog_id, user_id

MAYBE LATER? MAYBE NOT...
- OwnerAccount - user_id, preferences (belongs_to :user) (:user has_one :user_account) (has_many :pet_accounts)
- PetAccount dog_id, user_account_id, pet_instagram, pet_bio (belongs_to :dog) (:dog has_one :pet_account) (belongs_to :owner_account)
- SocialMediaAccount

## INTERFACE & NESTED RESOURCES
- Owner module: users that own a dog and have creating/editing/deleting permissions
    - owner/4/pets/1
    - All others just have view permissions : dogs/5
- Also Pettings: you can view your pettings
    - users/4/pettings/3
- People can also view all interactions: /pettings & /pettings/3 but cannot edit/delete
- Users can only see their profile (for now)
- You can view dog profiles too if they exist dogs/3
## LATER
- Add [User Name]'s Profile link to navbar
- Validations for form submissions (including error messages)
- fix so it accepts dog_attributes=
- error pages
	- this dog no longer exists (if an owner deletes a dog's profile)
	- you can't do that (don't have permissions)

## FUTURE FUTURE
- Images
- Dog model >> Animal model
- Drop down menu for animals you manage so there's only one link in navbar
- Interactive petting form that only shows certain fields (name, breed) if a profile isn't selected
- Slide bar to register pet rating instead of radio buttons

## Specs for project
[x] has_many, belongs_to, and has_many :through
  - one join table: Petting
[x] has_many :through join table must have one user submittable attr (not just fks)
  - Petting will have location column, pet_rating, personality
[x] model validations
  - username, unique?
  - names need to be present
[x] at least one scope method (filter for dog index)
- User
    - favorite dogs: rank by rating, most recent
- Pettings
    - dog name
    - User
    - breed
    - Location
    - Has profile
[x] user authentication: signup, login, logout, passwords
  - obviously
[x] use omniauth, at least one outside source (twitter and/or fb)
  - Twitter (later), Facebook, Instagram if possible
[x] nested resources with appropriate RESTful routes
  - Dog profiles should be nested under users (pets)
[x] a form related to the parent resource^^
  - creating a pet profile  
[x] forms must display validation errors - easy
[x] DRY - easy

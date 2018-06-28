# Pettr
- Human-Dog FourSquare site or social networking site
- keeps track of the dogs you Pet(join?), including location, and rating
- Users and Dogs have profiles
- Users can pet many dogs and dogs can be pet by many humans (Petting)
- Owner-Pet relation is also a belongs_to, has_many

## MODELS
- User - first_name, last_name username:uniq:present, email, password_digest
- Dog - name:present, breed, age, city,  user_rating:integer  
	- child_friendly:boolean, cat_friendly:boolean, dog_friendly:boolean (maybe later)
- Petting - user_id, dog_id:optional, name, breed, location, pet_rating:integer, description
- OwnerPet dog_id, user_id(owner), dog_instagram, dog_bio

## INTERFACE & NESTED RESOURCES
- Owner module: users that own a dog and have creating/editing/deleting permissions
    - owner/4/pets/1
    - All others just have view permissions : dogs/5
- Also Pettings: you can view your pettings
    - users/4/pettings/3
- People can also view all interactions: /pettings & /pettings/3 but cannot edit/delete
- Users can only see their profile (for now)
- You can view dog profiles too if they exist dogs/3

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
    - favorite dogs: rank by rating
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
[x] forms must display validation errors

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    Pet.create(name: params[:owner][:pet][:name])
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_or_create_by(name: params[:pet][:name])

    binding.pry

    if !params[:pet][:owner].empty? # if the form isn't empty
      @pet.owner = Owner.create(name: params[:owner][:name]) # update the pet with what is put in the form
      @pet.save
    else # otherwise, use whichever radio button is selected
      @pet.update(owner: Owner.find(params[:pet][:owner_id]))
    end

    # radio: pet[owner_id]
    # form: pet[owner][name]

    # tester = params[:pet][:owner]
    # if tester != nil
    #   if !tester.empty? # empty?
    #     owner = Owner.create(name: params[:pet][:owner])
    #     @pet.update(owner_id: owner.id)
    #   else
    #     @pet.update(owner: Owner.find(params[:pet][:owner_id]))
    #   end
    # else
    #   if !tester.empty? # empty?
    #     owner = Owner.create(name: params[:pet][:owner])
    #     @pet.update(owner_id: owner.id)
    #   else
    #     @pet.update(owner: Owner.find(params[:pet][:owner_id]))
    #   end
    # end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

end

class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(
      object: Faker::Book.title,
      body: Faker::Lorem.sentence(word_count = 4, supplemental = false, random_words_to_add = 6),
      read: false
    )
    if @email.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js { }
        flash[:notice] = "Email crée"
      end
    else
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js { }
        flash[:notice] = "Please try again"
      end
    end
  end

  def show
    @email=Email.find(params[:id])

    @email.update(read: true) # passe l'email au status "lu"

    respond_to do |format|
      format.html {redirect_to email_path(@email.id)}
      format.js { }
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js { }
    end
  end
  
  def update
    @email = Email.find(params[:id])
    
    #@email.update(read: !@email.read) # Change le status de l'email "lu/non lu"
    @email.toggle(:read).save # Change le status de l'email "lu/non lu"

    puts "*"*20 + "passage dans update"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end

end

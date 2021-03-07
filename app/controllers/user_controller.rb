
class UserController < ApplicationController
    
    get '/signup' do
        if logged_in?
            redirect :'/profile'
        end
        erb :'/user/signup'
    end

    post '/signup' do
        if logged_in?
            redirect :'/profile'
        end

        if params[:username].empty? || params[:password].empty?
            redirect :'user/signup'
        else 
            @user = User.create(params)
            session[:user_id] = @user.id

            redirect :'/profile'
        end
    end

    get '/login' do
        if logged_in?
            redirect :'/profile'
        end
        erb :'user/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect :'/profile'
        else 
            erb :'/users/login'
        end
    end 

    get '/profile' do
        if logged_in?
            @user = current_user
            
            erb :'/user/show'
            
        else
            redirect :'/login'
        end
    end

    get '/users/:id' do
        if logged_in? && params[:id] == session[:user_id]
            redirect :'/profile'
        else
            


    get '/logout' do
        session.clear
        erb :index
    end
end
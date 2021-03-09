
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
        elsif User.find_by(username: params[:username])
            redirect :'/signup'
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
            erb :'/user/login'
        end
    end 

    get '/profile' do
        if logged_in?
            @user = current_user
            
            erb :'/user/profile'
            
        else
            redirect :'/login'
        end
    end

    get '/users' do
        @users = User.all
        erb :'/user/index'
    end

    get '/users/:id' do
        if profile?
            redirect :'/profile'
        else
            @user = User.find_by(id: params[:id])
            erb :'/user/show'
            
        end
    end



    get '/logout' do
        session.clear
        erb :index
    end

end
class WorkoutController < ApplicationController
    
    get '/new_workout' do
        erb :'/workout/new'
    end

    post '/new_workout' do
        if logged_in?
            if params[:name].empty? || params[:description].empty? || params[:length].empty?
                erb :'/workout/new'
            end
            workout = Workout.create(params)
            user = current_user
            user.workouts << workout
            redirect :"/workouts/#{workout.id}"
        else
            redirect :'/login'
        end
    end

    get '/workouts/:id' do
        redirect_if_not_logged_in
        set_workout
        if !@workout
            redirect :'/users'
        end
        @owner = User.find_by(id: @workout[:user_id])
        
        erb :'workout/show'
    end

    get '/workouts/:id/edit' do
        redirect_if_not_logged_in

        set_workout
        if !owner?
            redirect :'/workouts/:id'
        end
        erb :'workout/edit'
    end

    patch '/workouts/:id' do
        redirect_if_not_logged_in
        set_workout
        if !owner?
            redirect :'/workout/:id'
        end
        @workout.update(params[:workout])
        @owner = User.find_by(id: @workout[:user_id])
        erb :'/workout/show'
    end

    delete '/workouts/:id' do
        redirect_if_not_logged_in
        set_workout
        if !owner?
            redirect :'/workout/:id'
        end
        @workout.delete
        redirect :'/profile'
    end


end
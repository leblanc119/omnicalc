class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    @sum=0

    @text2=@text.gsub(/[^a-z0-9\s]/i, "")
    @word=@special_word.gsub(/[^a-z0-9\s]/i, "")

    @text2.split.each do |special_count|
      if @word.upcase == special_count.upcase
        @sum=@sum+1
      end
    end

    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @occurrences = @sum

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    monthly_rate=(@apr/100)/12
    num_payments=@years*12
    @monthly_payment = ((monthly_rate)/(1-(1+monthly_rate)**(num_payments*-1)))*@principal

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    #@sorted_array=[]
    #@temp_array=@numbers

    #@temp_array.each do |next_num|
    #  @sorted_array.push(@temp_array.min)
    #  @temp_array=@temp_array-[@temp_array.min]
    #end

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    if @numbers.count.even?
      @index=@numbers.count/2
      @median=(@numbers.sort[@index]+@numbers.sort[@index-1])/2
    else
      @index=@numbers.count/2
      @median=@numbers.sort[@index]
    end

    @median = @median

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.count

    @var_sum=0
    @numbers.each do |diff|
      @var_sum=@var_sum+(@mean-diff)**2
    end
    @variance=@var_sum/@numbers.count

    @variance = @variance

    @standard_deviation = @variance**(1.0/2)

    @mode = @numbers#.mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

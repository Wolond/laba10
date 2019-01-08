class XmlController < ApplicationController
  before_action :parse_params, only: :index
  def index
    arr = root(@num)
    data = if arr == 'error'
             { message: "Введены неверные данные"}
           else
             arr.map { |elem| { elem: elem } }
           end
    respond_to do |format|
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end

  protected

  def parse_params
    @num = params[:num]
  end
end

def root(num)
  if num.to_i.positive?
    num = num.to_i
    nach = 10**(num - 1)
    konech = 10**(num) - 1
    kolv=0
    s=0
    sum=0
    arr = []
    while (nach <= konech) do #идем по диапозону числе от начального к конечному
        i = nach
        p i
      while i > 0 do #тут с помощью цикла будем выяснять удволтеворяет ли число условию
        s = (i % 10).to_i 
        sum = sum + s**(num)
        p sum
        i = i.div 10
        p i
      end
      if (sum==nach)
        arr.push(sum)  #добавление числа в массив
        kolv=kolv+1 
      end
      nach=nach+1
      sum = 0
    end
    if arr.empty?
        arr.push("В данном диапозоне чисел армстронга нет")
        kolv = 0
    end
  else
    arr = 'error'
  end
  arr
end

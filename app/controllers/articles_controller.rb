class ArticlesController < ApplicationController #Контроллер

	#Контроль над доступом к экшинам
	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	#Здесь должны размещытся экшины. Они предназначены для сбора информации и передачи ее во вьюху
	#Для просмотра всех требуемых экшинов в комендной строке вызывается команда: "rails routes"
	#Желательный порядок всех экшенов в описании данного модуля: index, show, new, edit, create, update, destroy
	#Все экши  должны быть помещены перед любыми private или protected методами в контроллере, чтобы они заработали

	def index	#для вывода списка всех статей
		@articles = Article.all
	end

	def show	#для вывода (показа) статьи
		@article = Article.find(params[:id]) #@name - переменная экземпляра, Name - клас
	end

	def new		#для создания новой статьи
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create	#для сохранения статьи
		#render plain: params[:article].inspect
		#@article = Article.new(params.require(:article).permit(:title, :text))
		@article = Article.new(article_params) #Создается приватный метод для многократного обращения

		#@article.save
		#redirect_to @article

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	#Составляем белый список параметров, которые мы хотим разрешить и затребовать для корректного использогвания
	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end

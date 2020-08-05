class Api::V1::FaqsController < ApplicationController
    def index
        faqs = Faq.all.order(created_at: :desc)
        render json: faqs
    end

    def create
        faq = Faq.create!(faq_params)
        if faq
            render json: faq
        else
            render json: faq.errors
        end
    end

    def update
        faq = Faq.find(params[:id])
        if faq.update(faq_params)
            render json: {faq: faq, message: 'faq is updated', status: 1}
        else
            render json: {message: 'faq updated failed', status: 0}
        end
    end

    def destroy
        faq = Faq.find(params[:id])
        faq&.destroy
        render json: {faq: faq, message: 'FAQ deleted'}
    end

    private
    def faq_params
        params.permit(:question, :answer)
    end
end

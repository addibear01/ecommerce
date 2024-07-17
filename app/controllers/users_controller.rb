def user_params
  params.require(:user).permit(:email, :password, :password_confirmation,
                               :province_id,
                               addresses_attributes: [:id, :street, :city, :province_id, :postal_code])
end

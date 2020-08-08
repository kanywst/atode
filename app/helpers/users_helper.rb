module UsersHelper

    # 渡されたユーザーのGravatar画像を返す
    def gravatar_for(object, options = { size: 80 })
      gravatar_id = Digest::MD5::hexdigest(SecureRandom.hex(8))
      size = options[:size]
      gravatar_url = object.image? ? object.image.thumb.url : "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: object.name, class: "gravatar")
    end
  end
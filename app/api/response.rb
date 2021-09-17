module Response
  def themes_response(themes)
    array = []
    themes = themes.sort{|a,b| b["created_at"] <=> a["created_at"]}
    for theme in themes
      hash_theme = theme_response(theme)
      array.push(hash_theme)
    end
    return array
  end

  def theme_response(theme)
    hash_theme = theme.attributes
    hash_theme.delete("image")
    hash_theme[:image] = theme.image
    # owner hash の作成
    owner = User.find_by(id: theme.owner_id)
    hash_theme[:owner_user] = owner.attributes
    hash_theme[:owner_user].delete("profile_path")
    hash_theme[:owner_user][:profile_path] = owner.profile_path


    # invited hash list の作成
    invited_user_themes = InvitedUserTheme.where(theme_id: theme.id, joined: false)
    array_invited = []

    for invited_user_theme in invited_user_themes
      invited_user = User.where(id: invited_user_theme.user_id)[0]
      invited_hash = invited_user.attributes
      invited_hash.delete("profile_path")
      invited_hash[:profile_path] = invited_user.profile_path
      invited_hash[:smiles] = smiles_response(Smile.where(user_id: invited_user.id))
      invited_hash[:inviter_users] = []

#         invitation = Invitation.where(theme_id: theme.id, invited_id: invited_user.id)[0]
#         if invitation
#           inviter_users = User.where(id: invitation.inviter_id)
#           array_inviter = []
#           for inviter_user in inviter_users
#             inviter_hash = inviter_user.attributes
#             inviter_hash[:smiles] = Smile.where(user_id: inviter_user.id)
#             array_inviter.push(inviter_hash)
#           end
#           invited_hash[:inviter_users] = array_inviter
#         end

      array_invited.push(invited_hash)
    end
    hash_theme[:invited_users] = array_invited

    joining_user_themes = JoiningUserTheme.where(theme_id: theme.id)
    array_joining = []
    for joining_user_theme in joining_user_themes
      joining_user = User.where(id: joining_user_theme.user_id)[0]
      joining_hash = joining_user.attributes
      joining_hash.delete("profile_path")
      joining_hash[:profile_path] = joining_user.profile_path
      array_joining.push(joining_hash)
    end
    hash_theme[:joining_users] = array_joining

    smile_themes = SmileTheme.where(theme_id: theme.id).sort{|a,b| b["created_at"] <=> a["created_at"]}
    array_smiles = []
    for smile_theme in smile_themes
      smile = Smile.where(id: smile_theme.smile_id)[0]
      array_smiles.push(smile_response(smile))
    end
    hash_theme[:smiles] = array_smiles

    return hash_theme
  end

  def smiles_response(smiles)
    array = []
    smiles = smiles.sort{|a,b| b["created_at"] <=> a["created_at"]}
    for smile in smiles
      hash_smile = smile_response(smile)
      array.push(hash_smile)
    end
    return array
  end

  def smile_response(smile)
    smile_hash = smile.attributes
    smile_hash.delete("pic_path")
    smile_hash.delete("back_pic_path")
    smile_hash[:pic_path] = smile.pic_path
    smile_hash[:back_pic_path] = smile.back_pic_path

    user = User.find_by(id: smile.user_id)
    smile_hash[:user] = user.attributes
    smile_hash[:user].delete("profile_path")
    smile_hash[:user][:profile_path] = user.profile_path
    smile_comments = smile.comments
    array_hash = []
    for smile_comment in smile_comments
      hash = smile_comment.attributes
      user = User.find_by(id: smile_comment.user_id)
      hash[:user] = user.attributes
      hash[:user].delete("profile_path")
      hash[:user][:profile_path] = user.profile_path

      array_hash.push(hash)
    end
    smile_hash[:comments] = array_hash
    smile_hash[:othersmiles] = smile.othersmiles

    return smile_hash
  end
end
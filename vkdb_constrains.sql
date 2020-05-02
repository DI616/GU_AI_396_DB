USE vk;

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id) ON DELETE SET NULL; 

ALTER TABLE friendship 
  ADD CONSTRAINT frienship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  ADD CONSTRAINT frienship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE,
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id) ON DELETE NO ACTION;
   
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE NO ACTION;
    
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT communities_users_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id);
    
ALTER TABLE publications 
  ADD CONSTRAINT publication_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT publication_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id);
    
ALTER TABLE media 
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id);
    
ALTER TABLE publications 
  ADD CONSTRAINT publications_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT publications_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id);
    
ALTER TABLE publications_media
  ADD CONSTRAINT publications_media_publication_id_fk
    FOREIGN KEY (publication_id) REFERENCES publications(id),
  ADD CONSTRAINT publications_media_media_id_fk
    FOREIGN KEY (media_id) REFERENCES media(id);
    
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_types_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);
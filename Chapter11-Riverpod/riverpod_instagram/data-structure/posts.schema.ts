type PostsSchema = {
  /**
   * owner of a post
   */
  uid: string;
  /**
   * date time when a post created
   */
  created_at: string;
  /**
   * Same as Firebase Storage's file name, it's unique
   */
  file_name: string;
  /**
   * file type of app's media file, we only have video and image two types in our app
   */
  file_type: FileType;
  /**
   * url string to file
   */
  file_url: string;
  /**
   * message for post
   */
  message: string;
  /**
   * file id in Firebase Storage
   */
  original_file_storage_id: string;
  /**
   * post settings
   */
  post_settings: PostSettings;
  /**
   * thumbnail storage id, this's a preview of post's file
   */
  thumbnial_storage_id: string;
  /**
   * thumbnail storage http url, this's a preview of post's file
   */
  thumbnial_url: string;
};

/**
 * Only image and video types are available for our app
 */
type FileType = "image" | "video";

type PostSettings = {
  /**
   * whether allow other users to comment the post, we should won't show
   * comment action in UI
   */
  allow_comments: boolean;
  /**
   * whether allow other users to like the post, we should won't show like
   * action in UI
   */
  allow_likes: boolean;
};

export default PostsSchema;

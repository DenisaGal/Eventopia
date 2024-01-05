namespace EventopiaAPI.DB
{
    public class User
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email_address { get; set; }
        public string password { get; set; }
        public int location {  get; set; }
        public int preferences {  get; set; }
        public bool type { get; set; }

        public User()
        {
            

        }
    }
}
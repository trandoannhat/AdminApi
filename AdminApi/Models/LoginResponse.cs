namespace AdminApi.Models
{
    public class LoginResponse
    {
        public string AccessToken { get; set; } = null!;
        public string Role { get; set; } = null!;
    }
}

using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Services;

namespace TranscriptSubscriptionSample.Controllers
{
    /// <summary>
    /// This controller manages home page of the web application.
    /// </summary>
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger, IAuthService authService)
        {
            _logger = logger;
            var token = authService.GetAccessTokenAsync().Result;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

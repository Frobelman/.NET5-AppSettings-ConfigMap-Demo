using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NET5_AppSettings_ConfigMap_Demo.Controllers
{
    [Route("api/settings")]
    [ApiController]
    public class AppSettingsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public AppSettingsController(IConfiguration config)
        {
            _configuration = config;
        }

        [HttpGet]
        public IActionResult GetConfigurationSettings()
        {
            return Ok(_configuration.GetSection("AppConfiguration").GetChildren());
        }
    }
}

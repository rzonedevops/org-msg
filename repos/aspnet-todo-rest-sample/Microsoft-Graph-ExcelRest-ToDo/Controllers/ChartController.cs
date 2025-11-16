//Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
//See LICENSE in the project root for license information.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Threading.Tasks;
using Microsoft_Graph_ExcelRest_ToDo.TokenStorage;
using Microsoft_Graph_ExcelRest_ToDo.Helpers;
using System.Configuration;

namespace Microsoft_Graph_ExcelRest_ToDo.Controllers
{
    public class ChartController : Controller
    {
        public async Task<FileResult> GetChart()
        {
            string userObjId = System.Security.Claims.ClaimsPrincipal.Current.FindFirst("http://schemas.microsoft.com/identity/claims/objectidentifier").Value;
            SessionTokenCache tokenCache = new SessionTokenCache(userObjId, HttpContext);

            string accessToken = await SampleAuthProvider.Instance.GetUserAccessTokenAsync();


            return await ExcelApiHelper.getChartImage(accessToken);
        }
    }
}

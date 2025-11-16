using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.Extensions.Options;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.UI;
using TranscriptSubscriptionSample.Configurations;
using TranscriptSubscriptionSample.Handlers;
using TranscriptSubscriptionSample.Logging;
using TranscriptSubscriptionSample.Services;
using TranscriptSubscriptionSample.Utilities;

var builder = WebApplication.CreateBuilder(args);

var userScopes = builder.Configuration.GetValue<List<string>>("GraphConfigurations:UserScopes");

// Add Azure AD authentication with token acquisition
builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
    .AddMicrosoftIdentityWebApp(options =>
        {
            builder.Configuration.GetSection("AzureAd").Bind(options);
            builder.Configuration.GetSection("GraphConfigurations").Bind(options);

            var certThumbprint = builder.Configuration.GetValue<string>("GraphConfigurations:CertificateThumbprint");
            options.ClientCertificates = new List<CertificateDescription>()
            {
                CertificateDescription.FromCertificate(CertificateLoader.LoadFromCertificateStore(certThumbprint))
            };
        }
    )
    .EnableTokenAcquisitionToCallDownstreamApi(userScopes)
    .AddInMemoryTokenCaches(); // Or .AddDistributedTokenCaches() for production

// Add this before building the app
builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders =
        ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedHost | ForwardedHeaders.XForwardedProto;
    options.KnownNetworks.Clear();  // allow all
    options.KnownProxies.Clear();
});

// Register token service
builder.Services.AddScoped<IUserTokenService, UserTokenService>();

// Add HttpContextAccessor
builder.Services.AddHttpContextAccessor();


// Add authorization
builder.Services.AddAuthorization(options =>
{
    // Configure authorization policies if needed
    options.AddPolicy("RequireAuthenticatedUser", policy =>
    {
        policy.RequireAuthenticatedUser();
    });
});

// Add services to the container
builder.Services.AddRazorPages(options =>
{
    // Require authentication for all pages by default
    options.Conventions.AuthorizeFolder("/");
    // Allow anonymous access to specific pages
    options.Conventions.AllowAnonymousToPage("/Index");
    options.Conventions.AllowAnonymousToPage("/Privacy");
    options.Conventions.AllowAnonymousToFolder("/Account");
})
.AddMicrosoftIdentityUI(); // Add Microsoft Identity UI for login/logout

builder.Services.AddControllersWithViews()
    .AddMicrosoftIdentityUI();

// Configure GraphConfigurations from appsettings.json
builder.Services.Configure<GraphConfigurations>(
    builder.Configuration.GetSection("GraphConfigurations"));

// Register the delegating handler
builder.Services.AddTransient<AuthenticationDelegatingHandler>();

// Register AuthService
builder.Services.AddSingleton<IAuthService, AuthService>();

// Register SubscriptionHandlerFactory
builder.Services.AddSingleton<ISubscriptionHandlerFactory, SubscriptionHandlerFactory>();

// Register HttpClient with named client
builder.Services.AddHttpClient("GraphClient", (serviceProvider, client) =>
{
    var graphConfig = serviceProvider.GetRequiredService<IOptions<GraphConfigurations>>().Value;
    client.BaseAddress = new Uri(graphConfig.GraphEndpoint);
}).AddHttpMessageHandler<AuthenticationDelegatingHandler>();

// Register GraphService
builder.Services.AddSingleton<IGraphService, GraphService>();

// Register SubscriptionService
builder.Services.AddSingleton<ISubscriptionsService, SubscriptionService>();

// Register NotificationProcessor
builder.Services.AddSingleton<INotificationProcessor, NotificationProcessor>();

// Configure logging
builder.Services.AddSingleton<ILogStore>(new InMemoryLogStore(maxLogsCount: 10000));

builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

// Add custom in-memory logger
builder.Services.AddSingleton<ILoggerProvider, InMemoryLoggerProvider>();
builder.Logging.AddProvider(builder.Services.BuildServiceProvider().GetService<ILoggerProvider>());

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// Enable forwarded headers
app.UseForwardedHeaders();

// Add authentication and authorization middleware (order matters!)
app.UseAuthentication();
app.UseAuthorization();

// Add Razor Pages mapping (required for Microsoft Identity UI)
app.MapRazorPages();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

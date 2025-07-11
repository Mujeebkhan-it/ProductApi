using Microsoft.EntityFrameworkCore;
using ProductApi.Data;

// ✅ First create the builder
var builder = WebApplication.CreateBuilder(args);

// ✅ Then configure it to listen on all IPs
builder.WebHost.UseUrls("http://0.0.0.0:5207");

// Add services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Register DbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.UseAuthorization();

app.MapControllers();

app.Run();

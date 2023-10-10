using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});
// Add services to the container.   
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();
builder.Services.AddTransient<IDanhMucRepository, DanhMucRepository>();
builder.Services.AddTransient<IDanhMucBusiness, DanhMucBusiness>();
builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
builder.Services.AddTransient<ISanPhamBusiness, SanPhamBusiness>();
builder.Services.AddTransient<ITinTucRepository, TinTucRepository>();
builder.Services.AddTransient<ITinTucBussiness, TinTucBussiness>();

// configure strongly typed settings objects
IConfiguration configuration = builder.Configuration;
var appSettingsSection = configuration.GetSection("AppSettings");
builder.Services.Configure<AppSettings>(appSettingsSection);


// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var app = builder.Build();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseRouting();
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();
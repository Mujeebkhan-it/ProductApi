# Use official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy everything and build
COPY . . 
RUN dotnet publish -c Release -o out

# Use a smaller runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app
COPY --from=build /app/out .

# Expose port 8080 (Render expects this)
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "ProductApi.dll"]

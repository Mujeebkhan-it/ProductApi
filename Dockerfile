# 🌐 Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set working directory inside container
WORKDIR /app

# Copy all project files
COPY . .

# Build and publish the app to /out directory
RUN dotnet publish -c Release -o out

# 🧱 Stage 2: Run the app using a smaller runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set working directory again
WORKDIR /app

# Copy published output from build stage
COPY --from=build /app/out .

# ✅ Tell Docker to expose this port to Render
EXPOSE 8080

# ✅ Start the app
ENTRYPOINT ["dotnet", "ProductApi.dll"]

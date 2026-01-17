# ===== BUILD =====
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj và restore trước để tận dụng cache
COPY ["AdminApi/AdminApi.csproj", "AdminApi/"]
RUN dotnet restore "AdminApi/AdminApi.csproj"

# Copy toàn bộ và build
COPY . .
WORKDIR "/src/AdminApi"
RUN dotnet publish -c Release -o /app/publish

# ===== RUNTIME =====
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Thống nhất chạy cổng 5000
ENV ASPNETCORE_URLS=http://0.0.0.0:5000
COPY --from=build /app/publish .

EXPOSE 5000
ENTRYPOINT ["dotnet", "AdminApi.dll"]
# ===== BUILD =====
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY AdminApi/AdminApi.csproj AdminApi/
RUN dotnet restore AdminApi/AdminApi.csproj

COPY . .
WORKDIR /src/AdminApi
RUN dotnet publish -c Release -o /app/publish

# ===== RUNTIME =====
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

ENV ASPNETCORE_URLS=http://0.0.0.0:5000

COPY --from=build /app/publish .

EXPOSE 5000
ENTRYPOINT ["dotnet", "AdminApi.dll"]

# =========================
# Build
# =========================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY . .

RUN dotnet restore "polypus/Polypus.Web/Polypus.Web.csproj"

RUN dotnet publish "polypus/Polypus.Web/Polypus.Web.csproj" \
    -c Release \
    -o /app/publish \
    --no-restore


# =========================
# Run
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

ENTRYPOINT ["dotnet", "Polypus.Web.dll"]
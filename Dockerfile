FROM mcr.microsoft.com/dotnet/sdk:6.0-cbl-mariner2.0 AS build
WORKDIR /app

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:6.0-cbl-mariner2.0-distroless-amd64 AS base
WORKDIR /app
EXPOSE 80
# EXPOSE 443
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "cbl-mariner.dll"]


# docker build -t distroless-demo -f .\Dockerfile .
# docker run --rm -it -p 8080:80 distroless-demo
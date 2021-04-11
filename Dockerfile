FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS base 

ENV ASPNETCORE_URLS http://+:83
EXPOSE 83

# Set TimeZone
ENV TZ America/New_York

FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build 
WORKDIR /src
COPY NET5-AppSettings-ConfigMap-Demo.csproj OrderStatusAPI/
RUN dotnet restore NET5-AppSettings-ConfigMap-Demo/NET5-AppSettings-ConfigMap-Demo.csproj --source https://api.nuget.org/v3/index.json
WORKDIR /src/NET5-AppSettings-ConfigMap-Demo
COPY . .
RUN dotnet build NET5-AppSettings-ConfigMap-Demo.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish NET5-AppSettings-ConfigMap-Demo.csproj -c Release -o /app


FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "NET5-AppSettings-ConfigMap-Demo.dll"]
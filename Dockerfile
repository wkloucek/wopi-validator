FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build

# TODO: check how to do this
# renovate: datasource=git-refs depName=microsoft/wopi-validator-core
ENV WOPI_VALIDATOR="4c995a0d8c32ed5f55cac1dd3209d2450e12725c"

WORKDIR /
ADD https://github.com/microsoft/wopi-validator-core/archive/$WOPI_VALIDATOR.tar.gz /wopi-validator-core.tar.gz
RUN tar xvfz wopi-validator-core.tar.gz --directory /
RUN mv /wopi-validator-core-$WOPI_VALIDATOR /app

WORKDIR /app/
RUN dotnet build -c Release
RUN find /app/src/WopiValidator/bin/Release


FROM mcr.microsoft.com/dotnet/runtime:6.0-alpine

WORKDIR /app/
COPY --from=build /app/src/WopiValidator/bin/Release/net6.0 /app

ENTRYPOINT [ "/app/Microsoft.Office.WopiValidator"]

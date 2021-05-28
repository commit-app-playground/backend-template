<%- if eq (index .Params `language`) "python" %>
FROM python:3.7-alpine

RUN mkdir /app
WORKDIR /app
ADD . /app/
RUN pip install -r requirements.txt

EXPOSE 80
CMD ["python", "/app/main.py"]
<%- else if eq (index .Params `language`) "nodejs" %>
FROM node:14-alpine

RUN mkdir /app
WORKDIR /app
ADD . /app/
RUN npm install --no-optional --production

CMD ["npm", "start"]
<%- else if eq (index .Params `language`) "golang" %>
FROM golang:1.13.7-alpine3.11 as builder
WORKDIR /app
COPY . .
RUN go build -o <% .Name %> main.go

FROM alpine:3.11
RUN apk add --update bash ca-certificates
WORKDIR /app
COPY --from=builder /app/<% .Name %> .

ENTRYPOINT ["/app/<% .Name %>"]
<% end %>

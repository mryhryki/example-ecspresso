import { Server, Handler } from "https://deno.land/std@0.138.0/http/server.ts";
import { version } from "./version.ts";

const PORT = 80;

const handler: Handler = async (request) => {
  console.log("Request:", request.method, request.url);
  const { pathname, search } = new URL(request.url);

  if (request.method === "GET") {
    const data = JSON.stringify({ version, pathname, search });
    console.log("Request Data:", data);
    return new Response(data, {
      headers: { "Content-Type": "application/json" },
    });
  }

  return new Response("Not Found", { status: 404 });
};

console.log(`Listening on http://localhost:${PORT}/`);
const listener = Deno.listen({ port: PORT });
const server = new Server({ handler });
await server.serve(listener);

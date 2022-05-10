import { Handler, Server } from "https://deno.land/std@0.138.0/http/server.ts";
import { version } from "./version.ts";

const PORT = 80;

const handler: Handler = (request) => {
  try {
    const uuid = crypto.randomUUID();
    console.log("Request:", request.method, request.url, uuid);
    const { pathname, search } = new URL(request.url);

    if (request.method === "GET") {
      const data = JSON.stringify({ uuid, version, pathname, search }, null, 2);
      console.log("Request Data:", data);
      return new Response(data, {
        headers: { "Content-Type": "application/json" },
      });
    }

    return new Response("Not Found", { status: 404 });
  } catch (err) {
    return new Response(`Internal Server Error: ${err.message}`, {
      status: 500,
      headers: {
        "Content-Type": "text/plain;charset=utf-8",
      },
    });
  }
};

console.log(`Listening on http://localhost:${PORT}/`);
const listener = Deno.listen({ port: PORT });
const server = new Server({ handler });
await server.serve(listener);

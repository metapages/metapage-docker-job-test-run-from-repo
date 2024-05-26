console.log("I am a main.ts file")
console.log("Env vars: " + JSON.stringify(Deno.env.toObject(), null, 2));
console.log("Commit hash: " + Deno.readTextFileSync("/app/commit_hash.txt"));
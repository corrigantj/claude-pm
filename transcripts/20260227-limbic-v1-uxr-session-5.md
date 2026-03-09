20260227 Limbic v1 UXR - Session 5 - February 27
VIEW RECORDING - 46 mins (No highlights): https://fathom.video/share/9kkqsx-zfyaw61XsTxDYYsxH_pRSsqWs

---

0:01 - Derek Perez
  All right, back on the record, session two of this architectural product strategy study. I was thinking about your point about like, where does this live?  And it occurs to me that the most natural place for this to live is actually in the ADRs. Oh, interesting.
  ACTION ITEM: Draft module versioning scheme ADR; share w/ Travis - WATCH: https://fathom.video/share/9kkqsx-zfyaw61XsTxDYYsxH_pRSsqWs?timestamp=27.9999  And so there's, that's what this kind of is, an architectural decision, right, that we're recording. And so this would be a good use for that.  And another one that we're going to need to come up with fairly quickly after this, if it doesn't come up in this session with Claude, is a module versioning scheme.  Specifically because now there's all these sub-modules, there's sub-components that exist, like config, server, CLI, all these things. There needs to be some kind of compatibility rubric to express like the major numbers always have to match or like the minor and major numbers have to match and the patch number indicates something, right?  So I don't think that it will necessarily perfectly match like say an industry standard is like semantic versioning as a rule set.  I don't think we'll do that. I think it'll be more like, you know, all of the, all the components have to line up on one of those point axes.  And another one will be like an incrementer of if it's a breaking change or a non-breaking change. And then another one will be just like an incrementer of progress in that particular module.  We did something like this at the protobuf team for the cross op, the cross language version numbers needed to line up in a similar way with like the runtime versus the compiler.  So I think it's going to look similar to that. But I expect that'll be something that we would have as an ADR and we would say, okay, how do we version the components?  That's an architectural decision. We're going to keep following that in perpetuity. We don't keep redefining that. Right, right.

2:11 - Travis Corrigan (matterflowadvisors.com)
  Okay, got it. Yeah. So even though this is V1, because we're making a bunch of architectural decisions, it's going to be in an ADR, you think?  Yeah, probably.

2:30 - Derek Perez
  Yeah, because like an ADR is just a statement of decision. Yeah, okay. You know what I mean? Like, it's really just a decision log.  Yeah, okay. And even the V1-ness of it. Now, when you say that, what are you versioning?

2:45 - Travis Corrigan (matterflowadvisors.com)
  Oh, I'm like, what? I'm thinking about this is step zero for a new project, right?

2:56 - Derek Perez
  Mm-hmm, mm-hmm.-hmm. Mm You

3:01 - Travis Corrigan (matterflowadvisors.com)
  What artifact gets updated with this content? I think that would be an ADR.

3:08 - Derek Perez
  Okay. I would propose we could store this, basically this converse, this design conversation we're having collaboratively between you, me, and Claude, that would be recorded as an ADR.  This is the conversation we had, this were the decisions we made. Yeah, okay. And then that could be, we could feed that into the PRD process.  Yeah, okay. To be like, great, so this was the decisions that we made, now how do we do it?  Yeah. And that may be the perfect amalgamation of components, because the ADRs kind of exist, as I've said before, they exist kind of in like a temporal sense.  They're not tied necessarily to a PRD or whatever. They can inform a PRD, the PRDs can be pointers into decisions we've made in time, and that's kind of the, I think the premise of the ADRs are to be like, we're making architectural decisions.  Right. So all the final R is just record or record. Right. Yeah. And so I think that's honestly, the more I thought about it, like we kind of had a place for this.  Yeah. Okay, cool.

4:13 - Travis Corrigan (matterflowadvisors.com)
  Love it. Yeah. And then, yeah.

4:14 - Derek Perez
  And that's why the versioning thing I think would be another. So like ADR one is how does Hadron even look?  And then ADR two is probably like, how do we version changes to it? Yeah. Okay. And then ADR three would be probably as we start to do more of these deeper North Star pieces to inform a PRD on like, how do we actually build operations?  Yeah. Okay. Stuff like that. Okay. Rad. Okay. So going back to where we were in the record with this particular run, we were talking about convention versus configuration as a pattern.  I think we both agree. Rails got that right. Convention is nice. It requires less explicit configuration. It And relies more on implicit configuration based on file layouts and stuff like that.  we're into that. It was asking me about what do we want the shape of a loader to look like, given what we just did.  And I think each loader needs a load function. Okay, question asked. so index for metadata inversion for divine plugin, config.ts for convention file for the XAW schema.  This keeps index very lean. Question asked. For a loader file, what should the export shape look like? Each loader needs a load function and optional disposer.  Yes, I think this looks... Okay. So this is a good question. So I think a loader should like... Basically export a single thing, I'm going to say, and the disposer could be a function that is returned by the loader when the function exits, the async function exits.  Hadron should keep track of disposers and execute them when the server's lifecycle signals that it's preparing to be terminated gracefully.  Reasoning, disposers may need closure level access to variables that are initialized during the loader execution. So with all that, that's a lot of detail that may not matter to you, but, oh, you're muted.

7:27 - Travis Corrigan (matterflowadvisors.com)
  Hey, sorry, we have to send a wire. Okay. Sorry. Okay, so we're updating the loader.

7:39 - Derek Perez
  Yeah, we're updating the shape of the loader. The actual value of what I'm doing here may not matter so much to you, but basically arguing that just a loader needs to have a disposer and a loader have a parent-child relationship because the disposer may need to access references that the loader created.  So you can... can't export them as two separate things. Got it.

8:02 - Travis Corrigan (matterflowadvisors.com)
  Okay.

8:06 - Derek Perez
  Although, on the other hand, depending on how hot reload works, we may want to store those sorts of loaded references directly in the scope of the module file.  What do you think? Let's ask it. This is an interesting question because hot reload actually is an interesting corner case here.  Interesting. Okay. Both patterns have merit and the tension identifies real. Closure return disposer. Clean disposer closes over the DB naturally.  Yep. This is what I thought I wanted. No need to hoist. hoist. State to module scope, but on hot reload, the function, the closure gets thrown away, the server needs to call disposer before re-importing the module again.  Module scope state, like that. I don't hate that. Module state across reloads. People just like generally don't like this pattern.  People would refer to this as like a global, even though it's not.

9:28 - Travis Corrigan (matterflowadvisors.com)
  I know this is a taste thing, but how much do we care about AX versus DX here? Like, I'm curious what, does it matter?

9:38 - Derek Perez
  What, what this will, yeah, this matters AX because like, for example, as the agent's changing code, the question is, so how hot reload, like, let's say I change this entire file, right?  And I hit save and it replaces it. How much of this file, like, how does it rewrite? Like if it had an open handle to a database, it would just lose it, right?  So like it has a little to do with how hot reload splices a diff into live code. So it does have an architectural merit to be a little concerned about.  And I actually think module scope state is probably a little cleaner. Yeah, see module hold state across reload, but only if the hot reload preserves module scope variables, which hot does, unlike watch, which restarts the project.  This means the loader could be re-invoked and reassigned without losing the ability to dispose of the old one, but it also means the loader has to handle the already initialized case.  Closure pattern is simpler and safer. makes ownership explicit. The server holder disposer calls it for. The module scope pattern optimizes specifically for bun hot behavior that could change in its place.  Would it make sense to have a functor style? Approach to defining a loader and potential disposer so that this state can be, the state management can be deferred elsewhere for hot reloads.  I am also concerned about the testability of module scoped variables, because it has an impact on, so where does this impact?  AXDX, this would impact how easy it is or hard it is to test code. Factory functioner sees content, that state lives in the instance, not the module closers to RAS to manage.  Yeah, see, that feels better. Factory functioner is the letter each invocation for the first instance of a server. For hot related server calls, this was in the old instance, very important.  Press the module, gets a fresh factory, calls it again, gets a new instance, no module, scripts it to worry about her testing.  Yeah, I like that so much better. That's the way to go. The return to object could grow beyond dispose, health check, status reporting without changing the pattern.  Beautiful. Nailed it. Sometimes you just got to push it for the taste. What else? Okay. Section 3 revised, had a plug-in contract package for plug-in authors, defines what a plug-in is via conventions and helper functions.  Okay, plug-in looks good. It's good. It's good. Like, there are loaders. There are... Operations workflow. Yeah. And so that way, like, you would just fill in the blanks.  And then the plugin would export and connect all the capabilities when that plugin is loaded. I like that a lot.  Helpers and types provided by Hadron plugin, define plugin, define loader, define operation, define workflow, a bunch of definers would it then be.  So we're creating a defined star pattern. Got it. Which I also think is very smart because that provides semantic clarity.  then that's the path that AXDX is nice on this, I think. Yeah.

13:35 - Travis Corrigan (matterflowadvisors.com)
  I love the way that we're already talking about AXDX as like a way of like, what are we, who are we designing for here?  Yeah.

13:43 - Derek Perez
  I think that this is the thing that I think we need to really coin because I bet this is going to take, this is the future of vibe code.  It actually is.

13:50 - Travis Corrigan (matterflowadvisors.com)
  I'm going to look at. Go make us a t-shirt that's ACDC, but it says AXDX.

13:56 - Derek Perez
  Oh my  God.

13:57 - Travis Corrigan (matterflowadvisors.com)
  That would be amazing.

14:03 - Derek Perez
  Okay, let's see. Next, factory. Yeah, this is great. Plugin context, the server provides. Config, validated plugin, config from Hadron, a logger scoped to the plugin name.  This grows in later. What the server provides. Okay, that's great. So this is now talking, there's a point that it hasn't gotten to yet that it's going to, where we're going to hit a problem space.  How familiar are with the term dependency injection?

14:36 - Travis Corrigan (matterflowadvisors.com)
  Not super familiar, but I can just ask Claude to tell me.

14:40 - Derek Perez
  Yeah, the like five second explanation is that when these things run, there's stuff the plugin provides to the server, and there's stuff the server provides the plugin.  Okay. And there's like an order of operations there and a dependency system that there's an order of dependency there, right?  So this is right. This is Right, this is right. And it's point about plugin context. Instead of the concept of plugin context, referring back to the North Star brief, I expect we'll come up with a reusable dependency injection IOC pattern.  IOC stands for inversion of control. Okay. And what was it based on? I had put that in the North Star as like, here's one of the tools you might reach for if you do that.  Powered by a Willix. At least that's. Having said that, I want Hadron to own the plugin API plugin contract, or the API contract.  Okay. Regard, less of the dependency we choose. Okay, I just want to make sure it knows that, because plugin context is also a style of pattern I don't like necessarily, and I think it's reaching for a react pattern I don't want.  It's a taste thing. Plugin should receive a bespoke context object. Whoa. Um, shouldn't receive a bespoke context object. Exactly.  It should receive its dependencies through the same DM mechanism. Everything else is in Hadron owns the abstraction, so it's not coupled to a Willis.  Yes. Loaders receive dependencies. A Willis is the implementation behind the interface with plugins that were imported, referenced directly, defined loader factory signature.  Perfect. Yeah. So that's like an example of it right there. So you get an object called container and you resolve dependencies out of it.  So like, give me a logger and you're like, Beautiful. And so like that's instead of like you just finding a logger in place, you get handed the logger that you're supposed to use.  Yeah, got it. And so that pattern plays out all over the place. Where that'll also be interesting is we'll probably use that same mechanism to resolve operations from sibling plugins.  Yeah, right. Right. So if you wanted to be like, give me the operation that sends a Slack message, you would resolve it like this.  Yeah. Got it. And then you would reach for the operation. That's perfect. That container face type safe APIs. well, have run to find the contract at Willux's end implementation.  Perfect. Should the DI container be part of config since the shared concern or in its own package like container?  That's a great question. guess I'm, I'm just, it shouldn't be in config because that's too specific. And I just mentioned to be used by operations.  Should it spawn its own entire package? Yeah, I guess we would just, we can, I think we're leaning towards smaller focused packages, which is also good for context management.  So we should just always bias towards additional sub packages. They're cheap. So why not?

18:39 - Travis Corrigan (matterflowadvisors.com)
  How can we get AXDX.ai?

18:41 - Derek Perez
  I already tried.

18:42 - Travis Corrigan (matterflowadvisors.com)
  It's not available. No .

18:44 - Derek Perez
  And somebody else has done to us. Dude, a bunch of  has been like, for that domain was bought.
  ACTION ITEM: Contact AXDX.dev owner re: domain acquisition - WATCH: https://fathom.video/share/9kkqsx-zfyaw61XsTxDYYsxH_pRSsqWs?timestamp=1134.9999

18:49 - Travis Corrigan (matterflowadvisors.com)
  I'm surprised that AXDX was even available. I mean, that dev was available. See if anyone's running it. Server depends on container.

18:59 - Derek Perez
  No. It's parked somewhere. It's a fifth package.

19:05 - Travis Corrigan (matterflowadvisors.com)
  No, I'll reach out to them and see if they're, I'll just like, yeah.

19:09 - Derek Perez
  I mean, dev is totally reasonable.

19:12 - Travis Corrigan (matterflowadvisors.com)
  I also own UXR.ai, so. Dude, that's, that's your retirement plan right there.

19:20 - Derek Perez
  Yeah, for sure.

19:22 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

19:24 - Derek Perez
  All right. Update section three has changed. Does the full section look right now? Or is there anything else to adjust before moving on?  I think that looks right. Continue. That's cool, too. It's tracking the dependency tree. Yeah.

19:53 - Travis Corrigan (matterflowadvisors.com)
  But now I want to do the AXDX t-shirt. Well, what's interesting... Interesting is that, you know, just to pontificate on that a little bit, the AXDX stuff is like, Yegi's point about token budget is the only thing that matters now, right?  And actually, we have this thing around, the word token economics got bastardized by the Web3 movement, but I think the thing that's going to mean in the future is like, how many tokens do you need to spend to get a unit of economic output, right?  A monetizable unit, right? And so, you know, we've been doing a lot of stuff around managing around the 200,000 token context window limit, right?  And anything that achieves that objective with less tool calls and less hops is... ... Better.

21:01 - Derek Perez
  Check that out.

21:03 - Travis Corrigan (matterflowadvisors.com)
  Go ahead. Did you see that? Nice. It already noticed it.

21:11 - Derek Perez
  Yeah. It already realizes where we're heading.

21:16 - Travis Corrigan (matterflowadvisors.com)
  So it made a note for the future? Yeah. It made that insight and was like, oh, I'm just going to note that for the future.  Yeah, that's for Tracer Bullet 2. It didn't even, but it wasn't already in Tracer Bullet 2? It's just like, oh, I know.  Yeah. It's like, it didn't know I was going to ask it to do this.

21:32 - Derek Perez
  So it, after I told it we were going to do this, it saw how it would relate to the future.  Yeah. So yeah, it kind of, it just, it just inferred that now that that's where that would go. So we added to the future TV too in its mind here.  Yeah. says internal, does this look right? I think so. Yeah. All right, server core runtime plugin host discovers loads and manages plugins, plugin serves health, endpoint owns the server lifecycle, reads and validates config, creates the root hadron container, discovers plugins from configs, resolve their packages, scans each plugins convention directories, executes loads, factories, tracks return disposers, served HTTP via that endpoint, hot reload in dev mode, dispose, reimport, reload, graceful shutdown, export, execute disposers in reverse order, it doesn't really matter, but sure, server lifecycle, high-level state machine to be formalized, starting, discovering, loading, ready, shutting down, stopped, for hot reload, hot  Use this pop for file watching, unchanged versus disposal, lifecycle for effective plugins, reinforce, reloads, log tape, outputs for all lifecycle transitions, health endpoint, when it re-exports, define project config.  Yeah, that's fine. Should Hadron server re-export things from child packages for convenience, or should it always import from the owning package?  Convenience re-exports will be less tokens, so we would pick that. For server lifecycle, should there be a state for the server?  For existing in an unhealthy error, transient failure state, which might be recoverable. So how perhaps signaling by the health endpoints to not send traffic yet, traffic to forward.  So this is my concern is like, this is a totally reasonable order. But yeah, like what happens if like something breaks, right?  Like if something breaks in a recoverable way and it can reboot that plugin, I'm actually, I haven't, I didn't want to mention this yet because I didn't want to complicate the design, but I think I want every plugin to run in its own isolated thread.  And so a plugin could crash and not take. The entire server down. And if that, but that could be really dangerous also to allow something like that.  So I'm not totally sure how I want, like now we're reaching into like Erlang level message passing, which it can do.  Bun can do this. It's just, I'm not even sure that's a good idea. Yes. Fills an important gap without servers either fully ready or dead with no way to signal transient issues like a plug-in loader or failing non-filling.  Fatality, database connection, dropping temporarily, or hot reload in progress. Upgrading the lifestyle, starting, discovering, loading, ready, degraded, shutting down, stopped.  Okay, that's beautiful. Servers up, something is wrong, non-fatal loading. Wow, that's cool. I really like, I don't know how well you can see.  see. See the ligature on that one, but I'm going to try to boost this a little bit. See how it does a double arrow right there?  It's kind of nice. Wow. Are there any other life cycle events or finer granularity we'd want to consider? So now I'm just like not sure is that the right life cycle?  Loading into two phases. Loader factories, post load checks. Draining. Starting, discovering, loading. Validating. Ready, degraded, failed, drain. Draining, down, stop.  I like draining. Draining means server's still up, but it's not going to allow traffic. So like it can go down without like accident, like it won't shut down until all the requests have left the system.  Right. So you don't end up like killing a request halfway. I might change validating to initializing. Yeah, that feels good.  That's actually, that is really good. Starting, discovering, loading, initializing, could fail, or stop. And then it was to ready, to degraded, to ready, draining, shutting down, stopped.  We find a single word for shutting down. It's the only one with two words. Stopping. There we go. Stopping, stops.  I like that. Perfect. Nice, nice, nice. So I got about 20 minutes left. I'm also game to do this later tonight, if you are.  I don't know what you're What you're planning to do tonight? I have a date time with Wendy.

29:05 - Travis Corrigan (matterflowadvisors.com)
  Okay, we can skip.

29:06 - Derek Perez
  Well, we can, I mean, we can just stop and start this as we go. So it's fine. That's also true.

29:12 - Travis Corrigan (matterflowadvisors.com)
  The session, so we can always come back to it. Yeah, exactly.

29:15 - Derek Perez
  So I'm fine to just treat this like a court case and just literally stop and walk away and come back and turn on the record.  Okay, cool. This is totally fine. All right. Primary control plane. We're on the CLI. Primary control plane for humans and agents, ships as Hadron.  One thing I was curious about, is header actually a command already? Okay, good. I felt like some like Unix  that I would have not known existed.  All right. Hadron new project name. Hadron new plugin name. Hadron dev, CLI framework, optic for argument parsing with TTY detection, interactive prompts for humans.  Runs, prompts, runnames, R's, runs, buns, and... This is funny. This is a thing I was. Wow. Okay. I'm actually really impressed because this was something that I didn't clarify and it intuited.  Um, and I guess I will probably. Hmm. So if you do new plugin, it intuited correctly that it should put it in the plugins folder of the project, which is pretty impressive.

30:40 - Travis Corrigan (matterflowadvisors.com)
  Damn. I didn't specify that. Is this, we're still in ADR sort of land or are we getting, where, where are we in terms of like the strategic versus tactical kind of spectrum?

30:54 - Derek Perez
  We're still in the strategic spectrum. We're now talking about the control, the CLI tool. In terms of how it's structured and what it's supposed to do.  Okay, got it. Right? So like, this is DX, AX level stuff. Like, that's how you use it. And then this is what it does.  Okay, cool.

31:13 - Travis Corrigan (matterflowadvisors.com)
  Right?

31:14 - Derek Perez
  And then interactive mode stuff, where a plugin goes, Hadron dev, initializing, watches the stuff, does hot reloads, health endpoint.  Okay, for scaffolding templates, should they be embedded as string literals in the source, or is the actual template files on disk that get copied?  Template files. Ooh. Best of both worlds. Template files on disk during development, but bundled in the CLI binary at build time.  Yeah, I mean, yeah. Okay. I expect the Hadron CLI will have an MCP subcommand that an agentic tool like Claude Code could use to connect as a proxy to the projects, the dev server being ran for the projects.  Should we think about that? What do you think about that approach? What else should we consider? So that was my kind of thinking there was like the CLI.  CLI hosts its own MCP server for code, and then it proxies into the dev server. So the dev server can come and go and crash, but the other one will stay alive.  Nice. That's a smart approach. CLI acts to STDIO to HTTP grid, cloud code, which is also less tokens, by the way.  Cloud code or any other client launches Hadron MCP as an STDIO, standard in, standard out, subprocess, and the CLI proxies MSP requests to the running dev server's HTTP endpoint.  The agents don't need to know about the server's address or transport server to just talk to the CLI process.  That was the other thing, is it doesn't make, we don't have any port management to worry about in that world.  Standard, no config on the client side, dev server discovery, CLI knows where the dev server is. Auth pass-through, CLI can handle API key management for MCP connections, so agents don't need raw credentials.  All that's great. Other things considered, dev server coordination needs to know the dev server's running and where. Other option is dev server writes with that step at start.  Startup, auto-start it, UCPA is deferred to MC1, but the HP command structure and dev server discovery mechanism could be stubbed in TB0, so they're part of the CLI, yep.  Other ones would be Hadron Doctor, Hadron Build, Hadron Keys, Hadron Migrate. Add the stub for discovery. Oh , there was something I just thought of that I forgot.  One additional thing the dev CLI or the CLI MCP proxy could do is Hard reset, start, stop the dev server as needed.  We should call that out as examples of project process management that the agent can utilize as needed for debugging.  Okay. Okay, I think we'll defer MCP stuff to TB01, but I like that it's thought through it. Cool, that's good.  Man, this is good. I can't wait for this to exist. This is going to be so amazing. Okay.

36:49 - Travis Corrigan (matterflowadvisors.com)
  I said it feels so good to be making the software you and I have always wanted to be making.

36:54 - Derek Perez
  Yeah, man, this is nuts. This is like really good. Yeah. Certainly better than anything I could do in any short period of time.  Yeah.

37:07 - Travis Corrigan (matterflowadvisors.com)
  It would take you so long to figure this out.

37:10 - Derek Perez
  This is like 500 times more intelligent than what I was doing with Gestalt when we met.

37:18 - Travis Corrigan (matterflowadvisors.com)
  And much simpler too, right?

37:20 - Derek Perez
  What? Much like more compact. Yeah. It's a lot simpler. Does the complete design look right? Config, container, plugin, server, CLI.  Yeah. Those are the hot points. Dependency graph, state machine, external dependencies. Yep. MCP, doctor, build, keys, migrate. Does this look right?  If so. Okay. So that's interesting. It wants to write a design doc and commit it. So now it's out of the brainstorm mode.  mode. Video on design. We're load this We're and Yeah. So shall we do that next?

38:06 - Travis Corrigan (matterflowadvisors.com)
  Yeah, I'm interested to see what happens because it'll want to do a design doc. It's going to save that there.  And then that's probably going to either conflict with the wiki PRD part or it's going to be an input to that.  And I'm not sure what's going to happen. I suspect that it's probably going to conflict. So let's just do it and see what happens because this is if it's somebody other than you and I who hasn't built this, they're just going to be like, oh, yeah, sure.  The next step, I guess. And like it should work. And so, yeah, let's just act as if. Okay, so that's good.

38:43 - Derek Perez
  And in worst case scenario, we have like a reasonable thing that we can meld into another run. But I think this point where it's writing design doc is where I think I would say write that run lens and then submit this as an ADR.  Okay, cool. Right. And then we would move to implementation. Planning and then PRDs would happen. Oh, okay. That's how I see this process of going to this altitude and then tactical.  That transition point, I think the ADR is the bridge.

39:14 - Travis Corrigan (matterflowadvisors.com)
  Okay, I think that makes sense. And that alleviates my anxiety about the fact that we still don't have a project scaffold set up and we don't have a wiki set up, right?  So like the invoking the using PM thing, you know, ideally on first time usage, right? So this is the DX part of using Limbic is that it should just set up that scaffold so that you know where all this content we start generating is going to go.  The fact that we have nothing set up makes me feel anxious. Yeah, I think this is probably where it's going to be like, oh, I don't have any of that .

39:56 - Derek Perez
  And then it'll just do it. Yeah. And I think it.

39:59 - Travis Corrigan (matterflowadvisors.com)
  Yeah. So ideally, it should just be like, let me set up all that  and then start like, yeah, let's start at the high altitude.  Okay. All right. Shall we go?

40:08 - Derek Perez
  Yep. Yeah, I'm with you that like an initialization of the project should just touch everything. And then it should just at that point, I think the checkpoint there is like write a clod file or something.  That's like, this is everything I just did. And now you use all the things I just did.

40:24 - Travis Corrigan (matterflowadvisors.com)
  Yeah, I think like a limbic init would be or project setup or something like that would be the right.  Yeah.

40:32 - Derek Perez
  It's actually going to be a slash command for just project setup. Right. Something like that. And that could be extremely deterministic as like a script.

40:40 - Travis Corrigan (matterflowadvisors.com)
  Yeah, I would I would actually have cloud code just write that script and have you look at it because I'm not going to know how to parse that.

40:46 - Derek Perez
  Yeah, it's just going to be a list of like GitHub CLI commands. Yeah. All right.

40:55 - Travis Corrigan (matterflowadvisors.com)
  This is a design doc. I'm probably going to actually really pour over.

40:59 - Derek Perez
  Yeah. And this is also the kind of thing I would expect it to need to have a feedback loop process.

41:09 - Travis Corrigan (matterflowadvisors.com)
  Yep.

41:10 - Derek Perez
  And that might be like the kind of thing that, so like an ADR would propose this, we would review it, and then we would add comments to discuss like evolution.

41:21 - Travis Corrigan (matterflowadvisors.com)
  Yeah, and then would we want Claude to respond to those comments?

41:27 - Derek Perez
  In a sense, what I mean by a comment, though, is I don't mean as like a conversation, I mean as like checkpoints.  So we would say like review one is a comment. Okay. We would have, like we were doing with the other day with Claude PM itself, like we would go over the entire thing and then come up with like a disposition and then ask for changes.  Yeah, right. Right, not like I'm going to have a conversation asynchronously through discussions. All right, yeah.

41:52 - Travis Corrigan (matterflowadvisors.com)
  Okay, so I'm going to reflect this back as the user, like user research thing is, okay. So the, the, we would.  Get this design doc, put it in ADR, then we would review it all together, use the, we would talk through it, make live, make notes, and then combine the notes, the design doc, and the transcript as inputs into Cloud Code to generate another rev.  And then we would do another, it would go back to the ADR, and then we would do checkpoint two, which is another review.  And we would do that until we felt it was good. Yeah.

42:34 - Derek Perez
  And then it's done, locked.

42:36 - Travis Corrigan (matterflowadvisors.com)
  Okay, now it goes over to PRD land.

42:38 - Derek Perez
  Yeah, every comment would be a review session with like a transcript and feedback. Yeah. And then it would update the ADR that is sort of the top conversation or the top post.  It would just edit that top post. Okay. Cool.

42:55 - Travis Corrigan (matterflowadvisors.com)
  think.

42:56 - Derek Perez
  That feels right. And then, yeah. And would ultimately be like a... The final dispositions placed on it, we close it, and then we move to an implementation phase, and then PRDs could be derived from that that reference it.  Okay, that makes sense.

43:09 - Travis Corrigan (matterflowadvisors.com)
  I like that. That's awesome to me.

43:11 - Derek Perez
  Yeah, I mean, I think that's like where this, I've always thought of ADRs as more strategic in that way.  So I think that it's the right piece, I think. All right, it just wants to commit it.

43:23 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

43:26 - Derek Perez
  But don't I need to read it? No, can commit it, and then save. Well, okay, I just think it's going to start implementation planning, and I'm not even sure it did everything that I, like, I mean, I guess, is your experience with this, that this is just a codification of everything we just already reviewed?  Yes.

43:48 - Travis Corrigan (matterflowadvisors.com)
  That's typically what it is. Yep. So you don't really look that hard at this?

43:53 - Derek Perez
  No, I don't.

43:54 - Travis Corrigan (matterflowadvisors.com)
  But that may not be good. But no, I don't usually look that hard at it. I think you're right, though.

43:59 - Derek Perez
  Look. Just skimming this, it looks like everything we just looked at. So I think it is truly just recording it.  So let's do it.

44:08 - Travis Corrigan (matterflowadvisors.com)
  And then it usually asks if you want to transition and it'll be like, do you want a separate session or do you want sub agent?  Ready to invoke writing plans skill to break this into implementation tasks.
  ACTION ITEM: Schedule Session 3 w/ Travis (weekend); then move to implementation planning - WATCH: https://fathom.video/share/9kkqsx-zfyaw61XsTxDYYsxH_pRSsqWs?timestamp=2661.9999

44:18 - Derek Perez
  Yeah. Cool. All right. So now at this point, I just want to time check you because I have seven minutes left.  Do you want to stop here? Yes, let's. Let's stop here. That way we don't cut this off in the middle.  Yeah. And we can do a third session. Either my next availability window is either at some point tonight, which you're not good for, or tomorrow during meet and nap time between the window of 2 p.m.  and 4 p.m. I have plans tomorrow at that time.

44:48 - Travis Corrigan (matterflowadvisors.com)
  All right. Like on Monday or something. Yeah. Monday, I'm in jury.

44:53 - Derek Perez
  Oh, .

44:55 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

44:56 - Derek Perez
  All right.

44:57 - Travis Corrigan (matterflowadvisors.com)
  Well, we'll find some time next weekend. Bye. Yeah, we're gonna, I guess I'll just leave this here.

45:03 - Derek Perez
  This is actually a really good stopping point.

45:04 - Travis Corrigan (matterflowadvisors.com)
  I'm glad we did stop there then because this is, I think from here on out, like we get into tactics, and then we're gonna open up like a file systems worth of like open mental browser tabs and like literal, like, yeah, different threads with cloud code that I think we just need some like dedicated time for.

45:25 - Derek Perez
  Okay, so I think this is actually a perfectly good artifact to have done with session one and two, and then we'll move that, we'll go to this next transition point, and we'll do that as a separate video.  Okay, awesome. All right. Well, you. This is perfect. And I'll catch you later. See Have a good one. Love you.  All right. Love you. Bye.
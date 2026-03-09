20260305 Limbic UXR - Session 6 - March 05
VIEW RECORDING - 147 mins (No highlights): https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo

---

0:00 - Travis Corrigan (matterflowadvisors.com)
  I'm not a technical, I'm not a thought partner here in my mind. Like, I'm not sure what input you actually need from me on that stuff.  Well, I think right now it's behavioral, right? Yeah.

0:16 - Derek Perez
  So I think we're going to mostly be curious about, like, , sorry, hold on, my computer's going insane.

0:23 - Travis Corrigan (matterflowadvisors.com)
  I'm mostly curious about, like, what you have to do to get through the next set of steps. Yeah, that's what I'm talking about.  So you can totally talk to me about, like, your thought process and explain things and all that stuff, and I will definitely listen, but you're basically getting a golden retriever, like, answering you, like, in response here.  We're so in the technical weeds on some of this stuff that, you know. Yeah, that's fine.

0:50 - Derek Perez
  And I think what you're going to benefit from here or be able to help me with.

0:56 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

0:59 - Derek Perez
  Yeah. That is more to do with the process than the content. That's it. Yeah.

1:07 - Travis Corrigan (matterflowadvisors.com)
  That's totally fine.

1:08 - Derek Perez
  But I think that's the point of value and what I've been waiting for. Yeah.

1:12 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Yeah. So I'm definitely going to be here present for that. Okay. And with that, let's do some session up.  I do. Okay. Great.

1:25 - Derek Perez
  Okay. So let's see here.

1:29 - Travis Corrigan (matterflowadvisors.com)
  Now you wanted to, as I recall, you wanted to provide more feedback on the design doc. Yeah.

1:37 - Derek Perez
  So I went through and reread it and I have a series of notes that after looking closer at it, and this, this, think was an important lesson was it mostly captured the discussion in brainstorming, but it was not, it was not, it actually all of it, or in even some cases.  Yeah. Yeah. Yeah. Yeah. you. So there are decisions that it made that were kind of naive that needed to be rethought.  So I'm going to, what I, what I want to do is go and give it a list of these things that need to be addressed.  But I'm sitting at this point, transition to implementation planning. So at this point, I would think I'm going to tell it, actually, I've thought about it and I have some notes.  We need to reincorporate into the plan for the plan.

2:27 - Travis Corrigan (matterflowadvisors.com)
  Yeah, that's right.

2:28 - Derek Perez
  So no, I've slept on it and I identified a number of issues in the current doc that I want us to address before we proceed.  Okay. Now the specifics, the specifics of this, I don't think you'll care about.

2:59 - Travis Corrigan (matterflowadvisors.com)
  You

3:00 - Derek Perez
  Okay. Okay. That makes sense, but the server reexports it. This means canonical import for project author is import to find project from it.  Great. Next. right. To find plugins should not contain name in version fields. That's package.json responsibility. Could consider. All right.  Next. Some duplicative stuff, right, name and version are already bad at duplicating because you're done it. Collapsing, if we drop index entirely, we're like, okay, if can mention this, a plug-in, okay.  And it's a key, plug-in to export. To make index optional, let's if the server finds. Yeah. Keep index.ts with defined plug-in, owning the config schema, drop, config.ts.  Beautiful. Beautiful. Thank you. Awesome. Okay. Oh, I discovered that the capacity, did tell you I discovered the capacities MCP doesn't work?  Yeah, it like.

5:18 - Travis Corrigan (matterflowadvisors.com)
  It doesn't return content. It doesn't return content, it just returns the name of the file. So I'm not happy about that, but.  Is that the official MCP from them?

5:33 - Derek Perez
  No, it's one that I forked from some other person, but it's ultimately hamstrung by the API they expose, and that's what their API exposes.  I went and yelled at them on Discord, and I was like, what the  are you thinking right now? Oh.
  ACTION ITEM: Fix DV loader ordering; ensure DV loader runs before other alpha loaders - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=404.9999  Yep, yep, yep. Internet. Let's demonstrate this. Well, that's what I  thought, but why didn't you do it? There she comes.  This loader is actually an alpha order within a plugin, a loader that registers DV needs to run before those.  So I'll handle this, but we should call out the plugin, that cross-plugin resolution. Cross-plugin resolution is a CB2 concern.  Yeah,  it. Just deferred on my . Okay, I think at this point, that was all of the notes that I had.  And it's now updated. Okay, so we should say, that's it. Now update the design doc with this feedback?

7:52 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Okay. It knows. Okay.

8:00 - Derek Perez
  Damn, we haven't touched this for a while. February 27th. Okay, there it goes. Cool. All right.

8:22 - Travis Corrigan (matterflowadvisors.com)
  Okay, so it's not updating the design doc. just is like, are we transitioning to implementation planning? No, no, no, it's doing it.  Oh, it is? Okay.

8:30 - Derek Perez
  Yeah, it's making diffs to the markdown file. Yeah, this looks right. Okay, cool. It's interesting because I've been listening to that agentic thing, and I was just thinking about this thing it's doing right now.

8:58 - Travis Corrigan (matterflowadvisors.com)
  No, no, no.

8:59 - Derek Perez
  So I think... One thing we underutilized in the current cloud code workflows is they rely extremely heavily on hooks for determinism.  Even like you can use cloud in a hook of itself. Yeah. And like stuff like that. And that's one thing I want to be able to do with Hadron is just provide a way to like inject into the hook system from code.

9:23 - Travis Corrigan (matterflowadvisors.com)
  Yeah, right.

9:24 - Derek Perez
  So that like if you're in a Hadron project and cloud code is attached to it, the hooks can automatically jump into the agent that's editing the code.  I think that's going to be pretty cool. I think it's going be super cool. Okay. All right. And now it's adding and updating.  It's committing the updated plan. Now I think it's going to do it. Okay. Design. Updated and committed with all feedback.  Let's move on to implementation planning? Yes, let's.

10:06 - Travis Corrigan (matterflowadvisors.com)
  Let's.

10:14 - Derek Perez
  I'm using the writing plan skill to create the implementation plan. Let me first read the design doc, current state.  Are we still, like, technically inside of your skill?

10:32 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Okay.

10:36 - Derek Perez
  That's the one thing I don't love about the way this works. I can't tell when I'm in a skill.

10:42 - Travis Corrigan (matterflowadvisors.com)
  Yeah, it's. Yeah, you have to, like, scroll up and sort of see what's been loaded in this session.

10:47 - Derek Perez
  And then that's, in this scenario, like, at some point, the terminal will start throwing away lines so you could lose it.  Yeah. I have seen people, I don't know how, but I have seen people... Change the text here when they're in a skill.  Oh, really? Yeah, I don't know how they're doing that, but I have seen.
  ACTION ITEM: Ask Claude how to update skill prompt text - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=672.9999

11:07 - Travis Corrigan (matterflowadvisors.com)
  I saw that. I mean, the superpower skill does that, actually. Yeah, I don't know. transferring to implementation planning. It's like that.  I'm like, oh, that's controlled. Yeah, I don't know how it's doing that. I'll ask Claude. Yeah, maybe you can just tell it to.

11:42 - Derek Perez
  Okay, so that's good. so very much. Thank Thank you.

11:56 - Travis Corrigan (matterflowadvisors.com)
  Thank Thank you. Thank you. Thank you. Thank Thank you. Thank you. Have you been able to make the remote control session work?  I haven't tried. Today is my first day at my desk. Wow.

14:50 - Derek Perez
  I haven't even had a chance to think about it. Just a look at it. It's funny, can you pause recording for a sec?  Okay, turn it back on. I'm sorry, is this dumb questions AI?

15:18 - Travis Corrigan (matterflowadvisors.com)
  So, yeah, the , yeah. If you're ever worried about stability, ask yourself, would a human be stable right now?  All right, it looks like it's looking for a... It's good. So it's doing document formatting right now. Got it.

15:35 - Derek Perez
  Did you tell it to do that? I forget who told it to do that. It must have been me.  Probably you.

15:40 - Travis Corrigan (matterflowadvisors.com)
  I wouldn't ever ask that. And he wanted to do that.

15:43 - Derek Perez
  Which is, this is a good example of something we're wasting tokens on and should just be a hook.

15:49 - Travis Corrigan (matterflowadvisors.com)
  Because, like, it'll forget. I've also seen it forget to do that a lot. Right, right.

15:54 - Derek Perez
  Okay, plan completed. Now, this is interesting. I don't know if you've seen this before. I saw this with just pure superpowers the other day.  Okay, let me look.

16:04 - Travis Corrigan (matterflowadvisors.com)
  Yes, so I've seen this for about 10 days now. Sub-aging versus parallel session. Um, I... I kind of like the sub-agent driven, because I personally feel better about the coordinator agent having a history when I'm kind of completing a documentation bit.  And then when it gets into actual implementation, then I would have a fresh session. So that's my thought.

16:42 - Derek Perez
  Yeah. I think, I think you're right too.

16:44 - Travis Corrigan (matterflowadvisors.com)
  Like that.

16:45 - Derek Perez
  It's funny though. I think this is definitely like, this is our level test of like, have we hit level seven yet?  And we're like, no, I don't, I don't trust it yet.

16:55 - Travis Corrigan (matterflowadvisors.com)
  Yeah, exactly. I agree with you.

16:57 - Derek Perez
  I would have picked sub-agent driven as well. Okay. But here's what I'm not sure about. So is it going to just start writing code now and totally ignore?

17:06 - Travis Corrigan (matterflowadvisors.com)
  Or, so go to, go to, go to, to the docs, docs plans. Okay. Okay. Okay. Usually what I do is I go and I just look at it, or I just like hover my mouse over it, and then what do you just do?  So I learned that if you press exclamation point, you can just type bash commands in there.

17:28 - Derek Perez
  What?

17:29 - Travis Corrigan (matterflowadvisors.com)
  Yeah, so if you use that, you can just type any like command that's allowed. And then you...

17:37 - Derek Perez
  And then it becomes part of the session.

17:41 - Travis Corrigan (matterflowadvisors.com)
  Okay, now I need to get good at... Now I need to teach myself bash. Well, I only need...

17:46 - Derek Perez
  Like, for me, it was handy because I remember I'm trying to live in a world where I don't open the IDE.  Yeah, right.

17:52 - Travis Corrigan (matterflowadvisors.com)
  But I'm not succeeding at that.

17:54 - Derek Perez
  So I'm just having to do this sometimes. Okay, so Doc's plans...

18:02 - Travis Corrigan (matterflowadvisors.com)
  It's right above Hadron. But it's interesting it's not even checked in. Yeah... Or, oh, you know what? Maybe it's...  It checked it in already. I've committed it, yeah. Yeah, okay, that's fine.

18:17 - Derek Perez
  All right, use superpowers executing plans to implement this plan task by task. Wow, this is really long. But, like, shouldn't this have been – okay, so I would have thought this would be a – this is a – all right, we claim this is an ADR, right?

18:50 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

18:51 - Derek Perez
  Where's the PRD?

18:54 - Travis Corrigan (matterflowadvisors.com)
  So this is where I think using brainstorming is a bit of a conflict a little bit with our process.  And that we may have to just rebuild parts of it so that the – it doesn't over – I don't  To run our process. Let me look at the readme real quick just to see what the next thing to do is.

19:23 - Derek Perez
  Okay. Yeah, because this is a 2400 line file.

19:35 - Travis Corrigan (matterflowadvisors.com)
  Okay, so the design file itself is PRD. PRD. Okay, so this is PRD.

19:43 - Derek Perez
  Oh, okay, fine, fair enough.

19:44 - Travis Corrigan (matterflowadvisors.com)
  So then we are going to structure into GitHub and wiki issues. So the next thing to do is to do slash command using PM or slash PM dash structure.  This one.

20:06 - Derek Perez
  So because we have the plan at this, so we have docs that it can do this with is what you're saying.  you. Thank Thank you.

20:11 - Travis Corrigan (matterflowadvisors.com)
  That's right. Yeah. So then I would tab it and I would go, I, usually what I do is I just give it the relative path for the, the design doc.  It was probably a better, faster way to do that, but it's just what I do for more. Do you know about at sign?

20:27 - Derek Perez
  No. So if you do at sign, you can name any subtree at any level.  yeah. So then I can, yeah, I, and you can give it probably both.

20:38 - Travis Corrigan (matterflowadvisors.com)
  I don't know what you want to do, but.

20:40 - Derek Perez
  I would just give it the folder because there's two things in there right now. I, well, what, does it matter?  It should figure it out or.

20:47 - Travis Corrigan (matterflowadvisors.com)
  No, actually just give it the whole folder and let's see what happens. I'm curious to see what it does with it picks.  The challenges is going forward. Brainstorming is always going to dump future design docs into this. So giving it the folder isn't going to really work.  Okay, here we go.

21:07 - Derek Perez
  It's starting to auth. It's doing. Stuff. Yes, and don't ask for. Yeah, that's fine. Repo view. Don't care about that.  We're just going to start allowing GitHub commands. Okay, cool. So now it's like talking to . Yeah, you can do GitHub stuff.
  ACTION ITEM: Update GitHub token to allow sub-issue creation - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=969.559325  Oh, interesting. Interesting.

21:39 - Travis Corrigan (matterflowadvisors.com)
  Okay.

21:42 - Derek Perez
  The token I have doesn't let it touch issue types. That's weird. Should we stop it?

21:56 - Travis Corrigan (matterflowadvisors.com)
  No, I just want to see what happens. Well, we got to fix that.

22:03 - Derek Perez
  Okay, here we go. Right. So this is, okay.

22:07 - Travis Corrigan (matterflowadvisors.com)
  No existing milestones, no config using defaults.

22:11 - Derek Perez
  Step one. And parse the PRD. Oh, cool. Okay. Okay. Okay. So then if I were to think about this, what we just stepped into, it went through the basic brainstorming plans, design and implementation local set.

22:27 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

22:28 - Derek Perez
  Now we're federating it into GitHub. GitHub.

22:33 - Travis Corrigan (matterflowadvisors.com)
  Yeah. And the project has not been set up, right? So, like, we're kind of watching what it's going to do as it ragdolls into this, like, uh...  I'm about to create GitHub artifacts for Milestone Future Branching.

22:50 - Derek Perez
  This will create...

22:56 - Travis Corrigan (matterflowadvisors.com)
  Let's look at the... Let me review first. Okay, so the PM structure, what it's designed to do is creates a wiki, PRD page, and meta page.  A GitHub milestone with a feature branch. Store... Free issues with task slash bug sub-issues, Gherkin's acceptance criteria dependency annotations, and labels, epic, size, status, and priority.  So if you say yes to this thing, that's what should happen. Okay.

23:27 - Derek Perez
  Now, what I think we should do is we should stop it and say, we need to fix this?

23:36 - Travis Corrigan (matterflowadvisors.com)
  Well, let's...

23:37 - Derek Perez
  It's basically not going to be able to solve this. Well, let's...

23:42 - Travis Corrigan (matterflowadvisors.com)
  I'm interested in sort of playing out the... Okay, like we did it wrong, see if it can heal? See how it tries to heal, see what it does, and then...  Because we know the fix that we need to do. This is all get solved in, like, that setup. Okay.  The onboarding thing that we need to do. Yeah, fair enough.

24:02 - Derek Perez
  Yeah, what we need to do is have a pre-flight check that's like, do I have all the permissions I thought I had?

24:06 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Okay, okay, okay. And we have to have, like, a config or setup... Sort of skill, which is just like you run the first time and it just sets up your project space.

24:16 - Derek Perez
  Right, right, right. Which would probably check for these tokens and a bunch of other things. Okay, let's... I like the let me review first.

24:27 - Travis Corrigan (matterflowadvisors.com)
  Let's do that.

24:28 - Derek Perez
  Let's do that, just because I'm curious what it will show us. All right, well, we'll see you tomorrow. feel better.  I'll feel better. Okay. Okay. Okay. Total of nines. Okay. Wow. So here's the full breakdown for creating everything. Story breakdown.  Workspace package scaffolding. Critical blocks everything. Size small. Dependencies none. Set up the read with five workspace packages. Create them.  Verify workspace resolution. Project configuration. Critical dependence on story one. Size small. Tasks. I love the scenarios there.

25:46 - Travis Corrigan (matterflowadvisors.com)
  Three. Yeah.

25:48 - Derek Perez
  Critical size depends on story one. So it's identifying, it's identifying a graph. Correct. And then the next one, plugin SDK, critical size small.  One, two, three. I also think that, by the way, like the fact that it's estimating them all as small is either great or bad because I think it's great because this is also a litmus, right?  Of like a way. Well-designed problem that can be broken up into many small pieces. Yeah. As a particular, you know, classical smell of Scrum or whatever, or Agile, anything that's on the high end of the size spectrum may be underspecified.  That's right. Yeah. Which is an interesting thing we'll be able to actually validate here.

26:30 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Oh, there's a medium right there. Story 6. Okay.

26:33 - Derek Perez
  And that makes sense to me because plugin discovery and loading is big. I'm surprised I only thought it was medium, but core server and health endpoint medium stories, two, three, four, five, six.  CLI medium. Just file and final cleanup. Yep. By the way, for those playing at home, just files and the just command.  Are you familiar? You're probably familiar with the old school concept of make. Like the command make. Have you ever heard of that?  Okay. It's an old arcane thing from like compiling C for Linux.

27:17 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

27:19 - Derek Perez
  There's a more modern version of that called Just. And Just is just literally that. It's, it's, this points to a shell, a bunch of shell commands and just runs them and gives them a name.  Got it. So when you see it talking about the Just file, it's creating a named entry point called test.  So if you run Just test, it runs all the tests for every package or just format runs format on all the code.  Bye mom. Thanks for everything today. And that one, we got an extra small and that sounds right. Good.

27:55 - Travis Corrigan (matterflowadvisors.com)
  Does everything look right?

27:56 - Derek Perez
  Any stories to add, remove, or restructure before I create the GitHub artifacts? Do you think there's any point in asking it to review what it just did?

28:11 - Travis Corrigan (matterflowadvisors.com)
  Um, I don't know. I, I read the other day that like these machines are basically, every time you give them an input, it's only thought is like, what sounds like a good response to this?  And so if you just ask it to review, it may be just like performatively reviewing. Yeah, I don't know.  Yeah, try it.  it. I don't know. Like. Yeah.

28:54 - Derek Perez
  This is definitely one of those things of like, I don't know, because like sometimes, you know, it, it got novel focused and then it gave up on a thought.  Yeah, right.

29:05 - Travis Corrigan (matterflowadvisors.com)
  Like there's no guarantee.

29:06 - Derek Perez
  Like it went, it could go breath. Yeah. And miss something in depth that has, it could Yeah. I have seen that happen.  I've seen that happen before. So by the way, I think you can actually set up hooks to run. Boom.  Did I find some stuff? Several gaps. Hot reload.

29:32 - Travis Corrigan (matterflowadvisors.com)
  Okay. So I'm so glad we did this. Good call. Plugin.

29:52 - Derek Perez
  Meaningful gaps. Hot reload, especially. I'm so glad we did this. Yeah.

29:57 - Travis Corrigan (matterflowadvisors.com)
  Okay.

29:57 - Derek Perez
  For the recording, mark this as extremely important lesson learned.

30:03 - Travis Corrigan (matterflowadvisors.com)
  Needs to be a review.

30:05 - Derek Perez
  There always needs to be a source of truth review. Before we do the.

30:11 - Travis Corrigan (matterflowadvisors.com)
  the. The, like, actual commit. Yeah, the actual commit, too.

30:19 - Derek Perez
  Wow, yeah, because, like, actually, the things that it's saying that it missed are significant.

30:24 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

30:28 - Derek Perez
  Wow.

30:32 - Travis Corrigan (matterflowadvisors.com)
  This is where I ask, like, why did you miss all this? How did you miss all this? Was there something, ask it if there was something in the skill that we used that caused it to make this gap?

31:35 - Derek Perez
  Yes, the gap originated in the writing plan skill execution, not in the brainstorming or PM structure stages. The design doc was correct.  Hot reload, config validation, and failure handles were all specified. The problem is how I translated the design into implementation tasks.  The root cause, the writing plan skill, focuses on code structure, not behavioral coverage. Okay.

31:57 - Travis Corrigan (matterflowadvisors.com)
  Wow.

31:58 - Derek Perez
  When I wrote that package, no cross-reference check between design doc and implementation plan. The implementation plan is under. They're specified for the server, for the dev server.  It's five steps when the actual dev server behavior, hot design doc, significantly more complex system. So, yeah, shouldn't we say, aren't there PRDs that need to be made?  That was the thing I think is not right about this. Okay, I think I see the problem. Yeah. When we went from brainstorming, we should not have gone to writing plans.  Implementation.

32:43 - Travis Corrigan (matterflowadvisors.com)
  was, yeah.

32:44 - Derek Perez
  We went, we went to writing plans too soon. What we should have done was gone from brainstorm and then told it, we need to now flesh out PRDs.  Yep. For each of the, because what, I think, okay, this makes sense.

33:04 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

33:05 - Derek Perez
  Because what we made was an ADR. Right. And we tried to turn an ADR into stories. That's. That's. Which has happened.

33:13 - Travis Corrigan (matterflowadvisors.com)
  Yeah, okay. Okay. You're almost out of context, by the way. What should I do about that right now?

33:23 - Derek Perez
  What would you do?

33:26 - Travis Corrigan (matterflowadvisors.com)
  I'd compact.

33:32 - Derek Perez
  So I think what we need to tell it is we need to go from this sort of project ADR.  And I think that might be where some of this is a little bit interesting as a process problem. Not everything is going to start with an ADR.  Right.

33:50 - Travis Corrigan (matterflowadvisors.com)
  But in this case, we did. Yeah, because we're literally architecting the whole, we're doing a true zero, start from zero part.  Right. Yeah. We probably need a skill that's like new product. Yeah. Versus like new PRD.

34:07 - Derek Perez
  So instead of the, so what we're doing right now is PM. Structure, which is to go to tasks. Is there something that creates PRDs?

34:16 - Travis Corrigan (matterflowadvisors.com)
  No, was just literally leaning on all of the brainstorming stuff.

34:23 - Derek Perez
  Okay, well, so we just need to go recursive here. So we would say, okay, we have brainstormed in ADR.  Now we're going to brainstorm a PRD for every section of the ADR. Right?

34:37 - Travis Corrigan (matterflowadvisors.com)
  Yes. Yeah. But the challenge is, is that the brainstorming skill, like it has these strong opinions about its overfocus on technical implementation, right out of the gate.  then it doesn't, I, to be honest, dude, I think that we need to leave some of the brainstorming skill from superpowers, fold it in natively in our own and make it our own.  I'm not sure how to do that while honoring and respecting superpowers. I'm how But that's open source, right? Like you literally put the code out there, there's nothing stopping me from copy pasting and modifying it in my own thing and calling it the same thing as yours.  I think you're supposed to with this stuff.

35:25 - Derek Perez
  I think that's kind of the point of like, that was one of the reasons why initially with the Medusa project, I actually checked Superpower's code into my project.  And occasionally it would try to update the skill based on retrospective feedbacks. It's like it made a mistake. So, I mean, I don't think there's anything wrong with that.  I think the point is that you're supposed to meld and evolve the skills to fit. Like that's one of the nice things about why it's all markdown.  Yeah, right.

35:55 - Travis Corrigan (matterflowadvisors.com)
  Okay, so. It's also, so if you hit control O, this is the summary. Oh, okay.

36:10 - Derek Perez
  Okay. So, okay, at this point, I think we should tell it to abandon what it's about to do.

36:18 - Travis Corrigan (matterflowadvisors.com)
  It's got a fresh context window, so it actually doesn't. Open the conversation summary, the compaction. Control O. Okay. Optional next steps.  current work as executing Cloud PM structures. I'm looking at number eight. Convert 2B0 design and implementation plan into GitHub artifacts.  Okay, so what we're doing is we've sort of skipped over the wiki generation, and we have gone, like, we were using the design doc as the PRD for TB0, and then an implementation plan for that, which is more code and functionality, less behavioral.
  ACTION ITEM: Review Writing Plan skill; adjust to align w/ behavioral coverage - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=1902.5593249999997  Control. Then, and then using that with those gaps, starting to do the GitHub artifacts. So, user asked me to cross-route.  So the writing plans skill, I'll probably need to go look at that and be like, what are you doing here?  Because, go ahead. I mean, I don't need to do it right now, I'll do it for future , but like, it's clearly wanting to get really  tactical really fast.  Yes, it's trying to make an implementation plan.

37:40 - Derek Perez
  And I think the only mistake here was user error. I think I introduced a step zero, literally, and we came in to step two.  Yeah.

37:53 - Travis Corrigan (matterflowadvisors.com)
  Right? So the thing that I, so I think it's recoverable.

37:56 - Derek Perez
  So like, this is what I want to test, is the design doc that it wrote is not a design doc.  It's an ADR. Right?

38:04 - Travis Corrigan (matterflowadvisors.com)
  Can we publish ADRs right now? Do we have a skill? To, no. To, no. That's, We should that's a skill gap.  All right.

38:15 - Derek Perez
  So we don't have that skill. Dude,  skill gap.

38:20 - Travis Corrigan (matterflowadvisors.com)
  Oh, my God. That's fun.

38:22 - Derek Perez
  OK, so what we need, what would be nice right here would be like we went through a brainstorm. Actually, this is the work.  This in my mind is a decision tree. You're going into a brainstorming session, and I actually think it's totally fine to not overfit for what.  And to let that session produce an artifact and then ask the skill to gauge it and say, did we just come up with an ADR or was that a PRD?  Sure.

38:51 - Travis Corrigan (matterflowadvisors.com)
  Right.

38:51 - Derek Perez
  And then if it was an ADR, like it can discern it can discern that maybe based on like depth or whatever.  Right. Now, if it's an ADR, it would be like, great. We're going to store that for record. Done. we're going to draw PRDs off of it.  However many PRDs to make the ADR reality. Right.

39:11 - Travis Corrigan (matterflowadvisors.com)
  If it's.

39:11 - Derek Perez
  It's a PRD, then we just do the PRD stuff, and then we move on to stories, right? And we, instead of putting it in the ADR discussion repository, we would just put it in the wiki.

39:23 - Travis Corrigan (matterflowadvisors.com)
  Yeah, right. Right?

39:24 - Derek Perez
  And so, like, I think that the, but the brainstorming session, I actually think it's kind of cool to not specify it, because that then lets the system decide when something should be in ADR or when it shouldn't be.  And then that way, you don't have to think about that. Got it.

39:41 - Travis Corrigan (matterflowadvisors.com)
  Right?

39:41 - Derek Perez
  Because it's better for you to not worry about it, and let the system say, I think this is cross-cutting, and it's going to be a pool, it's going to be a thing I'm pulling PRDs out of.  Right. Or I'm working on a PRD, and you know that, and then I don't need you to think about ADRs.  Yeah.

39:59 - Travis Corrigan (matterflowadvisors.com)
  Other than referentially. I think that that makes sense, and I think that's a solve for the thing that we've currently done.  I want to actually take one more step back and just go, we actually did start with a, Bye.-bye. Bye.  Product Brief. We did. And that's not even a concept in the current skill, Cloud PM skill. Yeah. Or plugin.  And so really, I think the first brainstorm is like, are we doing a product brief or a feature brief?  And if we're doing a feature brief, then we need to have an existing product. If it's a product brief, then we are starting really from the ground floor.  And then that should probably, so we could probably do a brainstorming session around that. Yeah. And then the second is, I think this ADR PRD, what chicken and egg thing happens because you and I are really good at what we do.  And we're just kind of skipped some steps in a process a little bit, which is like, the product brief that you wrote in capacities is very tech.  It does not describe like the, yeah, like these plugin architectures.

41:20 - Derek Perez
  This is basically features you'd expect to read in the readme of an open source project. Right, right.

41:26 - Travis Corrigan (matterflowadvisors.com)
  And from a product perspective, there's a little bit more in terms of, actually, I don't know.

41:35 - Derek Perez
  Well, like for the most part, remember, I wrote this to feel like a press release.

41:40 - Travis Corrigan (matterflowadvisors.com)
  Yes. Right.

41:41 - Derek Perez
  And so this is just enumerating the features of a project that doesn't exist. Right.

41:47 - Travis Corrigan (matterflowadvisors.com)
  So like what a product brief typically should also have is all of this and the, what are the objectives or what are the outcomes and that we're attempting to generate as a result of this?  What's the business impact here? What is the business logic? What's the rationale for this thing? Why does it exist?  does it You've, you know, what is the problem we're attempting to solve? solve? Thank you. How does this thing solve it?  And then we describe the solution a little bit, right? So this is, this is a little bit more of an architecturally heavy sort of project brief.  Yeah. Because just simply because it's lacking some other things that I would write from the business perspective of it.  Like if I was at a place like Beachbody, I'd have to articulate the business rationale for this  thing. Otherwise it's just like, why are you wanting to build your favorite project is usually what the execs would tell me.  So. Yeah. Go ahead.

42:41 - Derek Perez
  This is like the one sentence I tried to provide to support that was like right there.

42:46 - Travis Corrigan (matterflowadvisors.com)
  No. And it's a great sentence. It's right there. It's all right there. I would just say that like, like, why does this, so as the product person, always you have more people wanting you to build  than you guys, than engineering has capacity to build.  So you always have to like my, my constant scythe that I, or scythe or what I can remember, scythe that I would, knowically It's you got it.  It's It's just like, why does this, why should this exist? Like every feature needs to earn its right to exist, which means that it has to pass some minimum bar of business contribution.  If it doesn't do that, then we're just playing with our dicks. And so engaging, forcing everyone to go through the thought exercise of making that explicit is really helpful defensively from a product perspective with people who, with stakeholders who assume business impact have skipped making that explicit and then are just telling you to build a  thing.  Yeah, just to interject, I totally agree with you on this because that's what happened with Danny and I, right?

43:58 - Derek Perez
  Was like, I was like, oh, obviously I'm reaching for open crawl. And he's like, why the  would we ever need that business justification question?  Yeah, and we have to align on like, what's the business justification here?

44:08 - Travis Corrigan (matterflowadvisors.com)
  What is, what are the mechanisms of the system and what are the, the. The actual, like, what's the interface between this product and the business?

44:17 - Derek Perez
  And so are you asking about that in this context?

44:20 - Travis Corrigan (matterflowadvisors.com)
  No, I'm merely, I'm merely, like, articulating, like, the difference between a PRD and an ADR, in my opinion, is, like, an ADR is more like this in my mind.  And I could be wrong about this, to be super clear about this. And a PRD has elements of the ADR, probably, with the, it addresses the same things that the ADR addresses.  The ADR addresses them, I think, differently. Yes. It's a specific, it deserves to be a specific thing, but it's, there's some overlap in the content there.  There is, there is.

44:54 - Derek Perez
  I think here's another good example I would give you. have another one on my desk right now that we haven't got to, that I was planning to do after this one.

45:01 - Travis Corrigan (matterflowadvisors.com)
  Okay.

45:02 - Derek Perez
  A very good example of an ADR, and I think we may have touched on this before, was, what is the rules for semantic?  Versioning of packages that are there, we have these modular packages, right? Server, config, blah, blah, SDK. All of those have independent version numbers.  And we need an ADR to tell us how those all need to relate so that the system can determine which versions of each sub package are compatible.  Got it.

45:32 - Travis Corrigan (matterflowadvisors.com)
  Right.

45:33 - Derek Perez
  That's a hyper technical requirement.

45:35 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Right.

45:36 - Derek Perez
  That's an architectural decision. We would say, okay, there it is. And then every time that you make feature changes and version numbers need to move around, this needs to be consulted about how to proceed.

45:48 - Travis Corrigan (matterflowadvisors.com)
  Yeah, absolutely. Right. So that to me is an ADR.

45:52 - Derek Perez
  Right. In the same way that what we're establishing, what we did with the brief was we went from, here's kind of our, here's our wishlist of what we want the project to be.  Mm-hmm. But, how the, and that was why we went to the tracer bullet thing. How... Do you facilitate the delivery of features like this, right?  And so that to me was the ADR in question. ADR1 is essentially what is the architecture of the code base such that feature PRDs could be woven into it, right?  And so like now, so like what I think we ended up with was TB0 is ADR1, as it calls it, TB0.

46:42 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Faceable at zero.

46:44 - Derek Perez
  And I think in a sense, actually, I think it knows we're doing this and it's thinking of TB0 as roughly what we were analogizing.  And so now what I expect is for every major feature component of, let me pull it up really fast.  Every major component of that initial design that it came up with, what it called the design. And I think also we're...  We are tripping the  over on language here, just to be clear.

47:15 - Travis Corrigan (matterflowadvisors.com)
  Oh, totally. Right?

47:16 - Derek Perez
  But what this is, is essentially the ADR contents. And so what I think we need is for every one of these packages in the dependency graph, there is a PRD.  Like, how did you build that? Right? Or what are the product requirements for Hadron's CLI? What we know is where it goes.

47:38 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Right? Right?

47:40 - Derek Perez
  And we know dependencies that we think are essential for it to exist, but we do not know anything else in this definition.  Like, literally, that's the end of it.

47:53 - Travis Corrigan (matterflowadvisors.com)
  Right?

47:53 - Derek Perez
  So, like, if I go look at Hadron CLI, this is mostly talking about, like, here are some ideas of, like, commands we think are going to exist.  Mm-hmm. But this is nothing. Right? Right? This is just like as far, and I guess like this is kind of the, I mean, this is why I think ADRs being iterative makes sense because it expects there to be other tracer bullets.  created that tracer bullet zero, tracer bullet one, tracer bullet two concept. And I think it realizes that there are more PRDs and potential ADRs to consider, but ADRs only kick in when you have something that's like extremely cross-cutting to the infrastructure of the project.  Where PRDs are more about like, how do I actually flesh out what the Hadron command is?

48:47 - Travis Corrigan (matterflowadvisors.com)
  Yeah, got it. Right?

48:48 - Derek Perez
  Because that's where I think your business case makes a lot of sense. What's the business case for adding the sub command to the Hadron CLI?

48:55 - Travis Corrigan (matterflowadvisors.com)
  Yeah, I mean, I think to zero this out, I think, I always think in terms of like, what are the business requirements?  And then what are the product requirements necessary to meet those business requirements? Yep. And then what are the technical things that we need to do at varying levels of granularity from architecture down to unit testing that need to be in place to support the product requirements, which support the business requirements, right?  Yeah. So what we skipped over, and this is my fault, like we didn't write business requirements, like, and it's a little, because you and I can like do that, that connection on the fly.  Yep. And I think for me, that's the difference between like a PRD and, like a PRD does need, a PRD to me, difference between a technical PM and a regular PM is that a regular PM should be putting KPIs next to requirements.  Like when we ship this thing, we expect this KPI to move this way. Yeah. Like it really does put it on the product manager to.  Be very direct and causal about ship software and business like results. How does that work though?

50:21 - Derek Perez
  Like, I think that makes sense, but like in this particular kind of project, I don't like, what is the metric that we would even identify that Hadron is addressing?  Like, it's really, like, I could maybe imagine some, but in my mind, a lot of this is R&D and it doesn't, it hasn't, reached a sort of lapping point to establish KPIs.

50:47 - Travis Corrigan (matterflowadvisors.com)
  That's right. And not every project, and I think this is the difference between technical product management and like, right, like vanilla product management is that technical product management sometimes gets a pass on needing to make that causal connection between the  that you're shipping and the stuff that like the software, right?  Yeah. It's sort of taken out of the PM's hand, the technical PM's hands, and they just really don't need to think about it or worry about it.  But some other person needs to worry about that. Right. And the org. Right. So like, so for all this, like, I mean, it really does come down to like, oh, it does need to come down to what I would say is like a PRD back and forth.  Like if I did a brainstorming session with this, I would like it to be like, the first thing is like, all right, well, talk to me about your, talk to about your business.  Like, give me a, give me a gist of the idea. And then based on that, let's figure out the business requirements.  And like, if you don't have them, you can just skip them and you just make a decision to skip that part.  And then we can get into business requirements or get into product requirements, then technical requirements, and then technical decisions like architecture and then taste and a bunch of other .  Yeah. Okay. Just to share with you how I'm organizing this, some parts that we can skip. right.

52:12 - Derek Perez
  I think that sounds right. That lines up for me too. I think this is a really interesting project to test this whole theory on because it is a cold start problem.

52:22 - Travis Corrigan (matterflowadvisors.com)
  Very cold start. And it's like, it is like, it's business contribution is about how much more efficient can we get through.  It's really just about delivery execution, like delivery efficiency. Yeah.

52:36 - Derek Perez
  But, but even then, like, we don't know yet what we're going to deliver with Hadron. So we don't know how to measure it's that this is, this is one of the things that I run into a lot of Google with this sort of thing is like, it's very hard to write.  And that's why it's a TPM versus PM sort of thing. Like, it's very hard for a framework to immediately justify KPIs.  And we ran, actually ran into that kind of, that kind of static politically all the time because they would say  like that.  And it would be like, well, I can't really justify inventing. And like, I mean, honestly, that CLI tool that I was, that I, in this blog post, right?  Like, I guarantee you that somebody told them, I can't justify this. And so what did they do? If you go look, it's interesting, they're in their own workspace for Google Workspace, their own GitHub org.  And down here, this says, this is not an officially supported Google product because it doesn't have any KPIs. Right?  Yeah. But that doesn't mean that there isn't paid employees working on this for the betterment and enrichment of this business.  Right. it's hunting for, like, honestly, though, I kind of think I disagree with myself because the KPIs I could argue here is that API calls are increasing, which is improving retention.  But like, good luck proving that.

54:02 - Travis Corrigan (matterflowadvisors.com)
  Well, I mean, but it's important to go through the, I think this is the point that I make usually with product managers and everybody else, you know, people like you who's just like, okay, great.  Just write. Like, yeah, yeah.

54:13 - Derek Perez
  Well, and that's, that's where I'm saying, I think that's, this is shorthand to Google for that exact thing that I'm talking about.

54:18 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Which is like, we don't, it's a product hunting for a business. Like it's a, it's a problem. It's a solution hunting for a problem.  And oftentimes this is the big thing that I ran into with product managers. I was like, you are not allowed to fall victim to the solution, looking for a problem thing.  Like if you have allowed payroll to be given to engineers, for that kind of thing, you have failed your prime, one of your prime charters as a product manager, because you have just made it less likely for the company to continue to pay those engineers in perpetuity.  Yeah. We don't know, we can't, we cannot recoup that investment. We, we don't know how, and that is a bad decision.  And you are bad, like that, that's, that's not the engineers. That's not their job to think or worry about that.  That's not their job. Yeah. so I think that, I think.

55:11 - Derek Perez
  that's a good, this is a good reminder of like, that's, I think your structure is correct. And that is one that we should follow.  If we can make it collapsible or modular to the types of projects, I assume there'll be other projects like Hadron, like, for example, where we wouldn't have this problem, is probably in defining the work for like the open crawl system.  There's very clear business cases for that.

55:35 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Right.

55:36 - Derek Perez
  I think the only reason this is, and I think this is why it's a red herring for this problem right now, is that Hadron is a framework and the open crawl thing would not be a framework.

55:47 - Travis Corrigan (matterflowadvisors.com)
  It's product. Yeah. Right.

55:49 - Derek Perez
  And so I think that's like a really good point you're making because this really continues to stress test our platform for more than just one kind of product problem.  Yeah, that makes sense.

56:06 - Travis Corrigan (matterflowadvisors.com)
  But I also do, yeah, no worries. Okay. Sorry, I wanted you to tell me you said it on beach.  Okay. Yeah. So that's actually a great point that like frameworks have very vague and indirect connections to business outcomes.  Well, we, we have some, we, some wishes, right?

56:38 - Derek Perez
  We wish that this will be more token efficient, right?

56:41 - Travis Corrigan (matterflowadvisors.com)
  We don't know that we should write that down, right? Like we should, Oh, it's in here. Uh, I thought I did.

56:56 - Derek Perez
  Well, token. Uh, no, I didn't. I thought it did. Perhaps, perhaps it was, it's, it may just be like, it was in our hearts, tailored to agentic coding systems in which coding agents handle a lion share of mechanical coding debugging tasks with human.  Yeah.

57:12 - Travis Corrigan (matterflowadvisors.com)
  It's all here. It's just, it's implied. And I think that's the point that like product managers are constantly need to be the people around, which is making that  explicit.  Yeah.

57:23 - Derek Perez
  But I mean, like, to me, that's probably like the other one would be basically an argument about evals where we would say, if I asked Claude Code to write, and we talked about this actually, is like, if we came up with like, what sort of our smoke test, is it like build a CRM or something?  And we said, it once without Hadron and do it with Hadron. then eval, which, you know, on a, on a rubric of, was this more successful?  Did you complete the task? Did you do it with less?

57:52 - Travis Corrigan (matterflowadvisors.com)
  Was it cheaper for you to do that? Did it create a higher output?

57:55 - Derek Perez
  Was it temporally faster? Like, I just don't even think we, like, this is, that's why I was asking the question about R&D.  Because in my mind, this is so not clear yet, what I would even measure until we have a baseline to measure.  And they're like, okay, now that the germ of this idea has crossed past the R&D phase, now it's got to a point where in order for it to be production or mature, we need to have clarification on what those kinds of KPIs are, that this is worth going from prototype to production.  That, I feel like, would be how I would frame it in this context.

58:35 - Travis Corrigan (matterflowadvisors.com)
  Yeah, totally. And I think that, I think that, I don't know, I think, I think that the problem statement is that it has three, three legs to that stool, I would say, Hadron.  If you put a gun to my head and you go, hey, you haven't thought about this as hard as Derek has, but like, Derek and his family dies if you don't get this answer right, right?  And the answer is, what are the three, if you had to name three things around what the problem statement is and what the solution for that.  What Derek has on the screen in front of you is a solution to what is that problem? The problem is that vibe coding is not effective for production grade applications.  You cannot one-shot an actual production grade application in a single vibe coding session. A vast majority of, so it's a...  Hey, there's more, there's more to using coding agents for software development than vibe coding than one trying to one shot an application is basically what I'm saying.  I think that's all right. That's problem statement number one. Problem statement number two is that a vast majority of coding, using the coding agent, token efficiency is important.  Meaning that for real projects, you will exceed a single session's context window multiple times as you go from idea to production.

1:00:59 - Derek Perez
  I'd say today's existing popular technology frameworks and solutions will quickly exhaust even the largest token. Context, Windows, and Token budgets costing real money and accuracy of results.  That's what you're saying.

1:01:24 - Travis Corrigan (matterflowadvisors.com)
  Absolutely. And then problem three is the reliability problem with coding agents, which is they don't always do what you ask them to do.

1:02:03 - Derek Perez
  Many, this is for me a pretty clear one. Many systems that were intended to be. Driven by humans have varying levels of implicit knowledge baked into their usage, which can cause coding agents to act erratically when not when the task is not obvious or well defined or sufficiently complex.  It's not well defined or sufficiently complex. Yep. So like, I think that's right. And I think even in this production grade one, like a lot of stuff is hiding in there.  Right. Like there's more we could say about like things like, Hey, Like, automatic telemetry is really important, right? Because, like, when a thing's running, how do you know if it's successful?  Yeah, exactly.

1:03:18 - Travis Corrigan (matterflowadvisors.com)
  Like, over time. Yeah. Right?

1:03:20 - Derek Perez
  Or, like, this one, these two, these two are semi-related, but this is, like, if you had to summarize, so, like, now do this, summarize this into one word each.

1:03:37 - Travis Corrigan (matterflowadvisors.com)
  Yeah, so, um, yeah, multi-shot.

1:03:47 - Derek Perez
  Okay.

1:03:52 - Travis Corrigan (matterflowadvisors.com)
  Token efficiency, or token economics. Or, frankly, I would even, you could even just say, yeah, cost. Oh, so, PS1 is complexity, actually.  There we go. That's what I'm marching for. Complexity, class reliability.

1:04:15 - Derek Perez
  Yeah, like that sounds accurate. My family gets to live.

1:04:19 - Travis Corrigan (matterflowadvisors.com)
  And by the way, we didn't, I would never expect to have written this. And frankly, was not a stickler about it, because we talked about it so much that when I read this, was like, yeah, of course, this is the solution to this thing we've been talking about for a long period of time.  So this is like, I've actually failed as the PM here to be like, hey, we should slow down and just make that stuff explicit.  And that's, I think the difference between an, like a product requirements document just always has to be giving, tipping it.  I always have to be answering to the chief financial officer and everything that I do, basically. No, I think this is good.

1:04:53 - Derek Perez
  I mean, yeah, I do think you're right that this was just something that we were in this. By the way, this is a good example of humans being implicit.  I think we were just, we knew that we both knew this, like you said, we just never wrote it down.

1:05:05 - Travis Corrigan (matterflowadvisors.com)
  And like, yeah, we did. Yeah. And I think that's, that's the difference between a product requirements document and And any other kind of requirements document is that the product has to be able to have a section that connects what we are describing to build as the answer to how we are going to solve the what of the business problem.  Right. So like we, uh, we have a business problem. The, we have a complexity problem. We've got a cost problem.  We've got a reliability problem. We propose as a solution to these things, this product Hadron Hadron does basically the, like this thing and solves these problems in this way.  And these features all aligned to one or at least one of those three problems. And like, that's the thought exercise that like a PM really.  Really needs to do to be good. And it's tedious as . And you're like, why the  do we do this?  And it's implicit. And the reason why is that like, when you get far enough into these projects, you forget why the  you were doing it in the first place.  And you get these arguments about scope and time. And like, you forget why any of this mattered. So it really is helpful to kind of just literally write it down and make it explicit.  So that you have something to point back to around alignment around, Hey, we have to make trade off decisions, which Which option in this trade off is best aligned to the  problem statements.  Yeah, right. So it's tedious, but you find that it's like, it's tedious upfront, but it's really helpful once you get into execution.  And this is like, again, in a world we are where we are using mostly humans to do all the stuff and we disagree on these things.  Yeah. So that may or may not apply as much in an agentic world. And it may or may not apply to this project in particular, but that's how I  We'd sort of think about the, like the order of operations or the con ops requirements to ADR. Yeah. Like an ADR doesn't care about this.  ADR does not give a . It takes that  as given. Like we've already, like we, it's so, we've already had that conversation so sufficiently.  We don't even need to load that context into the ADR conflict. Like, like, yeah, it's, it's assumed that any ADR is already addressing the problem statements.

1:07:44 - Derek Perez
  I think you're totally right.

1:07:45 - Travis Corrigan (matterflowadvisors.com)
  Yeah. And that problem is that that problem is sufficient and is worth working on. Yeah.

1:07:50 - Derek Perez
  Yeah. Like that's, that's all prerequisite to even get to one. Yeah.

1:07:55 - Travis Corrigan (matterflowadvisors.com)
  And I think this is the issue that I think a lot of product junior product managers run into is that they, they need to have the backbone to be like, does this problem, is this problem worth solving?  Mm-hmm. having the backbone to push back on people in a higher. Positions of authority than them. Like the, the shiny objects, executive shiny object syndrome, you know, not the engineer.  I've heard plenty from engineering managers and engineering teams, how  tired they are about executive whiplash. And that as a, as a one thing that product should do is be a buffer against that.  And one way product buffers against that stuff is just reverse UNO's the  excitement of, the new train that the executive wants to build.  You're like, okay, great, my guy, but you have fiduciary responsibility to this business. So I'm holding you accountable to that because I, you hold me accountable to that.  So like, we got to  nail down what actually is the problem here and like how we've measured that problem, what its current state is, and then what we think its future state will likely be when we build this thing.  And what is it about these things, the bullets of the  where the features we're going to build, how do each of these core numbers.  Respond to solving the problem such that we get the net lift from current baseline to what we think it's going to be in the future, right?  That like product really is there to be sticklers and , like sticks in the mud with everybody to be able to articulate that as a means of earning the right to get engineering's attention on even the architecture stuff of it.  Like you just, you don't earn the right to like consume our precious, the most precious resource inside of an organization, unless you can like show that you are the minimum height to  ride, right?  Minimum height of writing is like literally write out the logic. Yeah. Okay. So I'm off my  TED talk there.  We, we, now that that exists, we can skip that as much as we want, right? For ourselves, not a problem.  But I am bringing this up because I'm curious to get your thoughts about this because some of this is like, what do we.  Let's update the cloud PM slash limbic thing with, right? This is a little bit of like our taste making around this is that everything that I have just said is a pretty solid ironclad law.  And like all ironclad laws, there are exceptions to those rules. And I think definitely there are times in which we can take those exceptions and that's in good taste as well.  But I want the limbic system to be able to be able to have that range. Yeah. Not be so rigid around a particular way of doing it.

1:10:48 - Derek Perez
  No, that's what I was saying earlier about like, what I'd like is for the full spectrum of your ironclad rules to at least be a checklist of things that we say, okay, we're intentionally skipping this and that should be documented.  Right? Like, hey, we don't have a problem statement for this because this is an R&D project or, hey, we don't have a problem.  And like, and you could even, I mean, you could articulate a list of choices. This is give me a fill in the blank.  Right. But like, this is like, in a sense, like a, a readiness checklist, like a readiness gate. Yep. To be like, okay, if you don't have an answer to that, you should actually go brainstorm and come up with an answer for that.  And then we'll fill that in. And then we'll move on. Yeah, exactly. So like, I think that's, I think that's totally fine.  Right. And so and I do think you're probably right that there is probably almost always we're unlikely to ever even in R&D.  not have a problem statement, we may not have KPIs. And maybe that's, that's an example of like, we have a problem statement, we don't know how we're gonna measure it yet.

1:11:51 - Travis Corrigan (matterflowadvisors.com)
  Yeah, totally. And that's totally fine, too. You, you, it's not KPIs are not stage relevant. I mean, if anything, you probably just like, let's just pick some heuristics, which we did, right?  Complexity, cost, reliability. Those are heuristics. Yeah. Right.

1:12:05 - Derek Perez
  And so if it matured further, and then like, let's say we're gonna make changes to it, we might then say now that we've established,  Like here's what an average Hadron project costs in terms of cost of execution. Here's its reliability in the field.  Here's how complexity looks like this and the actual output of our SDKs. And then we can say, okay, great.  We think these need to be better, but we can't say better yet because it doesn't exist as the comparison point.  And so that's where like, I think that makes sense. So as a system, it should always inquire about our KPIs there, our problem statements there.  And because you could end up like what I think the most valuable thing and why I've been slow on Hadron with you to do this is that the cold, what we've experienced in the session is how unique the cold start loop is from even the very next one.  And so this is identifying a lot of implicitness. Yeah. bad I Which is worth slowing down to observe.

1:13:16 - Travis Corrigan (matterflowadvisors.com)
  Yep.

1:13:17 - Derek Perez
  And so that to me is why it's like, well, I'm not so happy with the fact that Hadron's still just in my mind.  I'm dying to get it out. But I am also even more excited about the lessons learned we have right now on the systemization side of this.  So it's totally worth it. Yeah, for sure. And I appreciate you hanging in there with me about that.

1:13:36 - Travis Corrigan (matterflowadvisors.com)
  Yeah. So given that, I think, because, yeah, you said a thing, how we got here in my mind is you said, okay, we have an ADR and then we hang PRDs off of that.  And I go. Or we could. No, you know, totally can. But like, in my mind, a PRD has at least a problem statement and like some nod to like some sort of financial outcome.  Okay. And I'm willing to let go of that. Because again, as you said, the ADR does not give a  about the problem statement.  It just assumes that that's all solved, right? So if we're studying in our ADR, but haven't articulated a problem.  Well, hold on.

1:14:30 - Derek Perez
  I think that's not exactly correct. My recollection of this is a little different.

1:14:35 - Travis Corrigan (matterflowadvisors.com)
  Okay.

1:14:35 - Derek Perez
  Where we are because of the cold start loop, right? Is that as it sits today, like this repository has nothing in it.  Yeah. Right. And so we need to cold start the system enough with tracer bullets to say, here is the thing.  Yep.

1:14:57 - Travis Corrigan (matterflowadvisors.com)
  Right.

1:14:58 - Derek Perez
  And so maybe what we're actually saying here, I'm kind of curious if this is your perspective of this, is in lieu of problem statements, an ADR could be used to.  Cold start a PRD in the absence of one, because in the moment, what we have is, here is technically how we need to lay out the project to start unlocking the value of the key features that we've identified.  And for example, the plugin-first architecture stuff needs an entire PRD, right? And the problem is, we can't even begin to require for that, because there's nothing that it can go into, right?  And so the initial ADR is about, effectively, the rules of engagement in the code base. Sure.

1:15:54 - Travis Corrigan (matterflowadvisors.com)
  Right?

1:15:54 - Derek Perez
  And so without that, so in a weird sense, the problem statement is like, there is no code base. That's, that's correct.

1:16:03 - Travis Corrigan (matterflowadvisors.com)
  Yeah. It's, it's agnostic of the solution. Yeah. Yeah. And the solution can be, hey, we send carrier pigeons, and that's token efficient.  Right, like it's a glib example, but like I think that the discipline I've always tried to have as a product manager is just like hearing everyone's excitement about the  that they think this thing needs to be and just go, okay, great, hold on a second.  Let me just like ground in the fact of like, what is the problem that we're solving? Like walk me through the moment that you're like, this should like this, something doesn't exist.  It should exist. And then tell me about that moment that then led to all the things you just excitedly told me about the things, the features of the solution that you want to do.  So I think a lot of people run right into solutioning sort of prematurely. Yeah, that's okay. You are, you, in your hands, you know, I don't, I, I would, I would trust you.  To do all that stuff because you're just great at business in general. So you skipping over that is like not, I don't have like a dogmatic thing about it, but I do think about like the difference between, and I'm happy to just sort of set this aside.  We're building this for ourselves. And if it's only just for us, but other people can see and use it, great.  Or do we want to build a thing that like works not only just for us, but maybe for other people who are not us, right?  I don't care about other people.

1:17:45 - Derek Perez
  If you recall back to the iPatch world, there are no other people anymore.

1:17:49 - Travis Corrigan (matterflowadvisors.com)
  Okay, great. So like, I am, but, okay, go ahead.

1:17:54 - Derek Perez
  Having said that, yeah, to be clear, I never expect this to be for anyone else, but our projects. This is, this is IP for us.  This is, this is a CNC machine.

1:18:03 - Travis Corrigan (matterflowadvisors.com)
  Well, yes. Yes, yes. Claude PM, maybe. No, that's right.

1:18:09 - Derek Perez
  And so like, that's, but that's why we're actually doing this. In this scenario, because we won't even know, like we have the, we have a different cold start problem with Cloud PM, PMing itself right now.

1:18:18 - Travis Corrigan (matterflowadvisors.com)
  That's right. Yeah, exactly. Right. Which is how we ended up here. Yeah. Right. I don't even have a problem statement for Cloud PM.  So it's not a big deal. Like I, I mean, I have my own center.

1:18:27 - Derek Perez
  I know you, I know you could come up with one in a second. Like I, and like, that's not the problem, but like, even in like the example of plugin architecture, I can type plugin architecture as a solution that ties back to all three problem statements.  Yeah, absolutely. I could, but the problem still is to actually, and maybe this is, maybe this is where we're, we're running into a problem because of, again, my lack of clarity on language a little bit.  The PRD for what is almost advocating for why there needs to be a plugin first architecture, right? And, and I can say it's about cost efficiency.  It's going to be a smaller scope. It doesn't have to read an entire project. So it's obviously by definition going to be more token efficient.  And I. I have evidence of that from Medusa, right? Yeah, for sure. And that's why a lot of this is cribbing directly from Medusa.  Yep. From a reliability perspective, that has to do with how you're actually implementing the stuff in the plugin architecture.  And the tough thing here is the product is code, but the user is not us. Right?

1:19:32 - Travis Corrigan (matterflowadvisors.com)
  And so you have to keep that in mind.

1:19:34 - Derek Perez
  And so complexity is for the agent. Right? And so that's where, in my mind, all of the things in like, and that's why I'm saying the PRD needs to really go into like, what is a plugin?  Like, what are operations? How are they defined? Like, you know, all these things are not solved, as far as I'm concerned, in the document that we were looking at, that it called TB0.  That's not in here. Not even close. And so, like, that's what What was saying is like, what I have in here is this, this is the closest thing I have.  And all that it is, is a folder called operations and a call out for deferred to TB1. Yeah.

1:20:23 - Travis Corrigan (matterflowadvisors.com)
  Right.

1:20:23 - Derek Perez
  And like, what's in this folder? What are those files like? How do I test those things? All of that is missing.  The only thing that's here is the existence proof of a concept that needs to be defined in a PRD.  Yeah, for sure.

1:20:41 - Travis Corrigan (matterflowadvisors.com)
  Right.

1:20:42 - Derek Perez
  And so like, that's why in my mind, I would think of this falls closer to ADR because we're, again, establishing the rules of engagement for the code base.  Yeah, that makes sense.

1:20:52 - Travis Corrigan (matterflowadvisors.com)
  Because like the ADR, I think the thing that's challenging about this is that Padron is not a traditional product, as you've said.  No. Which means that the overlap between the wiki and the ADR is actually incredibly high. Because if you're hanging PRDs off of an ADR, then I'm like, that sounds like a...  So in my sort of smooth product brain, was just like, that sounds like a wiki then. And then I was like, oh, they're probably both.  And, and also, I think, I don't think you hang every PDR.

1:21:24 - Derek Perez
  Sorry, I don't think you hang every PRD off an ADR. Not everyone. I think you have, that was what I was saying before.  I think you have to do it in lieu of an alternative because of the cold start problem.

1:21:35 - Travis Corrigan (matterflowadvisors.com)
  Right.

1:21:36 - Derek Perez
  Right.

1:21:37 - Travis Corrigan (matterflowadvisors.com)
  Like, I don't think that ADR, how you figure out what the wiki is, is going to require a bunch of ADR stuff anyway.  So yeah, I mean, yeah, this is a cold start chicken, egg. It's like cold start and chicken and egg at the same time.

1:21:48 - Derek Perez
  Which is what I like about ADRs because the only thing about them that is organizing as a principle is monotonic growth.  A decision was made. And at this point, a decision was made and it impacts, it may or may not impact additional PR PRDs as needed.

1:22:06 - Travis Corrigan (matterflowadvisors.com)
  Yeah, that's what's, that's why I like this.

1:22:07 - Derek Perez
  It's like in Monopoly when you have like community chest and you have chance cards. Yeah. It's like, they're both part of the game, right?  And they play different roles, and you're not using both of them all the time, right? But I think that more often than not, when the thing is established, and you're doing iterative reps on feature development, you're going to be strongly in the PRD zone, right?  And the need for ADRs is going to decline, probably close to zero, because the architecture is defined. Yep. Right, it's only when something comes up that is not well-defined, that isn't necessarily a product requirement, that you would reach for an ADR.  You'd also reach for an ADR if there was, like, something that wasn't business-oriented, that there were multiple potential competing proposals for, and ADR is a decider.  Like, it's the decision to select one of the proposals. Got it, okay.

1:23:09 - Travis Corrigan (matterflowadvisors.com)
  But that is unlikely to come up a lot.

1:23:11 - Derek Perez
  Yeah. you. you. That's just like what the world uses them for.

1:23:14 - Travis Corrigan (matterflowadvisors.com)
  Yeah, I would say that the other thing that's really interesting that I'm making an observation here, and I'll just say it for the benefit of the transcript, is that is this question of who's holding who?  Is the agent and Claude PM supposed to be holding us and guiding us through the process, and we're supposed to be following it, or is it supposed to be a good collaborator for us even when we break process and kind of go out of sequence, right?  So, like, if it is too rigidly expecting a PRD, then an ADR, then we're going to be spending a lot of time fighting against it in terms of the early stages of creating the project itself.  Yeah. And sometimes we just want it to be like, no, I'm actually just going to... Like, kind of cowboy this  a little bit.  I'm going to do the ADR first, and then let's use that to then, like, build out the wiki and then build out the PRDs.  Yeah, and I don't even think it's cowboy.

1:24:28 - Derek Perez
  I truly think it's a decision tree. Like, in lieu of an alternative, it's there. Yeah, right.

1:24:33 - Travis Corrigan (matterflowadvisors.com)
  Right?

1:24:33 - Derek Perez
  Like, I don't think it's, I don't think that it's actually that much of an exception. It's just a corner.  Right?

1:24:40 - Travis Corrigan (matterflowadvisors.com)
  It's a true corner case.

1:24:41 - Derek Perez
  Of, like, most projects aren't starting from nothing. Like, in a well-defined process. So usually it's like, look, I got this, like, to a point, it's initial import, a prototype, and then we start productionizing something, right?

1:24:55 - Travis Corrigan (matterflowadvisors.com)
  Yeah, right.

1:24:55 - Derek Perez
  So this is just pushing that system all the way to the edge of the concept.

1:25:00 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

1:25:01 - Derek Perez
  And then we're feeling the reality that, like, that's why this is typically underspecified. Right? And, like, I don't think that's inherently bad.  I don't think that we've done anything wrong. wrong. don't done anything wrong. I I think that's just the nature of the system.  So that's why I don't even think about it as cowboy. And I just think of it as like, we could not, and this was what I was kind of voicing to you before was like why I wrote this doc was I was like, I don't even know how to communicate a PRD in context.

1:25:31 - Travis Corrigan (matterflowadvisors.com)
  Right?

1:25:31 - Derek Perez
  Like that's why this is in the way that it is, because this is a breath first attempt to try to at least shape a constellation within a galaxy.  Yeah.

1:25:44 - Travis Corrigan (matterflowadvisors.com)
  Right. And then to say, great.

1:25:45 - Derek Perez
  So these things exist, right? How do they, how do they interrelate? What do they do? I don't know. But like, there are these things.  You have a plugin architecture. The plugin can do these things. Once you have a plugin, the server can automatically serve operations out of that plugin to humans and agents.  And then as a human, you might want to have some like knobs and levers that you want to poke and touch sometimes.  So there's a place for that to go. And oh, Sometimes when you're working on a project, you need to serve files that aren't part of the plugin necessarily.  And oftentimes it might be things like robots.txt or LLMs because it's a web server. And because this is being built by humans and agents, there needs to be a command line tool because that's how this world works.  And as part of that, we want to make sure that working with that CLI tool and the project is as seamless and token efficient as possible.  So we want to make sure there's a local dev server and it has hot reload. So we're not tripping over running servers and having to compile and have build steps.  Oh, and also whenever things go wrong, there's going to be a way for the agent to pull debugging information.  So it knows how to address the issue in a token efficient way without having to like go scan the file system looking for log files.  And when there is a problem, sometimes we can preventatively identify those and identify those using heuristics. And we're going to do that.  And when you're done, it's really easy to deploy. And Oh, also, we have agent skills so that while it's doing all this stuff, it's been pre-trained on how to actually execute and be successful at these tasks.  That is the brief.

1:27:21 - Travis Corrigan (matterflowadvisors.com)
  Beautiful. Right? And so that's where I'm like, great.

1:27:24 - Derek Perez
  But like, I could never, I could never in a million years go, let's go deep on plugin architecture without any of the rest.

1:27:34 - Travis Corrigan (matterflowadvisors.com)
  Right? Sure.

1:27:35 - Derek Perez
  And so that's, to me, why the thing I reached for instead of a PRD in this moment was an ADR.  Because an ADR is about setting the rules of game.

1:27:45 - Travis Corrigan (matterflowadvisors.com)
  Yeah. And I think, I think this is the, this is the, I think this is what's beautiful about you and I, right?  Is that in you reach for the tools that you reach for to resolve irreducible uncertainty, which is an ADR, I'm going to reach for a PRD.  And I think that both, both work. And I think what we're discovering is that we can, we should have at least a tool chain.  Thank you. you. Thank Thank That allows both of us to play well, because we're both, we're both approaching the same problem from our respective strengths.  Like you are a technical God. I am not. Right. And I have different things that I'm sort of more of the, the behavioral side of like, irrespective of the specifics of the technology, like plugin versus non-plugin.  Huh? Like you have to have the ability to like load in features pretty much. like, I would call that modular feature loading.  Right. Plugin is a really specific way to do that. But like, I don't know the differences between plugin and non-plugin architectures.  Like I just got, it needs to be modular. Right. That's the level of abstraction that like, I'm basically going to get to.  Yeah. And I think that, so it's just, you know, your side of the coin, my side of the coin.  And I think, I think it's beautiful. I think it's, it's really awesome. And I think what it's clear to me now is that.  Future versions of limbic need to be able to play for both. Like they need to be able to support you and reaching for an ADR.  And for me, maybe reaching for an ADR as well, even though I don't think I'm going to do that as well as you would, I would probably reach for a different artifact to sort of constrain the things into something discussable.  Let me, let me give you another good, like, I think that's fine.

1:29:38 - Derek Perez
  Right. And like, and I think you're right. Another good example of an ADR would be like the moment where you decided that conventional commits are the only way you want to do things.  That's an ADR.

1:29:49 - Travis Corrigan (matterflowadvisors.com)
  Got it. Yeah.

1:29:50 - Derek Perez
  Like it's literally just like a ledger of like architectural decisions about the project and the contents. Yeah. Okay.

1:29:58 - Travis Corrigan (matterflowadvisors.com)
  That's, that's when you reach for them.

1:30:00 - Derek Perez
  Right. Because then it's like, well, where was that decision recorded? Sure. What, what, like, what contract can you point back to when something about the project isn't followed?  That doesn't fit in a PRD, right? And I'm, by the way, I'm not convinced that this couldn't have been a PRD, right?  It could have, yeah.

1:30:22 - Travis Corrigan (matterflowadvisors.com)
  I think. And it still can be.

1:30:25 - Derek Perez
  Yep. And the problem I'm at is like, this is still way too high altitude for me, right? Yeah. Like, we're at the highest altitude in the brief.  The highest altitude, I'm literally just like pitching. Here, right? This is the next highest altitude, but it's still way too high.  Yeah. I need the altitude of like power plugin. Like, even, even, even the sub bullet. I want an operations PRD.  Right? So that was why I was like, I don't, and I don't know. How do I get there? Sure.

1:31:08 - Travis Corrigan (matterflowadvisors.com)
  Sure.

1:31:08 - Derek Perez
  And so that's why, and that was the other thing about, if you remember how this whole, Everything started was about, I was explicit with the brainstorming engine that I wanted to do tracer bullets, right?  And the reason for that was so much of this was undefined. Totally.

1:31:23 - Travis Corrigan (matterflowadvisors.com)
  And we define it by taking action, for sure. we don't want to, like, yeah, we want to escape sort of the ability to get into analysis paralysis on some stuff.  Well, not even that, just literally, like, where are the boxes?

1:31:35 - Derek Perez
  Like, I didn't have this dependency graph in my mind.

1:31:38 - Travis Corrigan (matterflowadvisors.com)
  Right. I did, I did not know.

1:31:40 - Derek Perez
  I, like, I wrote this down having absolutely no clue how this would work. Right. And so this, in my mind, this was, that's why I was, that's why I think of this as an ADR in some sense, because this is making architectural decisions for me.  Yeah. That I had no answer to.

1:31:58 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Right.

1:31:59 - Derek Perez
  Like, I didn't know that this was how it would, like, I like this decision, but again, like, this is such a pinhole.  What are all the properties that this thing can take? What Sure.

1:32:13 - Travis Corrigan (matterflowadvisors.com)
  Yeah. I totally hear you. And you know, what's funny is that like, I listened to all this and I look at your capacities thing and I go, that is a layer of abstraction below my comfort level.  Like I, I, I stop one layer of abstraction higher than what's in, uh, than this. If you asked me to write a document like this, I don't feel comfortable.  I don't. I, I can, I can, you let me write that one level of abstraction higher. I feel confident about that.  And then I go, here's what I'm trying to talk about. And here's how this connects to the business .  But you, Derek know that modular feature architecture has five or six different like schools of thought about that. You're going to, you, you know, more about, you've forgotten about them more than I'll ever learn, but it's gotta be modular.  Right. Yeah. Yeah. And then, you know, Events and subscribers, like the PubSub thing,  brilliant. And the, let's see, the local server thing, like the dev server.  I was like, yeah, I need a quick sandbox environment to sort of have quick feedback loops without needing to do a deployment.  That's how I would describe that. But you're, you know what I mean? That's a layer of abstraction that I think is too high.  Like, you're like, what? I already know. Like, don't, I don't need to think of that layer of abstraction because you have such a command of this clay.  Yeah. You can already pre-filter to the two options that are probably going to be good because you are a master of all of that detail.  Like, the level of detail and level of granularity, I never will be. This is what I love about you.  But me too.

1:34:04 - Derek Perez
  Likewise, I actually prefer that you don't. And like, this is really good. And that's just to really, like, tie back to our conversation with Wendy.  you. That's why I said it the way I did. I want Danny, the stakeholder to talk to you. And then you do what you're talking about.  And then you talk to me.

1:34:21 - Travis Corrigan (matterflowadvisors.com)
  And then I do this. Then you do that. That's right. Yes. Right.

1:34:25 - Derek Perez
  And so like, I actually think that there's a high probability that we're going to go through this cycle very soon.

1:34:31 - Travis Corrigan (matterflowadvisors.com)
  So I would say that I would, I would call this as a TRD as a technical requirements document. The product requirements document is probably one layer of abstraction higher.  And frankly, I'm splitting hairs at this point on semantics. I don't give a . no, I think this is great.

1:34:45 - Derek Perez
  Cause like, this is going to be how we do this. Yeah.

1:34:48 - Travis Corrigan (matterflowadvisors.com)
  Right. Right.

1:34:49 - Derek Perez
  And so I think that's fine with me. I honestly didn't know what to call this thing. That's why I called it a brief.  Cause I was like, I have no  clue what this is. I'm just literally just trying to show us a, a, like a brush stroke.  It was great. Right. And like that's where, and that's again, here, this is still now where we went from brushstroke to tracer bullet.  But there's so much depth missing from this document. And that's why we just saw it kind of  up because it went from this to plan to stories.  And then it missed a  ton because like it didn't have the like that. I think that was a really cool thing that we just caught on film.  Right. And I think what we just discussed was how that was. We, whether or we realized that we just did a postmortem.  We did.

1:35:38 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

1:35:38 - Derek Perez
  As to how that occurred. Yeah. Right. And so like, I think that's really, really good. And so I agree, this is a TRD and that's our newest term and I love it.  And so if we were talking to Danny, Danny would talk to you, you would build a PRD, PRD. And then you would hand that to me and then I would do a TRD.  And then from that, we would agree on the TRD or not. And then we would probably, I'm going to guess, we'll almost always emit one ADR at the start, which.  It's just rules of engagement for the project. I think so, yeah. That's going to look like this. And it's just going to be like, this is roughly how we would satisfy the TRD in a breath first way.  Yeah, and I love it.

1:36:25 - Travis Corrigan (matterflowadvisors.com)
  I'm going to have to really, I think one thing I'm going to have to get more comfortable with is reaching for the AD, just more comfort with ADR and reaching for it.  Because so much of those decisions made were semi-explicit when I was running product teams. It was mostly in my head.

1:36:49 - Derek Perez
  But you should just lean on me to help you identify those, right?

1:36:54 - Travis Corrigan (matterflowadvisors.com)
  totally. Yeah, all I'm calling out is a little bit of a historical muscle that needs to be developed around ADRs.  And just being able to like incorporate them more into the overall process. Because it sounds like ADRs are. They're much more of a how.  Yeah, but they also incorporate this sort of like this ledger piece, right? Which is just like the decision of record.  Yes.

1:37:29 - Derek Perez
  Just like, for example, like, let's say a good example would be like, we could do another ADR that invalidates the decision we made in this one.  Sure.

1:37:38 - Travis Corrigan (matterflowadvisors.com)
  Right? Like, that's totally fine.

1:37:40 - Derek Perez
  And that could just be an evolution of experience. Yeah. That's what they're allowed to do. That's why the chronology is important.

1:37:46 - Travis Corrigan (matterflowadvisors.com)
  That makes sense. And I think I'm familiar and okay with the ledger of decisions made. But mine is not constrained solely to architectural decisions.  I think sometimes we make scope changes. We make different things that have cascading problems, you know, cascading impact on things like architecture.  Yeah. Architecture or, or other, you know, tests, you know, that, that would live in a purity, right? Um, yeah, we can.  Yes. Yes or no. Like, like we, we can make a decision. I've never actually truly used a decision of record.  Um, so I'm not like talking from a place of like, I know, and I've experienced things. It's sort of like, I've had it described to me.  I always imagined a world in which I would use it. And now I get to be in that world now.  And I, but now I have to like, learn a whole new  thing. It's not much to learn.

1:38:47 - Derek Perez
  I think, I think you're do the natural thing. So if it would show up in a PRD, then what would happen is you would post, we would post a PRD, right?  I would look at it. There needs to be a technical design as a result of the PRD and ADR would reference that there was a change and it would be part of ledger.  Yeah. Yeah. Right. Like that's, that's the point. And ADR is almost always reflective. Like, I guess this is like, I don't want you to get the sense that.  Architecture or, or other, you know, tests, you know, that, that would live in a purity, right? Um, yeah, we can.

1:39:20 - Travis Corrigan (matterflowadvisors.com)
  Yes.

1:39:21 - Derek Perez
  Yes or no. Like, like we, we can make a decision. I've never actually truly used a decision of record.  Um, so I'm not like talking from a place of like, I know, and I've experienced things. It's sort of like, I've had it described to me.  I always imagined a world in which I would use it. And now I get to be in that world now.  And I, but now I have to like, learn a whole new  thing. It's not much to learn. I think, I think you're do the natural thing.  So if it would show up in a PRD, then what would happen is you would post, we would post a PRD, right?

1:39:55 - Travis Corrigan (matterflowadvisors.com)
  I would look at it. There needs to be a technical design as a result of the PRD and ADR would reference that there was a change and it would be part of ledger.  Yeah. Yeah. Right. Like that's, that's the point. And ADR is almost always reflective. Like, I guess this is like, I don't want you to get the sense that.  ADR drives PRDs. That's not normal. That is why I keep an underline, in lieu of a PRD, it can cold start itself because there's no other option.  Yeah, right. Right? And so if there was another option, then Like PRD existed? Yes, then we would do that.  Okay, makes sense. Yeah. But that's, in this particular scenario, because of the particular type of project it is, which is why I think that we're in, like I said from the beginning, I think we're in red herring territory.  Because we're in a technical product framework with low problem statement definition and no pre-existing PRDs, you're in the corner of the corner of the corner of the decision tree, and you're like, well, what I do have is an ADR.  Yeah, totally. That's literally all I have left, right?

1:40:57 - Derek Perez
  Because like, otherwise, I have nothing. Yeah, no, for sure. And from your perspective, that makes sense. My brain keeps going, why don't we just write a PRD?  Because, no, we will now. No, we will. But like, it's so funny. I'm like laughing at myself.

1:41:10 - Travis Corrigan (matterflowadvisors.com)
  I'm like, of course you would say that.

1:41:11 - Derek Perez
  Cause you're the  product guy. Like that's literally how you've solved all your problems in the world is just like, write the product requirements document.  But that, that's, that's the thing I'm trying to, like, that's what I want to do next. Yeah. Yeah. Yeah.  And that's, I think, I think that that's, but we don't have to, right. I think the point, I just, I'm, I'm merely making an observation about like how you solve problems in the world versus how I do is that, yeah, in lieu of a product requirements document, you're not going to write a product requirements document.  You're going to write what is your best recreation of what a product requirements document, which would be, which would be probably this briefs, which is very technical in nature and an ADR.  And that makes a ton of sense to me. But now, now that, but that's what I'm trying to say is now that I have that, now that I have these two things, now I want to convert to PRDs because none of this is, is well specified.  Right. None of this is well specified. So like the only thing that this ADR truly does is agree on conventions.  Like we know that there will be one, two, three, four, five packages so far. Right. And we roughly know what their responsibility, like you'll notice what the responsibilities are.  But we haven't, we have not at all, as far as I'm concerned, enumerated the clarity of the requirements to meet even this suggestion of responsibilities.  Yeah. Right. There will be more responsibilities figured out and that will be a PRD. would not be an ADR.  Right. This is literally just like the cold start to like get the sipping duck. You have to push your hand down on it so that it creates tension on the line to come back up and then take another sip.  Yeah. Right. Like this, this is not a pattern.

1:43:07 - Travis Corrigan (matterflowadvisors.com)
  This is, this is truly a unique cold start problem. Right. Like I. I need to see a PRD defined for every single subfolder of a plugin.  How do you define a scheduled job? What is the API of a scheduled job? What can a scheduled job do?  What happens if there's two Hadrons and they both have scheduled jobs and they're the same? All of that, not in an ADR, not at all.  That's all PRD town. And so what I was hoping to do is to get to a point where this is defined enough that we could actually start chipping away at the underlying PRDs.  And this is just informing how it's going to structure its thinking. And that was the point of the tracer bullet thing was like, we just need enough of a skeleton to start the PRD process.  Totally. Yeah, absolutely. Yeah. Yeah. And I would say that, again, back... Back to like the PRD for each one of those things in there.  Yeah. I would call those TRDs actually, because you, I mean, actually both apply. It lacks, so for the purposes of Hadron, we'll call them PRDs.  For the purposes of any non-Hadron product, I would technically call them TRDs because we are building a technical product.  The code is the product. Which is why I'm okay adopting the P, because it's, that's. Yeah, me too, me too.

1:44:46 - Derek Perez
  I'm just calling out my own sort of biases here of like, but it does, it lacks, what the content that's in here is not being written by me, Travis, because I'm not qualified to write that.  You know, and also we're not, it does not make sense to do a bunch of inline business requirements for each of those things.  That's overkill, blah, blah, blah. And so. So I, I, I just needed to sort of do a little bit of Bayesian updating on the semantics of PRD for this particular project.  So I agree with you. Those need to be PRDs. Write them the way you want to write them in terms of, want, I want Cloud PM to write them.  Yeah. Cloud PM will write them. I mean, the point is I don't have, I don't have a  theory about the, the, the, the formatting.  Oh, you mean like the structure, the structure of that document. I don't, yeah. For this, I don't really care that much.  If we were building a fitness app, I would have different opinions.

1:45:49 - Travis Corrigan (matterflowadvisors.com)
  Of course. And as would I, in fact, if you go back to this document, that was one of the things I called out in the original Cloud PM doc was, I think it would be good if that process was, was templatized.  Yep. Because what I'd actually like is for there to be like this project uses this PRD. And then Claude PM walks me through whatever this project needs me to do for it.  Yeah, right. Right? Because I don't think it should be end all be all. And that was what I was referring to, like with this, right?  Potentially overfix for discussion's sake. And my point was, I would like, if you think that a scope matrix is necessary, that should just be part of a template to a project that requires that at the meta level.  Exactly. And then when Claude PM is building PRDs, it should address that because it's relevant to the project. You know, I honestly, Claude needs to ask the human, what kind of product are you building?  Yeah. Yeah. And then like, it just fills it out as like, it helps, it could actually create this template.  Yeah. For itself. I think that's your guidance. Yeah. And I think that's the, I think that's what I'm reaching for is the thing to do.  And I, yeah, this is where the case. think you were kind of, yeah, you were kind of getting there.  Yeah. Yeah. With like, it's. Issue templates and stuff. Yeah, issue templates, all that stuff. I mean, all this is like comes from my world of building software for human users, right?  yeah, yeah.

1:47:22 - Derek Perez
  And the technical implementation details are not at all an opinion inside of the product requirements document. The engineers historically have always looked to me to be like, what does the thing need to  do?  And what's the scope? Like, and they kind of have had their brains turned off. And that's just sort of the people I've worked with.  And so the bias of these things is sort of has that bias. Yeah. I've never been a technical PM before, right?  So like, this is now a new world for me where I'm actually kind of getting more into your world of we're building software that is.  The software is the product and the user is mostly agents and some humans. And that human happens to be one of smartest humans I know, which is you.  But we're going to, you're in like, that's just like Claude PM's existence proof, right? Once Hadron's existence proof hits and then we build something with it, it's going to immediately make sense to you.  Sure. Yeah. Right. Because like, you're not like, you will have, like, this is about providing the right primitives up a level to like, we will describe product solutions in operations, events, workflows, jobs, loaders, right?  And that will afford us, well, we would describe that and then we would automatically get for free, like, RPC calls and MTP tools and all the things that you want to satisfy a PRD, right?  So like, that's, that's kind of the point of the framework is that it's like tightening the lexography of the problem space so that you aren't having to invent from whole cloth every time.  What is an API? Right. Yeah. Right. That's the whole point of this project. Yeah. Is that like, we want to eliminate that.  We first of all, we want to eliminate that as a guardrails constraint to say, you don't need to keep rethinking about that.  You just need to think about the business logic and the core construct of what you're trying to achieve at a product level.

1:49:33 - Travis Corrigan (matterflowadvisors.com)
  And this is the definitional way that we'll do it. And if not, it will evolve to support that. Yeah, that makes sense.  Right. Which is why I don't want this to be open source. Cause I don't care. Like all I want this to do is make limbic projects faster because that's the business metric that I actually care about.

1:49:51 - Derek Perez
  Absolutely. And I think that's, that's kind of the whole point. Right. And so like, I'm happy to keep it as like sort of second party.  If like there's people we trust who are like, whatever,  let Joe have a license to it or whatever. And we just keep it IP based and whatever.

1:50:04 - Travis Corrigan (matterflowadvisors.com)
  But like, I'm not going to put this on open source GitHub for  and take like issues and PRs from like  randos.  this is not for them.

1:50:11 - Derek Perez
  This. This is not for you. This is not for you. Right. And so like, that is the ethos I have for this project.  And so like, just keep that in mind. But at the same time, you should, by all means, feel completely empowered to level up here.  And if this is something that you're enjoying and you like to see how this is done, I'm not going to hide this from you.  Oh, no, no, no, no. I'm along for the ride.

1:50:35 - Travis Corrigan (matterflowadvisors.com)
  think, I think what I'm trying to say is that like, I don't have the, I don't have expertise. And that's in ways that you may be, you may have mistakenly thought.  And no, no, I think you have more expertise than you think. I truly do. I think that you have more expertise in this than you think.  And when it comes down to like, are you going to perfectly agree or be a thought partner on like, why are these three methods here?  No. And like, I don't need you to be. Right. I'll be honest with I don't think about that at all.  I don't. Yeah. That's, that's not what I'm asking you to do. No. Right. And like, that's what I'm. So like, I think this is working because the actual, I actually think the right altitudes are here.  And right now, maybe the struggle, if there's any, is just that like, how do you build the Omni tool that floats into the right altitude at the right time?  And I think we'll get there. I actually think we'll get there. But I also think the solution to that is to be underfitted, not overfitted.  I think that's, yes. And I think that's the violent agreement that I'm making here is that like, I'm learning a lot about the way in which we've gone through brainstorming and then hit this brick wall around, okay, what are the requirements?  Like, what are the stories? And then like this massive gap. And I go, oh, . Well, is there, is there a different way that we need to be thinking about these, these project requirements documents at different levels of abstraction?  That would prevent that problem from happening again. And that's the lens that I'm thinking about it. And my impulse.  Pulse is to be like, oh, I need to be more prescriptive about the process. need to be more prescriptive about the templates of the PRDs and sequences, stuff like that.  And what I'm actually doing is allowing myself to have that emotion and go, actually, no, it does not matter what the sequence is.  What matters is that it's thorough the minute we need to go from a PRD artifact, whatever format or template that is, into requirements.

1:52:42 - Derek Perez
  The human user, specifically you, because you're the first user of Cloud PM Limbic, is like, I don't need Derek to think about, I don't need to revise Cloud PM to be like, okay, the thing that Derek needs to do next time is write out a problem statement first, then do things.

1:53:04 - Travis Corrigan (matterflowadvisors.com)
  It's like, no, I'm going to let Derek do, solve problems the way he likes solving them. And the limb.  Fathom to be strong enough to be a good assistive technology for him, not something he has to fight against around an overfitted process or overfitted templates and overfitted process.

1:53:26 - Derek Perez
  So yeah, so just underfitting, underfitting is kind of my thoughts there.

1:53:33 - Travis Corrigan (matterflowadvisors.com)
  So yeah, I think this is great. I think this has been really helpful. Yeah, likewise.

1:53:40 - Derek Perez
  I think it's really great to be like this explicit about this, because I think this is the kind of stuff that can easily get lost in, in like, I think this has a lot.  I think this ultimately has a lot to do with some of the differences of successful outcomes for these kinds of projects is because I don't think that people are thinking this critically about these things.  No, no, they don't think about their process at all. They just, like, have ideas and try to just push through them as hard as, push through them super hard.  Fine. Thank And then they just try to use Claude code to white knuckle their way through it. I don't have a good, I haven't, I don't, I'm not good at like completely, perfectly making this meme on the spot, but we're kind of here.  That's absolutely right.

1:54:36 - Travis Corrigan (matterflowadvisors.com)
  That's absolutely right. Yeah.

1:54:40 - Derek Perez
  I feel like that's, that's like what's coming to mind is like, this isn't, I think this is the lesson that we keep hearing too from the anthropic research team right now is like, the more you overfit your Claude MD file or your agents MD file or whatever, the more you do that, the less good the outcomes are.  There was like a research paper on this very point. Right. And they did like, it was an actual evidence-based point there of like, it, we tried to fix issues in real code.  With real languages, real open source projects, and we ran a study, and the less defined those files were, for agent instructions, the more successful the outcomes were.  Right? And like, that's what we're experiencing right now, right?

1:55:26 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Which is great. I mean, because that means it holds. Yeah, for sure. Which is awesome. Yes. Right? It'd be worse if we were right.  Yeah, yeah. Because then it's rigid and it's fragile. And it will, it will eventually get rug pulled by some level of complexity, so.  Yeah. So, this was an awesome discussion, and I'm also so thrilled that this is recorded, because this is like, such a, like, foundational, like, thing that we've hit.  So I'm really glad that we got all of that on recording. This is, I think we're gonna, this will be like a red letter conversation in the process that we're building here with Limbic and stuff, and Hadron, for that matter.

1:56:11 - Derek Perez
  Given all of this, what I do think we have is TB0, whether that's an ADR or like, I just feel like as a PRD, it doesn't say enough.  It's too broad. Sure. I can't, I cannot, I am literally have no meaningful priors to know or not. This is more detail than anything I would ever write for any product I've ever worked on.  So, so I'm to lean on you. So the question, my posture to you, Derek, is what do you need to do what you need to do?  Okay, perfect. How does Claude PM at the very least not get in your way? And if it is getting in your way, what is happening so that I can make note of that?  that gets in your way less on the next tracer bullet. So what, that's a great point. Cause I mean, even the TB is like, the other thing is like, we could.  Use discussion for holding, what if we just said tracer bullets was a concept? It's not an ADR. It's literally just like a scaffold, right?  Like this, I think I'm fine calling this an ADR because I do think that it is making architectural decisions.  It's setting a precedent about package layouts and like the shape of things. But that's, I think, the difference. It's describing the container, but it's not describing the contents at all.  Yeah. think that, and so for you, I think where sort of like your horizon becomes hard to discern is like, from your vantage point, the container and the contents are indiscernible or not.  They're, they're, yeah, I cannot. So do you, you wouldn't know like what more needs to be here. And that's fine, right?

1:58:04 - Travis Corrigan (matterflowadvisors.com)
  But that's why what I'm saying to you is, I would think of this as an ADR because this is a breath first document of a series of conditions.  Containers. And now what we need is a PRD for every single container about its contents. And then from there, I would want stories and I would want all that stuff and milestones and after action reports and retrospectives on delivery.  That's where it hooks right back into what you're used to seeing. Yeah, right. It's just that this isn't, none of this is depth comprehensive.

1:58:39 - Derek Perez
  A tracer bullet, by definition, is breath first, is breath based. And maybe that's just the way to think about it.  It's like, tracer bullets will always be breath first because the point is it shoots and hits through a number of targets.

1:58:53 - Travis Corrigan (matterflowadvisors.com)
  And then what we need to do is for every target that it hits, we need a depth first PRD for that thing.  That is how I'm, that's how I'm thinking about it. I naturally think about it the same way that you are too.  Yeah, I do breath first. I mean, because in your device,

1:59:11 - Derek Perez
  Finding an MVP, I have to define literally from everything from the splash page through the settings, like, and every feature, every core product, every core user flow, every alt flow, like, I like, it's got to have all of these things.

1:59:28 - Travis Corrigan (matterflowadvisors.com)
  And then we get into what is the first layer of depth for everyone, every one of these, and then ship that, then we go deeper, deeper, deeper, deeper, deeper.

1:59:40 - Derek Perez
  So, what about this? What if we just promote Tracer Bullet to a top-level artifact, and it goes in the wiki?  I, I, it's like, this is something you do, this is something I do, this is now standard.

1:59:58 - Travis Corrigan (matterflowadvisors.com)
  Well, yeah, so the wiki, the wiki would be, I, I, I'm looking at this, and I'm like, this looks basically like the wiki, like, uh, if this is the breadth.  But here's the thing, though, it's the, is this, um, but we've got multiple traces.

2:00:13 - Derek Perez
  Supposedly, at least it, well, that's a funny question, because what it says is it knows that it has a line of sight on another next one.  It knows there's more than one coming, and then there's other ones. Well, so that's the, that's the thing is that we looked at, and I could probably go find this in a previous transcript, but like, it literally did say, should this be TB1, TB2, TB3, TB4, TB5?  Yeah, but we never, we never pushed anything higher than one, so then it just gave up. Yeah, right, so.  Which is fine, because it'll, it'll just make more, because it knows one exists.

2:00:50 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

2:00:51 - Derek Perez
  So, like, but I guess my question to you is, like, why don't we just canonicalize tracer bullet documents? It feels like overfitting to me, I don't know why, but I, I, because it, it sounds.  So, is a tracer bullet a version of the wiki?

2:01:13 - Travis Corrigan (matterflowadvisors.com)
  That's the thing I'm thinking about.

2:01:15 - Derek Perez
  Well, I guess if you were to say, if ADRs are about a temporal order, and the point of putting them in discussions is to literally just have them have a monotonic timeline, then over here, with a TV, it could live in a world of a folder of tracer bullets, which is one level deep, basically.  And then PRDs can come out of those. I guess, because this is the problem, right? With a tracer bullet, you can't go from tracer bullet to stories.  That's my assertion. Sure. You can't go from tracer bullet to stories. There has to be an intermediary PRD.

2:01:58 - Travis Corrigan (matterflowadvisors.com)
  And that's what's missing here for me. So if we were to go, so like, if we talk about what is the limbic process that we described, stakeholder provides some kind of briefing to us about what they want.

2:02:10 - Derek Perez
  Travis goes and writes.

2:02:11 - Travis Corrigan (matterflowadvisors.com)
  It's the PR, the ultimate PRD, the Apex PRD. Apex PRD. Then Apex PRD gets handed to Derek. Derek writes the Apex TRD, right?  We get to here. And now we need to start tracer bulleting our way to execution.

2:02:28 - Derek Perez
  So we do tracer bullet zero and we decide this is what needs to happen from a workflow perspective or a project flow perspective, whatever it is.

2:02:38 - Travis Corrigan (matterflowadvisors.com)
  Yeah. And then we say, great, TV zero, I'm going to start flinging PRDs against TV zero as a point of reference.  And then those PRDs exist. We review those and they get stories and tasks and they go into milestones. To me, that feels like the whole story.

2:02:56 - Derek Perez
  I think that sounds right. I think the thing that it breaks, it's an SOP break for us, which is that a PRD is a single epic.  It can be. It's still. Could be. Yeah, but what you're saying is that a TB, and sort of the process was sort of defined as doing one PRD at a time, in my mind.  I think that was just an assumption, I mean. Oh, okay. Yeah, it might be. I don't know that, like, because I was assuming these were potentially parallel.  Yeah. But I was thinking that, like, yeah. Well, just to clarify what I mean by that. the thing I just need to get my mind wrapped around, is just, like, okay, we can do these in multi, like, multi-project.  Like, yeah, multi-squad approaches. Yeah, right, because, like, a PRD could be executed on this, like, building the plugin SDK while we're defining, like, how the API system works, right?  Like, that's okay. Because they have contracts, and the PRDs are a lot about those contracts. And what I like about, what I liked about Tracer Bullet here was it defined a...  Enough of the cross-cutting contracts for the PRDs to go deep without interfering. Right? Like, that's what I mean about the containers.  Like, we know how the containers look and how they'll line up and touch, but we don't know what's inside them.

2:04:27 - Travis Corrigan (matterflowadvisors.com)
  And I think that's what a tracer bullet's supposed to do. Okay. Right?

2:04:32 - Derek Perez
  A tracer bullet, by definition, is about, and I mean, like, you know, I'm not sure if you knew this, but this is, like, literally a methodology.

2:04:42 - Travis Corrigan (matterflowadvisors.com)
  Like, there's a book about it. Yeah. Okay. And, like, this is something that is not that common for what it's worth.  I think this is a taste thing for me. And I think it's a taste thing for you on a product side.  You're just doing it, whether or not that's, like, the definitional thing you meant to do. Right? Probably. And so, like, that's what's interesting about that, right?  It's like, what this is, is a firing of Hello World for Hadron the Framework. Right? And then once that's done, then we can go and build out as many PRDs as we can.  And that's why I'm saying, like, I think there's a PRD hung off of every tracer bullet as an iteration.  Okay. Sounds good. But whether or not it's sequential or parallel on the PRD side for what it's worth, I think that doesn't matter.  Okay. I think it could be sequential and that's okay too. Yeah, think, I think the, the. Yep. Yeah, yeah.  Okay. I am just up, I am grafting new knowledge onto existing mental models. So that's all I'm doing. Okay.  Okay. So what do you, so we need to upgrade, uh, so it goes. Let's, let's, let's step out of Hadron really quickly and like, let's think about something a little bit more deterministic because Hadron's like an Ouroboros.  Yeah. And it can, we can get really easy in terms of like defining a process based on how one particular project is going.  that project is so recursively circular that like we can chase our tail a lot and like think that we're designing a process.  We're actually just designing the process for Hadron, which may actually not be like representative of any other thing that we build.  So, um, or it may, I don't know, but as a contrasting example, let's think about the vectorization project, right?  So I'm going to walk through that and cause I want to know in that environment, how does a choice or bullet like slot in to the process that we have already sort of discussed like, like last week or whatever.  Yes. Happy, happy to do it. Danny has, wants to, talks to me, waves his hands. And I effectively retranslate all that into some.  Sort of structured thing around here is the business problem. Here is a set of, here's an abstract definition of solution.  Here is what the measures of success would look like.

2:07:27 - Derek Perez
  Here is what potential value created over baseline would potentially be  like that. And then here is a definition of, a set of definitions about what the, you know, what the, what the, you know, what, what the product or the system itself needs to do.  Right. And I'm going to strive it in a level of abstraction such that when you read that, you go, cool.  I know of at least five different ways of solving modular architecture. Yeah. Blah, blah, blah. Okay. then I go, Hey, Derek, I've got a PRD.  And you go, fantastic. Let's start doing technical design, right? Technical requirement. You're going to pull up, we're going to have the ADR, and then we're going to have another document, which I think is the technical requirements or technical design.  Wait, hold on. I want to go backward just a little bit because you started using official terms, and I want to push a little pressure on to what is the name of the document that Danny, the stakeholder, hands to you?  Danny doesn't hand me anything, usually. Well, but let's, let's say like he's, you know, he wrote something down that was like, here's what I want from you.  Uh, that'd be business requirements. Okay, so Danny, so you get a stakeholder business requirements doc, it's handed to you.  Yeah. You write the PRD, right? The PRD goes to two people after that. goes back to Danny, did I hear you correctly?  Is that what you want? Yes. Then it comes back to me, and then it goes, great, Derek's going to build a TRD based on this PRD.  Yeah. Great. I'm going to do that. Then you're going to see a doc like this.

2:09:11 - Travis Corrigan (matterflowadvisors.com)
  Yeah.

2:09:11 - Derek Perez
  About all the things that you described, modular design, we need to crawl the web, need to download every page, and process, you know, and sanitize the outputs to make sure it's processable to do some factorization, right?  And we want to be able to compare it against as many models as possible in tandem as fast as possible with the lowest cost, right?  You would send me a doc that's basically that, right?

2:09:39 - Travis Corrigan (matterflowadvisors.com)
  Yep. Great.

2:09:39 - Derek Perez
  Then I would say, awesome, I'm going to go write you a TRD to SPAC against your PRD. Great. I write a doc like this, right?  I show this to you, we go through the details of it, and we can argue about, like, words I chose, things I do, whatever, blah, blah, blah.  We go through it, right? Normal . I probably would have already done that with you, with the PRD before you handed it back to the stakeholder, so that's normal.  So that's just peer review, right?

2:10:06 - Travis Corrigan (matterflowadvisors.com)
  Yeah, yeah.

2:10:06 - Derek Perez
  We go through the peer review process, you hand it to the stakeholder. Stakeholder approves back to me, do it again.  go through Peer review with us. And then we present the technical plan back to the stakeholder again, right?

2:10:17 - Travis Corrigan (matterflowadvisors.com)
  Agreement there. And then in the Olympic world, we would then build SOWs and price it, right? And then we would go through the legal process, accounting process, financial process.  Great. We're done with that. Checks in. We're great. Now, what do we do? I would still, again, I would reach for a tracer bullet, not an ADR.  Okay. Because I would want to think about standing up the cloud infrastructure for crawling. I would want to make sure we have the right cloud accounts.  I would want to make sure we have a repo. We have a delivery process from repo to cloud. I would want to make sure we had like enough of the contracts established, which by the way, we did with Matterflower, Matterflow Advisors, Customers Repo, all that stuff.  Right. So that is a pattern in my mind, which is why I reached for this here. Here. I just never really called it this out loud.  No one's ever done that before, but this is a formalization of a thing that I've done at every engineering partner for every zero to one effort I've ever done, which is, hey, here's everything you just described is basically it.  Like I work with the founders, the founders are like, blah, blah, blah, blah, blah, blah. And I go, okay, here's what it is.  And they go, you know, shmish mash, shmish mash, like make some edits. And then I go to the designer.  Because typically we have a front end with pixels. And I go to the, so the design lead and the engineering lead, typically the, the engineering manager.  And I go, here's what this is. You guys now need to start making architecture decisions based on this that are aligned with each other.  Yep. And then you, so they're doing design. We're doing user design and we're doing technical design. So architecture is what I call that.  And they then need to have enough of a, I guess, yeah, a tracer bullet, enough of like, what are the pages and what is the information architecture of the page?

2:12:26 - Derek Perez
  What literally are the fields we need to pull from the database and present on a page by page basis so that we can identify what the actual contract is between the front end and the back end?  And then I go, you guys disperse, you're going to push pixels. And then the first thing that you're going to do is, and I call this technical foundation laying, which is like the environments, the repos, all that stuff, that stuff to do everything there.  So that's historically how I've done zero to one stuff with a squad that's more traditional and on products that are way less technical because they're typically for consumers or business users.

2:13:06 - Travis Corrigan (matterflowadvisors.com)
  They're not for other developers or agent, software like agents.

2:13:14 - Derek Perez
  We just never had a formal, I just didn't have a formal document for that. And it sounds like this is a good way to wrap everything I've already been doing as a formal document.

2:13:24 - Travis Corrigan (matterflowadvisors.com)
  Is that what I'm hearing?

2:13:25 - Derek Perez
  I think you're right. And that's why let's just canonicalize it. And we say there's a new type of document TVs.  And so we have tracer bullet docs that are, we could give it a better name.

2:13:38 - Travis Corrigan (matterflowadvisors.com)
  I mean, like, that's why I was comfortable just synonyming him to ADR. Because you could say an ADR is a tracer bullet.  And that's fine. And another kind of ADR, like I said, is like, well, how do version numbers work?

2:13:50 - Derek Perez
  That's an, that would be another type of ADR, which doesn't feel like a tracer bullet. Right? This is like how all squares are rectangles, but not all rectangles are squares.  Yeah. Right? That's all in my mind, the difference is. Yeah.

2:14:03 - Travis Corrigan (matterflowadvisors.com)
  All tracer bullets are ADRs, but not all ADRs are tracer bullets. Exactly. Yeah. Okay. That makes sense. And so like, there's two ways to think about it.  You could either just. Outside that you want to treat tracer bullet documents more like PRDs and they go on the wiki and that's fine.

2:14:17 - Derek Perez
  I actually don't care. You could do the same thing and say they're ADRs and they don't live in the wiki.  That's also fine. Right? Like, I don't think there's a wrong place for those to live. Hi, baby. You know what I'm saying?  Yeah. So great. This actually, that makes sense. So, um, I didn't, I just put it in the chat. I'm just going to put it up before 30.  So, um, so where does it live, um, in the wiki space? Um, in the wiki space is my only main doc of reference right now, this one.  Yeah. Um, maybe, I don't I may have, may have put that back into club PM and it's got a design, like doc waiting for me to look at.

2:15:11 - Travis Corrigan (matterflowadvisors.com)
  But for all intents and purposes, yes, it's this. This is why I had said the library in me wants to nest this one level deeper just to provide more latitude growth for adjacent stuff.

2:15:22 - Derek Perez
  And that's where I was saying like you could have a folder that's like PRDs with all of those. And then another one is like tracer bullets.  And then those can be in there. And then even, but like the thing that's different about tracer bullets is I don't actually think that they need to have any other depth beyond that.  I think it could just be like, like it was doing. Right. And I don't, I don't think these are even, I also don't think you're making these definitively every time you do something.  Correct. Yeah. Which is why I don't think they need to be nested because these are somewhat linear. Yeah, they cut across PRDs that are down below, right?  EB-01 literally is going to have something for every section in the wiki. Yes.-002 is going to be a subset of all features.  And so that crosscut, I was like, you know, we don't need to put them in the wiki necessarily. They could just be ADRs and live in the ADR system because ADRs are also crosscutting, right?  Like the way that you decide how versioning works, which is a very technical decision, but like if another version of this, like in the product world would be like another kind of ADR would be like something formalized about how you handle forms.

2:16:59 - Travis Corrigan (matterflowadvisors.com)
  Okay. Like every form has to have ARIA support like this, right?

2:17:05 - Derek Perez
  Like if that were a thing you would say from like a design perspective or whatever, that's an architectural. We'll cross cut.  It's not a PRD, right? It's assumed that every PRD will do that. Yeah.

2:17:20 - Travis Corrigan (matterflowadvisors.com)
  Right? Well, in a sense, you're not repeating yourself. It's like, we've already litigated this. We expect ARIA labels on all fields.  This is how they should work. These are the libraries you should use. These are what we build with. Sure.  Great. And if you ever mention forums in a PRD, that is assumed. I feel like a TV, a tracer bullet would just be like a really large ADR, like a really large.  Yeah. That's fine. There could be any, I mean, there's no length rule. I mean. Yeah. Like an ADR can be very small, like.  Yeah. Can make conventions or can be really big, like a tracer bullet. Yeah. There's no, there's no size definition for it because that's, that's what I meant about like community chess versus chance.  there's no, no, It's just another type of card you have in the deck.
  ACTION ITEM: Read ADR/tracer-bullet materials (e.g., Nygaard) - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=7970.559325000001

2:18:15 - Derek Perez
  It's another kind of thing you can use while you're playing a game. Got it. Okay. Okay, so I'm going to, I have some reading to do around ADRs, a lot more, and tracer bullets.  So I'm going to do that. But I agree with you that the concept of a tracer bullet should be elevated to a level of formalism that it currently is not.  And we'll just have to think about when we tend to do that and where, what the process is of generating that doc, refining that doc, and then, like, where we put it when that document's been ratified.  So, but those are decisions we can make sort of later. Yeah, and then, like, this, if you recall, one thing you can look at is the, I'll just put a link to it here, the Nygaard decision framework, but, like, we also don't even need to, like, it's truly, it's truly just, I mean, this is a blog post that can also be represented as literally this markdown file.  It's here, title, status, context, decision, consequences. I, I'm literally in that dude's repo right now, like, that's the thing that showed up, and I'm like, oh, this is the reading I need to do, so I will.

2:19:54 - Travis Corrigan (matterflowadvisors.com)
  Yeah, so, like, we, we could, and just, and, like, even this here is just, like, the decision section is literally just all of this.  Yeah. Right? The rest of it is just formalization. the decision Right. But like, that's the way that I would map these two things is we would have, we would have a discussion or a wiki page, whatever, I don't care which, that is in this structure.  And the bulk of what was just written in TV zero would just be right there. And the rest of it would be proposed, accepted, rejected, deprecated, superseded.  That's it. Context, this is a tracer bullet, is what you'd say. Right. And the consequences would be what becomes easier or more difficult to do because of this change.  It's a simple justification, very similar to your problem statement. Yeah, exactly. Okay. See, that's what I'm saying. They're very compatible constructs.  That makes sense. Yeah. Okay. Rad. Okay. So just to recap, we are out of place where we have gotten through the first rep of designing.  We have learned a lot.

2:21:11 - Derek Perez
  About how to design and how to think about designing and all that came to the forefront as we attempted to decompose a lot of the brainstorming stuff into actual requirements or actual like GitHub issues and user stories.  We've also identified the fact that there's some setup gaps that we are, we knew about conceptually, but now are really specific, which is the tokens, auth tokens and whatnot, are going to run into an issue around sub issues and stuff like that.  So that we're going to, and the decision I think is just to continue to plow forward. Yeah. Uh, see how messy it gets, and then we'll probably just need to fix that mess.  Like, well. What we'll learn is the things that need to be done in the setup feature of Cloud PM that does not currently exist.  Well, I think that's probably right. The other thing that's sitting here, I think, left to be done is like, given the existence of this file, what we probably, in order to press forward to see what happens next, we actually need to hand this into Brainstorm.

2:22:36 - Travis Corrigan (matterflowadvisors.com)
  We need to go back to using PM with this document now, and then have it build a PRD for config, or, you know what I mean?  Yeah, so we need to decompose. We need to go back into PRD land.

2:22:53 - Derek Perez
  Yeah, like if you believe the idea that this tracer bullet is an ADR or some other artifact that was missing in that process, what you did just see was that it can actually build it anyway.  It's just that now it needs to do a loop and go, great, so now I have this, and now that I have this...  I need to actually spin PRDs off of this. And now I need to go. And then once I have that, I would use PM structure and then shoot out tasks and issues and stuff.  Yes. That's where I'm actually saying the delta of what needs to be addressed is actually quite small. Okay, cool.  Because like I actually, and if you want to, like, what do we do next? Because I'm going to be in court tomorrow.  What we do next is we actually go another couple of rounds of brainstorming.

2:23:43 - Travis Corrigan (matterflowadvisors.com)
  We flush out these PRDs. Okay. Do you want to be there for that? Yes, but I don't have to be.  No, that's fine. That's totally fine. What I would say is we'll need to do that. Yeah, what we would do is just go, we would just do basically what we just did again.  But instead of giving it the Hadron brief, or now what we call the TRD, we would just give it this file.  You noticed. Thank And then we would say, we're going to dig in to these packages and we're going to make, we're going to shoot out a PRD for each one.  And so we would even, even that we might argue like, we're only, we're going to create a PRD and a set of issues for this.  I am, we got to go. But like, one thing I'm worried about is like, how to stand this up because the dependency graph.  Yeah, I think, I think there's an alternative here that we could do rather than dive right into PRD land is that we could actually just do the work necessary to figure out the setting up of the project space itself, because we're starting to develop content without a structure for organizing it because we don't have a wiki.  So I feel like, I feel like pausing and like solving some basic  that we know that needs to be solved and figuring that out is the right next step.  Especially becauseoro. you guys. Because mergers. It'll start feeling too loosey-goosey, and then I think we'll kind of feel more lost trying to figure out these PRD content.
  ACTION ITEM: Provide GitHub tokens to Travis for project setup - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=8402.559325  So I think we need to just solve an organization problem, like let's just get the project organized.

2:25:30 - Derek Perez
  Okay. Can I lean on you to drive that? Sure.
  ACTION ITEM: Create fictitious repo; test Cloud PM setup/wiki/PRD/ADR/issues - WATCH: https://fathom.video/share/2PdH493ybKjC8_Hq-nmiEurNuGsddopo?timestamp=8420.559325

2:25:35 - Travis Corrigan (matterflowadvisors.com)
  The challenge is that it's all dependent on your tokens, because this is inside of your project space. Oh, okay.  All right. Well, we'll give you that next. When we reconvene, we'll do that. Um, I, the alternative is that I can just really probably just create a new repo as like some sort of fictitious product that I want to make.

2:26:02 - Derek Perez
  And then solve the myself. I will try that. Uh, so I'll try to do that before then that way.

2:26:10 - Travis Corrigan (matterflowadvisors.com)
  Ideally, apNote- Salomone right.

2:26:11 - Derek Perez
  can- I- really- uh I Updates to Cloud PM will include project setup that sort of solves things. So when you step in, I just say, hey, yeah, hit the updates, and then like the new plugin stuff will come in and solve that problem for you.

2:26:24 - Travis Corrigan (matterflowadvisors.com)
  Okay, that would be a deal. But don't count on it. Okay, well, I'm just trying to figure out how to make progress from here.  Yeah, we need to, we just need to set up the project, we need to set up the wiki, we need to set up some other stuff.  So, which mean, how do you want to solve that? Okay, yeah, I'm happy to be around for that. So, I don't think I can do that Friday.  I'm going to be in court. Okay. And... I don't know if I'm going to court on Monday or not.  We might be done on Friday. We might not be. So I will say, let's play it by ear, but this was a good session and we'll call it here.  Okay. Sounds good. No call tomorrow between you and I? No, I can't. I'm going to be in court for nine.  That's actually perfect. It probably gives me time to actually try to like solve some of this stuff. So yeah.  Yeah. Yeah. Sounds good. Okay. Awesome. Thanks. This is amazing. Likewise, man. Love you. Love you too. Bye.
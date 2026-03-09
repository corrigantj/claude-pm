20260225 Claude PM Review - Session 3 - February 25
VIEW RECORDING - 40 mins (No highlights): https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP

---

0:00 - Travis Corrigan (matterflowadvisors.com)
  And we are reviewing its review of the transcript. So, and I'm way off. Okay, so two-way PR architecture. Current design assumed a flat model.

0:25 - Derek Perez
  Yeah.

0:26 - Travis Corrigan (matterflowadvisors.com)
  task yards merge directly into the base branch. Transcript reveals two-level branching model. Wave one, individual task branches merge into feature branch via rebase.  Human reviews happen here, lessons captured per task PR. Wave two, which is the feature PR. By the way, I like this naming.  Do you like this?

0:46 - Derek Perez
  Okay.

0:47 - Travis Corrigan (matterflowadvisors.com)
  The consolidate feature branch merges into main as one atomic PR. Also gets human review and polling. This changes the responsibilities of PM, review, and integrate significantly.  Revise skill responsibilities. So PM dispatch, spawns agents, creates feature branch if needed, agents branch off feature branch. Okay, great.  PM review, polls for reviews on task PRs for the feature branch, merges approved task PRs into feature branch via rebase and captures per task lessons at merge time.  Okay, can integrate is creates a feature branch and a main PR and polls for review on that PR, merges, runs retro, updates wiki, closes milestone.  Okay, this makes sense.

1:36 - Derek Perez
  That's, I think, verbatim the plan. And so I think that it seems to have internalized it correctly. Okay, cool.

1:43 - Travis Corrigan (matterflowadvisors.com)
  Lessons captured at two levels per task. Okay, great. Full retro. Okay, minor versions feature branch longevity. Feature branch may stay open across minor PRD versions.
  ACTION ITEM: Define 'must-read' as context doc; exclude from PM Dispatch - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=168.9999  Is that accurate? Correct flag that PM Dispatch skips meta issues but asks when does must read happen? What's your intent for meta must read?  Is it a ticket that agents must read before starting work, like a context document, or a ticket that must be completed by somebody?
  ACTION ITEM: Update PM roles: PM Review polls task PRs, merges; PM Integrate polls feature PR, runs retro, updates wiki, closes milestone - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=198.9999  I think it's a context document. Agreed. Okay. Okay. On a two-way PR model, PM Review now handles merge tasks, merging tasks, task PRs into the feature branch in Wave 1.  Should PM Review also handle the human review polling for that final feature branch to main PR, Wave 2, or should that be PM Integrate's responsibility?  I say PM Integrate. That's what it's recommending.

3:55 - Derek Perez
  That seems right to me as well. Okay. Okay.

4:06 - Travis Corrigan (matterflowadvisors.com)
  The feature branch master major PRD version, when does PMIntegrate get involved after each minor milestone completes or only when the major version is ready to ship?  It's recommending major version only, but it feels like minor milestones, based on what you just said. Or user decides each time.

4:43 - Derek Perez
  User decides. I think that because that the decision tree will be, should I go do some minor work? And then keep adding to this branch.  Yeah. So you can't definitively know. Yeah.

4:56 - Travis Corrigan (matterflowadvisors.com)
  Dude, it's so crazy to be doing product design this way. It's very cool.

5:01 - Derek Perez
  I love the future. I love the future too.

5:04 - Travis Corrigan (matterflowadvisors.com)
  I love that this is our future because we talked about this for so long and we're like, oh, how do we make this easy for humans?  And then we're like, oh, oops, we don't have to. Yeah.

5:18 - Derek Perez
  And actually, I still think it's fairly intuitive for humans and a very clear manual could be produced to explain this process.  Absolutely.

5:25 - Travis Corrigan (matterflowadvisors.com)
  And in fact, that's what I intend to do is like after this and be like, all right, here's how you do like not  product management work in the future, everyone.  Okay. Summary reviews of 220. Yes, that's good. That's right. Continue. It is interesting the things that we've had to do to collaborate on this, right?  Because we were going back and forth on Signal and then we're like, why don't we do a Google Doc and then we recorded.  Then I put. The transcript, stopped the transcript, got it, pasted it in, let it go again, turned it back on, now we're talking through it live.  So just the, it's interesting what we have to do in order for collaboration to occur. I think there's probably a simplification here we haven't discovered yet.

6:16 - Derek Perez
  I'm sure.

6:18 - Travis Corrigan (matterflowadvisors.com)
  Okay. By the way, I'm going to continue evangelizing, updating your status line to have this like model and like context counter here.  Like this is how much of the context window I've eaten up so far in this session. Oh, wow. It's really rad too, because you, to update it, this is what you do.
  ACTION ITEM: Implement pre-submission validation/linting; add GitHub Actions post-submission checks - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=482.9999  You just go slash status line, tab. After creating or updating any artifact or before updating any artifact? Well, like, this is kind of a staging question of it, right?

8:13 - Derek Perez
  Like, it's going to, like, have something that's going to send. It should run lint processes and validation on what it's going to do before it does it.  Oh, interesting.

8:25 - Travis Corrigan (matterflowadvisors.com)
  As, TDD approach?

8:27 - Derek Perez
  Well, just to make sure, like, it's not sending trash into the system that's going to cause noise, right? Because the problem is, if it sends noise, then it has, it's more of a round trip and a token waste to, like, push a thing, it's wrong, download it to observe that it's wrong, make changes, and then update it again.  That's, like, four times more expensive. Yeah. So, if it can know, if it can know to go through whatever style guide or linters or whatever it's going to do, it should try and do that.

8:56 - Travis Corrigan (matterflowadvisors.com)
  So, you wanted to do linting before. The feedback I have is validation and linting should happen before creating and updating an artifact because we want to do measure twice cut once.  Once the artifact is published, we do not want you to go continue to make edits to it unless the human operator tells you to do so.

10:44 - Derek Perez
  Well, I wouldn't tell it that because there are things that should update. Okay.

10:50 - Travis Corrigan (matterflowadvisors.com)
  I would love to kill that last line.

10:52 - Derek Perez
  Okay. Just because like, like, for example, I was meaning that as more of an example. That's like a process example for PRDs, right?  Like in the. For a status line, if it's been marked as published, according to our taxonomy, then that document shouldn't be changed.  But that doesn't mean it shouldn't update tasks or other issues. As a length, after the fact. Yeah, that's like very, that's very circumstantial, I guess is my point.  Okay. And so I think it should figure that out. That like, what we're trying to do here is say, try and do your best to validate the inputs before you submit them.  Okay. Okay.

12:03 - Travis Corrigan (matterflowadvisors.com)
  Okay. ADRs. I'm actually glad you're on the phone for this one. Here, I'm just going to grab all this and put it in another Google Doc.  Okay. Faster. Yeah. Okay. Doc is in there.

12:50 - Derek Perez
  Okay. Looking at the bottom here. Okay. Okay.

13:01 - Travis Corrigan (matterflowadvisors.com)
  Oh, we're on section five. Section six, right?

13:05 - Derek Perez
  ADRs and GitHub discussions? Section six. Okay. Yeah. When to create makes sense. Yeah. Any sort of cross-cutting concerns, architectural patterns.
  ACTION ITEM: Create ADRs category in Discussions; use Nygard, sequential numbering, terminal states; link wiki - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=811.9999  I would also maybe mention, like, systems level changes to the product. You know, like. Actually, I mean, cross-cutting concerns kind of hits that, so.  Yeah, I think we're good. Yeah. Sorry, we have discussions with the decisions ADR category created via. Yep, that's fine.  We're going to use the NIGARD format, sequential numbering, integration, meta, wiki pages linked to relevant ADRs and their key decision logs.  If they exist. And yeah, ultimately they should have some terminal state.

15:39 - Travis Corrigan (matterflowadvisors.com)
  Okay, yeah, this makes sense. Validation runs before submitting to GitHub, not after. Agent builds the artifact content locally, validates it against the checklist.

15:49 - Derek Perez
  Yeah.

15:50 - Travis Corrigan (matterflowadvisors.com)
  Any issues then only creates the API. Okay, I understand.

15:53 - Derek Perez
  That's good.

15:54 - Travis Corrigan (matterflowadvisors.com)
  Okay, section six. Yeah.

15:59 - Derek Perez
  Okay. Okay. Okay. Okay. Got it.

16:00 - Travis Corrigan (matterflowadvisors.com)
  Okay. Let's go to section seven. All right. So this is token-based sizing and calibration. I can get you what the markdown looks like.  I can see it.

16:11 - Derek Perez
  Okay.

16:14 - Travis Corrigan (matterflowadvisors.com)
  Oh, this is the ranges for estimation. Yeah.

16:19 - Derek Perez
  I like it. Yeah, I think that's good calibration flow. At task creation, estimates size based on scope, assigns label.  At retro, aggregate estimates versus actual, across all tasks, notes for calibration, drift, overtime, size estimates is proved. That's a system that accumulates.

16:40 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Yeah. I would say that the ranges should be 200K is the limit, since that's currently the, like XL should be 200K plus, and then we should revise everything down.

16:55 - Derek Perez
  So that's, I don't know for sure, because consider a lot. Logical aggregation of sub-agents. Oh, that makes sense. Right?  If you go beyond. Okay. So I don't think we should necessarily bound it. I think what we should let it do, and I'm not even sure this number is going to be correct, but what I think we should do is let it pick a number.
  ACTION ITEM: Add token-based size estimates to config.yaml; implement retro calibration PRs - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=1030.9999  And as long as it's calibrating within itself, I don't actually care what the number is. Yeah. Okay. Right? And so that's the one thing I don't see here was when are the system needs to record its interval expectations as like in the repo itself, I think, as like a configurable YAML file or something that's like Excel is currently known as this range.  And so what I don't know is where is it reading the agreed upon the current state intervals for when it's making those decisions, and then where does it update with its calibrated values?  I think that the process makes sense. just don't see where maybe that's in PM can fit. I don't know.  I haven't seen where those values are saved so they can be modified. Also, those modifications to that file will need to be done in a small task branch and submitted as a PR for us to review.  It can't make that change directly.

18:39 - Travis Corrigan (matterflowadvisors.com)
  Got it. So we would just make a small branch off of main.

18:44 - Derek Perez
  and say, I'm updating the calibration numbers, send that for review, and then it would have a mini review process.  Okay. We basically would just accept or reject that. Okay.

18:53 - Travis Corrigan (matterflowadvisors.com)
  So we should have an artifact somewhere for the agents to reference the ranges and also provide. I'd also...

19:09 - Derek Perez
  Humans would not modify this. For the agent to update at the end of a milestone during the retrospective process, it should distill any calibrated updates to that file.  Okay. It will... And it must do this as a, you know, a small branch that edits that file that's reviewed by a human.  Okay. And then we would either approve it or not. Because, like, if it's like, ah, these numbers are totally , like, then we would say, like, no, never mind, leave that alone.

19:47 - Travis Corrigan (matterflowadvisors.com)
  Yeah, okay.

19:47 - Derek Perez
  But it would basically propose a calibration adjustment at the end of a milestone. Got it. So, and another...

19:53 - Travis Corrigan (matterflowadvisors.com)
  So, one file, one canonical file, somewhere for agents to reference to ranges, right?

19:58 - Derek Perez
  Yeah.

19:59 - Travis Corrigan (matterflowadvisors.com)
  And another file... File for...

20:01 - Derek Perez
  file. So that file exists, it's set, it uses them for the milestone, right? Uh-huh. Then at the end of the retro, it looks at the actuality of the tokens used, and then it proposes calibration adjustments to that very same file as a PR Aptifact.  Okay. At the end of the retro. Okay. It can decide, are these calibrated values, do I need to make any changes to any of the intervals?  Okay.

20:32 - Travis Corrigan (matterflowadvisors.com)
  Use that. Okay, got it. Use that for the Epic to make estimates. Then calibrate. Then during retro. Let's go to the Okay.

20:58 - Derek Perez
  Undyte Let Or at the end of the retro, because at that point, he'll have done tabulation of tokens. Once the retro is completed, it can then make a decision about if it needs to adjust the values in that very same file it used to assign buckets.  Because that's where it's going to have the opportunity to say, like, this is what I thought was true. These were the values we based that on.  This is what actually happened. Let me adjust them. But that's the same file in all scenarios. Because then the next run would then read the file after the adjustments were made, use that, right?  So it's just that one file. It's a mapping file, basically, somewhere in your plugin. Okay. It could be, I don't know, I saw you had a config YAML at some point.  So, I mean, it can just be that file. doesn't matter. Yeah.

22:02 - Travis Corrigan (matterflowadvisors.com)
  Where is that? PM config ammo. No, this one's not canonical.

22:18 - Derek Perez
  It feels like it is, but it says cloud PM configuration. Oh, sure. Put it in GitHub.github. So I think it would be in here.  So you just have a section that's like size estimates or something. Okay. And, you know, then it's like, what's the name of that label?  What's the interval range for tokens? There

24:03 - Travis Corrigan (matterflowadvisors.com)
  Okay. Okay. Section 8. I'm so glad we're doing this one. Code owners, because this is part I do know more than me.  Okay.

24:24 - Derek Perez
  Section 8. Code owners.

24:35 - Travis Corrigan (matterflowadvisors.com)
  And if you want, you can just put, like, feedback for me to copy and paste, like, into the bottom here.
  ACTION ITEM: Create CODEOWNERS; auto-assign PR reviewers; route ADRs/bugs - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=1479.9999

24:50 - Derek Perez
  I think this is fine. The primary thing that this should do, like, what it should do is when it makes a PR, it should automatically add somebody as the reviewer.  I think that's the. primary point here. I don't think it got anything wrong here. This is, this is correct.  It's just that file will say the basic file will say star your name and my comma my GitHub name.  It just tells it just gives it a way for it to know that it could route this to one of the people.  Yeah, got it. Where this also came up and it was relevant and maybe is worth calling out is you should also use this whenever you need to address.  somebody for like an ADR or a bug or any kind of, they should use that code owners beyond pull requests for other artifact routing.  Got it. As needed. And if it's available, which it already is kind of guessing that it's not. Which is correct.  Okay, cool.

25:53 - Travis Corrigan (matterflowadvisors.com)
  So let's see the section A9. 9, backlog management, clear user story, link to wiki, priority label, agency, yeah, this is fine.

26:12 - Derek Perez
  Yeah.

26:13 - Travis Corrigan (matterflowadvisors.com)
  There's not going to be much of a backlog, honestly. Yeah.

26:17 - Derek Perez
  Okay.

26:19 - Travis Corrigan (matterflowadvisors.com)
  Section 10, updated file directory structure. This makes sense. I mean, this is just like plug-in things. don't need to...

26:30 - Derek Perez
  Yeah, that sounds right to me. I don't need to worry about that.

26:33 - Travis Corrigan (matterflowadvisors.com)
  And then I think that's good. Okay. Okay. Anything else looks great. Let's continue. You know, what's interesting is that this, is sort of an impromptu ritual that I imagine we might end up doing quite a bit during brainstorming.  Yeah. So we should think about how to do this better. Yeah, I agree.

27:50 - Derek Perez
  I think we should let this happen a few times because I don't want to overcorrect for anything really. Totally.  I hope, go ahead. My... The inclination is that, for example, must-read could be transcripts.

28:06 - Travis Corrigan (matterflowadvisors.com)
  Must-read could be transcripts? Yeah, like, remember that label?

28:10 - Derek Perez
  Yes, right. We might get to the world where, like, we MCP these into, like, some place. Yeah. And then they have a must-read label, and then we want to reference them.  Because there's also, we're going to, I do think that, sadly, we'll probably need to move out of Fathom for this, and maybe to something more custom that allows the data to be, like, this conversation happened in a timeline.  And then the brainstorm window needs to support a timeline. So, like, there's going to be, like, things like that we're going to have to line up.  Yeah, for sure. Which, for now, is just going to be kind of tedious until we standardize that. Yeah.

28:48 - Travis Corrigan (matterflowadvisors.com)
  I mean, we have the transcripts, so, like, I mean, we're recording right now. So, just use this to just, like, as raw material for future PRD, right, for future things.  Yeah, potentially.

29:01 - Derek Perez
  I just don't know yet what I would argue for. So I'd like to feel the pain a little bit more before I decide we should do it.

29:11 - Travis Corrigan (matterflowadvisors.com)
  Yeah, we should change our tooling around it.

29:17 - Derek Perez
  Yeah, yeah. Like, let's let some things marinate before we get to that point. Yeah. I agree that I think that ultimately you're right, that will happen.  Yeah.

29:29 - Travis Corrigan (matterflowadvisors.com)
  I think that this thing that we've intuited here live and improvised, like, works totally well for me. Yeah, like, it hasn't broken down yet.

29:41 - Derek Perez
  So I think that's totally okay. Yeah.

29:45 - Travis Corrigan (matterflowadvisors.com)
  You know, what's interesting is we could probably update the using PM part to include... include... include... include... include... include...  include... Use MCP, like Google Drive MCP instructions for brainstorming to like, hey, create a Google doc and use that as a scratch pad.  Yeah, use that as a scratch pad for the humans to look at and review. I think that would be good.

30:20 - Derek Perez
  The only concern I have is that I have understood that the Google ecosystem really wants you to use Gemini to do that stuff.  And there's not a good bridge to Claude for Collab at this level. So it's potentially possible that we end up building that for ourselves with Hadron.  Sure.

30:42 - Travis Corrigan (matterflowadvisors.com)
  Like, I do think that at some point we're going to start using Hadron to solve internal problems.

30:47 - Derek Perez
  Yes, I agree. it's this enough, and then it can spawn a platform like that. Maybe it even does the video stuff.  I'm actually even, like, to be honest, the reason why I'm, like, apprehensive to get to ritual focus. Just yet is because I actually going to want to see if there's a version of this where we could actually be streaming the transcript live to GLOD.  That's what I'm thinking, right?

31:06 - Travis Corrigan (matterflowadvisors.com)
  The fact that I have to like stop and start these things, all that stuff. Like there's, there's every time I have to like click anything other than just talk and occasionally give it that feedback.  I'm like, yeah, for tool or a product.

31:24 - Derek Perez
  So I think we might find ourselves actually building something here. That would be bad.

31:31 - Travis Corrigan (matterflowadvisors.com)
  think, I think the open source version would include, yeah, man. I mean, this is a whole new way of collaborating.  Like human plus human, like multiple humans and at least one AI agent, or frankly, multiple AI agents. Cause we have sort of a dumb one listening right now.  Yeah.

31:50 - Derek Perez
  At least that's my sense is I think that's probably what's going to happen. And so I, I think that's, that's where I'm like, let's let this emerge a little bit and see.  see. Let's see. Let's see. see. Let's Yeah. Like how it feels. Yeah. Because I think that's what's going to end up happening.
  ACTION ITEM: Create project for plugin updates; run retros; propose improvements - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=1924.9999  How do you want to capture...

32:13 - Travis Corrigan (matterflowadvisors.com)
  Oh, wait, you know what? I'm just... Once this shifts, I'm actually going to spin up a project specifically for this repo.  Okay. Which will be the things that we decide to do to update this plugin. Okay. Yeah, I'll use the plugin to...  Generate the project for this plugin. And then use that going forward.

32:34 - Derek Perez
  Yeah, this is how we'll...

32:35 - Travis Corrigan (matterflowadvisors.com)
  like every time... Because you're going to do retros on your projects, but I also want to get retros from you on like what we need to do to improve this thing.  Yeah. Yeah, no, no, that makes sense.

32:45 - Derek Perez
  We should... Like as soon as this thing is enough kickstarted that it could manage itself, we should start doing that.

32:52 - Travis Corrigan (matterflowadvisors.com)
  Yeah. Cool.

32:55 - Derek Perez
  Sounds good. Awesome. Do you want the...

33:00 - Travis Corrigan (matterflowadvisors.com)
  It's, I think, writing, was it, did it finish writing the, it says it's transitioning to implementation, so I think it's doing these diffs.

33:10 - Derek Perez
  Why the ?

33:14 - Travis Corrigan (matterflowadvisors.com)
  I. Oh, it's writing an implementation plan.

33:17 - Derek Perez
  Ah.

33:19 - Travis Corrigan (matterflowadvisors.com)
  Here's the design doc. Do you want me to give that to you? No, that's fine.

33:24 - Derek Perez
  You can leave it there. Okay. Or just see what you think. But I, I mean, I think it's, we've given it a lot of good context, so I'm, I'm fairly confident.  Yeah.
  ACTION ITEM: Add Discussions category for transcripts w/ metadata; tag epic - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=2016.9999

33:36 - Travis Corrigan (matterflowadvisors.com)
  I think one other small feature I'd have is I, I, like, intuited this transcripts thing. Yeah. think I might, like, make that a first class feature as well.  Yeah.

33:47 - Derek Perez
  We, we might, that's, and you might, so this might be a good place to use discussions. Similar to, so there's an ADR cat, discussions can have a bunch of categories.  Mm-hmm. You might want to have a discussions section that's for transcripts. Okay. Okay, just send the transcript as a discussion, and that will give you like, what's nice about that is it could be numbered, like ADRs, and it will have metadata about timeline.  Yeah, right. And then we can also like say, and we'll tag that as like part of a PR, like part of this, this transcript is about this epic.  Yeah, yeah, yeah.

34:21 - Travis Corrigan (matterflowadvisors.com)
  And for the benefit of the blog posts that we'll generate from this transcript, why the  are we being so opinionated about all of this stuff?  Right. I would love to, I'll, you give your answer, and then I'll give mine. It's schemas.

34:36 - Derek Perez
  Yeah. By like, there's a lot of opinionation out there about being overfitted, like overprescriptive or overfitting, which I think is a relativization, right?  You can overfit something small, but the larger in scope and the more freedom of autonomy that you want. On offer, the more, the more resolution you have to provide more correction so that it doesn't ostensibly hallucinate or just start making decisions that are underspecified.  Yeah, right. Right. And so like, when you have a hyper rigid process, this is, I mean, I think this falls back into one of Limbic's core principles around no freelancing, right?  And as a structural thing, we don't want, we actually would never want a human or a computer to freelance process.  We want to reserve that to the work being done within the scope of a process. Yes, right.

35:48 - Travis Corrigan (matterflowadvisors.com)
  That would be my sense.

35:49 - Derek Perez
  I love it.

35:50 - Travis Corrigan (matterflowadvisors.com)
  Yeah, the no freelancing piece is just like been a thing we design process around for humans. Wow. Yeah, Thank you.  let's see Okay. right, Thank

37:00 - Derek Perez
  The term vibe coding wasn't popularized. And the concept of vibe prefixing something being like essentially underspecified. And I think the industry has moved to a world where they're now saying that we're over-specifying and that that comes at a context cost, that comes at a system cost.  You're constraining the possible solution space, you know, within the probabilisticness of the data structure that is LMs. But at the same time, it's somewhat necessary as a reality because you find with a lot of these systems, much like a hungover human, an oversaturated anthropic is load shedding and trying to cut corners to turn off a session as fast as it can.  Right. And so it's largely necessary to provide that balance to ensure that it's not slacking, essentially. basically actually Yeah.  You Yeah. Right. And I still believe there'll be defense and death things here that we're going to have to do.  Like, it's great that it's going to try its best to make sure that everything is linted and validated before it submits stuff.  But that doesn't negate the necessity for us to still probably have GitHub Actions that are doing async checks to verify that it did that actually.  Yeah, for sure. Raising those things. And that's the kind of thing we're going to have to, we'll, we'll end up iteratively adding to the system as additional players.  Yes.

38:28 - Travis Corrigan (matterflowadvisors.com)
  And I've been thinking a lot about like, where a hook would be good, right? So like, when not necessarily relying on GitHub Actions, but like, sort of to your point about like, doing the validation before sending it to GitHub is just like, yeah, like a hook should fire because that agent's going to get to a stop event.  Yeah. that's going to do the things it's going to do. And then like, we, it could actually let us know that locally before anything gets persisted to some sort of data store.  And like the thing to probably.

39:00 - Derek Perez
  There's a determinism, non-determinism thing you can introduce here. Hooks as an actual premise is a good option because what the hook could do is call another instance of clod.  Yes. Right. And so it could run a quick subprocess clod agent to do that validation and then shut down.  Yep. And say like, that was thumbs up or thumbs down. Right. Yep. And so that's a way to make sure deterministically that check is always ran.  But indeterministically, the process of validating that check doesn't have to actually be code. could still be an LLM-based analysis.  Yeah. That's not necessarily deterministic scripts. Yeah. It could be a combination of the two. It doesn't really matter. Yep.

39:48 - Travis Corrigan (matterflowadvisors.com)
  Cool.
  ACTION ITEM: Add Derek as collaborator to plugin repo - WATCH: https://fathom.video/share/tWev1ZdNRfJtkvN4oNcEkbr1tTcZYrsP?timestamp=2389.9999

39:49 - Derek Perez
  Yeah. Cool. Very nice. I'm to let this run and then I'll push.

39:54 - Travis Corrigan (matterflowadvisors.com)
  Um, at some point, uh, I don't know how to, how do do to give you access to this repo.  Just add me as a collaborator to your repo.

40:04 - Derek Perez
  Okay.

40:05 - Travis Corrigan (matterflowadvisors.com)
  And then at some point, we can just move this over to Limbic because this is basically my contribution to Limbic IP.  I mean, our contribution, right? But like. Yeah. I don't have a home, right?

40:16 - Derek Perez
  Like we have the old. Do you want to kill the bot? Give me a sec.
Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11229D374
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 22:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJ1VoM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 17:44:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgJ1VoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qyLut/lQOSjPD3/fKflfBS4RX7aI01fRQuerH9oDxCQ=; b=bAjHAGngmR1CSjCdacoKr+qz8l
        wFfFF4XK/rlaeEZFVnZLjBzZ3phJO5m0vsziWNw6m6fXkOAVBNosoMpJ4aJn9VSOauB8y02adoM1n
        9zONx9J2RTRqL1o5cqFFO/+o/pWnzoRiNHqVbLJm8jTbsZqZDODAv/u3YT4/n5rdvOoADmaDymhGS
        +tQpsFopdA9Pgyseiihuhz7d6lzb8kKhoJA5R2kX85G5UImtXgKibtzcBkJpmIQ5Sw8q8sgEwoyIJ
        GBF/XSLpL9zmWOGccnAL6XAoyIoBEt5K/lHPWmDe+QD8BepqG21R9wA2oRYo78Ndvcwy7vryX7fFM
        Tc2Ra13g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXrbE-0003To-Ej; Wed, 28 Oct 2020 19:59:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9298B300455;
        Wed, 28 Oct 2020 20:59:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DE8A2038A985; Wed, 28 Oct 2020 20:59:10 +0100 (CET)
Date:   Wed, 28 Oct 2020 20:59:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201028195910.GI2651@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
 <20201027154533.GB2611@hirez.programming.kicks-ass.net>
 <160381649396.10461.15013696719989662769@build.alporthouse.com>
 <160390684819.31966.12048967113267928793@build.alporthouse.com>
 <20201028194208.GF2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028194208.GF2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 28, 2020 at 08:42:09PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 05:40:48PM +0000, Chris Wilson wrote:
> > Quoting Chris Wilson (2020-10-27 16:34:53)
> > > Quoting Peter Zijlstra (2020-10-27 15:45:33)
> > > > On Tue, Oct 27, 2020 at 01:29:10PM +0000, Chris Wilson wrote:
> > > > 
> > > > > <4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
> > > > > <4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0
> > > > 
> > > > Urgh, I don't think I've _ever_ seen that warning trigger.
> > > > 
> > > > The comments that go with it suggest memory corruption is the most
> > > > likely trigger of it. Is it easy to trigger?
> > > 
> > > For the automated CI, yes, the few machines that run that particular HW
> > > test seem to hit it regularly. I have not yet reproduced it for myself.
> > > I thought it looked like something kasan would provide some insight for
> > > and we should get a kasan run through CI over the w/e. I suspect we've
> > > feed in some garbage and called it a lock.
> > 
> > I tracked it down to a second invocation of lock_acquire_shared_recursive()
> > intermingled with some other regular mutexes (in this case ww_mutex).
> > 
> > We hit this path in validate_chain():
> > 	/*
> > 	 * Mark recursive read, as we jump over it when
> > 	 * building dependencies (just like we jump over
> > 	 * trylock entries):
> > 	 */
> > 	if (ret == 2)
> > 		hlock->read = 2;
> > 
> > and that is modifying hlock_id() and so the chain-key, after it has
> > already been computed.
> 
> Ooh, interesting.. I'll have to go look at this in the morning, brain is
> fried already. Thanks for digging into it.

So that's commit f611e8cf98ec ("lockdep: Take read/write status in
consideration when generate chainkey") that did that.

So validate_chain() requires the new chain_key, but can change ->read
which then invalidates the chain_key we just calculated.

This happens when check_deadlock() returns 2, which only happens when:

  - next->read == 2 && ... ; however @hext is our @hlock, so that's
    pointless

  - when there's a nest_lock involved ; ww_mutex uses that !!!

I suppose something like the below _might_ just do it, but I haven't
compiled it, and like said, my brain is fried.

Boqun, could you have a look, you're a few timezones ahead of us so your
morning is earlier ;-)

---

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..3caf63532bc2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3556,7 +3556,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 
 static int validate_chain(struct task_struct *curr,
 			  struct held_lock *hlock,
-			  int chain_head, u64 chain_key)
+			  int chain_head, u64 *chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -3568,6 +3568,7 @@ static int validate_chain(struct task_struct *curr,
 	 * (If lookup_chain_cache_add() return with 1 it acquires
 	 * graph_lock for us)
 	 */
+again:
 	if (!hlock->trylock && hlock->check &&
 	    lookup_chain_cache_add(curr, hlock, chain_key)) {
 		/*
@@ -3597,8 +3598,12 @@ static int validate_chain(struct task_struct *curr,
 		 * building dependencies (just like we jump over
 		 * trylock entries):
 		 */
-		if (ret == 2)
+		if (ret == 2) {
 			hlock->read = 2;
+			*chain_key = iterate_chain_key(hlock->prev_chain_key, hlock_id(hlock));
+			goto again;
+		}
+
 		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
@@ -3620,7 +3625,7 @@ static int validate_chain(struct task_struct *curr,
 #else
 static inline int validate_chain(struct task_struct *curr,
 				 struct held_lock *hlock,
-				 int chain_head, u64 chain_key)
+				 int chain_head, u64 *chain_key)
 {
 	return 1;
 }
@@ -4834,7 +4839,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, &chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;

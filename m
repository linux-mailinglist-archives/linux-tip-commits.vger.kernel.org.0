Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CA406FC0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIJQho (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 12:37:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50139 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229481AbhIJQho (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 12:37:44 -0400
Received: (qmail 43535 invoked by uid 1000); 10 Sep 2021 12:36:32 -0400
Date:   Fri, 10 Sep 2021 12:36:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-tip-commits@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210910163632.GC39858@rowland.harvard.edu>
References: <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
 <YTtpnZuSId9yDUjB@boqun-archlinux>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <YTtpnZuSId9yDUjB@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2021 at 10:20:13PM +0800, Boqun Feng wrote:
> On Thu, Sep 09, 2021 at 11:00:05AM -0700, Paul E. McKenney wrote:
> [...]
> > 
> > Boqun, I vaguely remember a suggested change from you along these lines,
> > but now I cannot find it.  Could you please send it as a formal patch
> > if you have not already done so or point me at it if you have?
> > 
> 
> Here is a draft patch based on the change I did when I discussed with
> Peter, and I really want to hear Alan's thought first. Ideally, we
> should also have related litmus tests and send to linux-arch list so
> that we know the ordering is provided by every architecture.
> 
> Regards,
> Boqun
> 
> --------------------------------->8
> Subject: [PATCH] tools/memory-model: Provide extra ordering for
>  lock-{release,acquire} on the same CPU
> 
> A recent discussion[1] shows that we are in favor of strengthening the
> ordering of lock-release + lock-acquire on the same CPU: a lock-release
> and a po-after lock-acquire should provide the so-called RCtso ordering,
> that is a memory access S po-before the lock-release should be ordered
> against a memory access R po-after the lock-acquire, unless S is a store
> and R is a load.
> 
> The strengthening meets programmers' expection that "sequence of two
> locked regions to be ordered wrt each other" (from Linus), and can
> reduce the mental burden when using locks. Therefore add it in LKMM.
> 
> [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

The change to linux-kernel.cat looks fine.  However, I didn't like your 
update to explanation.txt.  Instead I wrote my own, given below.

I also wrote a couple of litmus tests which Paul can add to the 
appropriate archive.  They are attached to this email.  As expected, 
they fail (result Sometimes) with the current LKMM and succeed (Never) 
with Boqun's updated model.

Alan


--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these thin
 lock-acquires -- have two properties beyond those of ordinary releases
 and acquires.
 
-First, when a lock-acquire reads from a lock-release, the LKMM
-requires that every instruction po-before the lock-release must
-execute before any instruction po-after the lock-acquire.  This would
-naturally hold if the release and acquire operations were on different
-CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+First, when a lock-acquire reads from or is po-after a lock-release,
+the LKMM requires that every instruction po-before the lock-release
+must execute before any instruction po-after the lock-acquire.  This
+would naturally hold if the release and acquire operations were on
+different CPUs and accessed the same lock variable, but the LKMM says
+it also holds when they are on the same CPU, even if they access
+different lock variables.  For example:
 
 	int x, y;
-	spinlock_t s;
+	spinlock_t s, t;
 
 	P0()
 	{
@@ -1830,9 +1831,9 @@ For example:
 		spin_lock(&s);
 		r1 = READ_ONCE(x);
 		spin_unlock(&s);
-		spin_lock(&s);
+		spin_lock(&t);
 		r2 = READ_ONCE(y);
-		spin_unlock(&s);
+		spin_unlock(&t);
 	}
 
 	P1()
@@ -1842,10 +1843,10 @@ For example:
 		WRITE_ONCE(x, 1);
 	}
 
-Here the second spin_lock() reads from the first spin_unlock(), and
-therefore the load of x must execute before the load of y.  Thus we
-cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
-MP pattern).
+Here the second spin_lock() is po-after the first spin_unlock(), and
+therefore the load of x must execute before the load of y, even tbough
+the two locking operations use different locks.  Thus we cannot have
+r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
 
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
@@ -1872,13 +1873,13 @@ instructions in the following order:
 
 and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
 
-Second, when a lock-acquire reads from a lock-release, and some other
-stores W and W' occur po-before the lock-release and po-after the
-lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+Second, when a lock-acquire reads from or is po-after a lock-release,
+and some other stores W and W' occur po-before the lock-release and
+po-after the lock-acquire respectively, the LKMM requires that W must
+propagate to each CPU before W' does.  For example, consider:
 
 	int x, y;
-	spinlock_t x;
+	spinlock_t s;
 
 	P0()
 	{
@@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, c
 
 If r1 = 1 at the end then the spin_lock() in P1 must have read from
 the spin_unlock() in P0.  Hence the store to x must propagate to P2
-before the store to y does, so we cannot have r2 = 1 and r3 = 0.
+before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
+if P1 had used a lock variable different from s, the writes could have
+propagated in either order.  (On the other hand, if the code in P0 and
+P1 had all executed on a single CPU, as in the example before this
+one, then the writes would have propagated in order even if the two
+critical sections used different lock variables.)
 
 These two special requirements for lock-release and lock-acquire do
 not arise from the operational model.  Nevertheless, kernel developers


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ullk-rw.litmus"

C ullk-rw

(*
 * Result: Never
 *
 * If two locked critical sections execute on the same CPU, all accesses
 * in the first must execute before any accesses in the second, even if
 * the critical sections are protected by different locks.
 *)

{}

P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
{
	int r1;

	spin_lock(s);
	r1 = READ_ONCE(*x);
	spin_unlock(s);
	spin_lock(t);
	WRITE_ONCE(*y, 1);
	spin_unlock(t);
}

P1(int *x, int *y)
{
	int r2;

	r2 = smp_load_acquire(y);
	WRITE_ONCE(*x, 1);
}

exists (0:r1=1 /\ 1:r2=1)

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ullk-ww.litmus"

C ullk-ww

(*
 * Result: Never
 *
 * If two locked critical sections execute on the same CPU, stores in the
 * first must propagate to each CPU before stores in the second do, even if
 * the critical sections are protected by different locks.
 *)

{}

P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
{
	spin_lock(s);
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
	spin_lock(t);
	WRITE_ONCE(*y, 1);
	spin_unlock(t);
}

P1(int *x, int *y)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*y);
	smp_rmb();
	r2 = READ_ONCE(*x);
}

exists (1:r1=1 /\ 1:r2=0)

--OgqxwSJOaUobr8KG--

Return-Path: <linux-tip-commits+bounces-8005-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76BD23241
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 09:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01FF7302E7CE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663C335072;
	Thu, 15 Jan 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="dGtthnrK"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB85332917
	for <linux-tip-commits@vger.kernel.org>; Thu, 15 Jan 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465697; cv=none; b=I/od2j+lmtfk1um/ZuWRBM8oEC9cEP84UlyK96LzZ8miLs9BuM1qJAvUA3AMtZjFje3rOuao8mVQh15ZgdJ/a3nDUMr1vu+FmtnhG2PtxV/U5tnbbQHSdcaTAs7rGnH/X1SQe2hYRKYRHFbiy5vfOIQEWiNWpfWJZNarE0Z+aNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465697; c=relaxed/simple;
	bh=E0DeBVGvzA0R4GdbpoMK1DdggAK1f4m/cZfLWUu4NZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZj0APV7C18i/+0jevFTK/DsWg6dzjkinvmWX2Tedl3anYRKx60QXfj8/mcA9jRa/2/aK7nGfQFw9GsRUR3FaitPp9pqGWZxKHl9DEe5SG+LdLmWpMwMmtwRbGurefVWrswcJaztsXlLSeP8JJ7J7AVn3QKKQNOinvE+sNQkIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=dGtthnrK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Date: Thu, 15 Jan 2026 00:27:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1768465690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmyqBKK3dw7Cy94uoMuBCbiABoKKXT8Fru22p4fzVpA=;
	b=dGtthnrK1XySkCANgPrXldHy41Ul6OYQafjWw1JLXrFYyKjWCFFHHrVPBHJ+HiW26yV7SN
	P4cfyzHboqf6TKMAcQlxL1THIY48TLg8u9sBkNQ0CMo2hahRZc4wxyHg4BWWfc5ZyWkXcO
	7d2e6VP/MVUMNn+utlmeErYbrJjF5EQDqereL4ce3yQWVPzTbBfrTOdVjtTc+WdgnvKDyX
	g1ieU8nfWHpiyxmI/BXXai3A6/v9s8a9+7r9R2EXVfgVD/OA8u/c8aE3qLc2+FsdvsTXUP
	xbhRtOt85TJb9osnIT5us9we4OJzNg4ZVfx5XCmdVYoDLqU6D+Ip0CXN3JqywA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>,
	Cruz Zhao <CruzZhao@linux.alibaba.com>, tip-bot2@linutronix.de,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	mingo@kernel.org, x86@kernel.org,
	Peng Wang <peng_wang@linux.alibaba.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/urgent] sched/fair: Clear ->h_load_next when
 unregistering a cgroup
Message-ID: <aWilDYZ8S-yoZA9u@templeofstupid.com>
References: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
 <20251229125109.1995077-1-CruzZhao@linux.alibaba.com>
 <CAKfTPtCQW_Oj+P6nGx0nVO01CahSEqxuToO8kg=oe3yfuViOwg@mail.gmail.com>
 <aVh1Fiar6aC4W_1D@templeofstupid.com>
 <CAKfTPtC42qVKbng8bb8G4ebVz4PQ1HF3N5cyK3U0S37zxbTy-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC42qVKbng8bb8G4ebVz4PQ1HF3N5cyK3U0S37zxbTy-g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Vincent,
Thanks for the response.  I sat down to write you an e-mail about why
this was the right thing to do, but after working through the problem
now I'm less certain.

On Mon, Jan 12, 2026 at 06:32:44PM +0100, Vincent Guittot wrote:
> On Sat, 3 Jan 2026 at 02:47, Krister Johansen <kjlx@templeofstupid.com> wrote:
> > In the cases where I'm hitting this bug, the systems aren't using numa
> > balancing and aren't using nohz. 90% of ones I've analyzed are in a
> > futex wakeup and are holding the rcu_read_lock.
> 
> Do you have a simple way to reproduce it ?

I haven't come up with a minimal reproducer yet, but will send something
along if I can find a way to do this.

I do have lots of kdumps of this happening so if there's something you'd
like me to look for there, I'd be happy to do some additional digging.

The team that's running into this is only hitting it in a production
environment and so far has not been willing to let me drop in any kind
of test kernel.

> > This seems like just a case of the pointer continuing to reference
> > memory that was already free'd.  If the task group's sched entity is
> > freed, but the parent cfs_rq still has a pointer to that sched_entity in
> > h_load_next, then it may end up accessing that memory accidentally if we
> > do not clear it.
> 
> I agree that rcu protection does not prevent cfs_rq->h_load_next from
> holding a ref to the freed sched_entity after the grace period and
> until update_cfs_rq_h_load() overwrites it with another child. I just
> wonder how we can really end up with
>  traverse A->B->C because we do set B->D then set A->B when doing set
> list A->B->D

I spent some additional time analyzing a kdump that was collected on
the 12th.  The crash was caused by a write to read-only area of kernel
memory. The address turned out to be inside of css_free_rwork_fn.

The panic task was on CPU 4 trying to wake another thread in its process
that was sleeping in on futex, which last ran on CPU 2.  Another task was
already running on CPU 2.  The futex wake on CPU 4 didn't get far enough
to make a migration decision.

There are 8 cpus on this machine, 5 idle.  Cpu 0 running a metrics
collector, cpu 2 running the workload, and cpu 4 running a security
agent.  (Other tasks also trigger this panic, so I don't suspect any
particular one as the culprit).  The cgroup hierarchy on this machine
has enough nodes that a multi-node swap is possible.

I don't have details on whether other tasks that last ran on CPU 2 have
been awoken and relocated.

After the crash, the kdump does not show h_load_next list walks as
containing any errant pointers.  I manually checked these in crash, and
then when paranoia got the better of me, I wrote a drgn script that
walked up the se->parent pointers and back down the cfs_rq->h_load_next
pointers like task_h_load does, just looking to see if anything with an
address near the bad pointer was reachable.  No hits.

To fallback to the diagram from the patch:

               A
              / \
             /   \
            B     E
           / \    |
          /   \   t2
         C     D
         |     |
         t0    t1
   
C is presumed to be the dead and deleted leaf cgroup and t0 has exited.

I think it would have been helpful if the original submitters were more
concrete about which weak ordering rules were playing a role in the
problem. I had to look at [1],[2],[3] to get some sense of what the
rules are.  The writes issued by a thread may be observed in a different
order by other threads, but for writes to the same address all threads
must observe the writes in the same order and they must be visible at
the same time.

Without barriers remote cpus may see the writes in a different order
than the cpu that issued these writes, but they all must have the same
order when they're visible to the remote cpus.

With this in mind, the wakeup on CPU 4 could find the h_load_next list
in the following order:

    A -> B -> C

And issue stores:

   e->h_load_next = NULL
   a->h_load_next = e

The disassembly shows load/store dependencies for the executing thread,
but depending on how those dependencies are resolved the writes might
not be visibile to other threads in the same order.  Consequently, if
there's another waker it could issue:

  d->h_load_next = NULL
  b->h_load_next = d
  a->h_load_next = b

and there's at least a possibility of the cpu handling the wakeup of t2
seeing the store of b to a->h_load_next in an order that is before b ->
d, possibly because the dependent loads for a->h_load_next were cached
and could be retired sooner. For this to happen the stores have to be
after the a->e store, but the subsequent a->b store has to be visible
sooner and seen by cpu 4's subsequent load.

I assumed that part of the reason why this patch worked was that it's
implicitly depending on the write barrier in the rq_lock_irqsave that's
in unregister_fair_sched_group.  On 5.10, where the author originally
encountered this, the spin lock is taken unconditionally on each cpu in
turn. In 6.19, this is only taken for the se->sched_delayed and
cfs_rq->on_list cases.  I'm curious if the authors managed to reproduce
the problem on 6.19 as part of validating the fix.

[1] https://www.cl.cam.ac.uk/~pes20/armv8-mca/armv8-mca-draft.pdf
[2] https://www.cl.cam.ac.uk/~pes20/armv8-mca/full_flat.pdf
[3] https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test7.pdf

-K


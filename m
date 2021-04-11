Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1735B509
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhDKNoy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhDKNoQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:16 -0400
Date:   Sun, 11 Apr 2021 13:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DP6pxjDVTN/1Qkihg6zPcnQ2DSX38ywo5UpQGvLF+QY=;
        b=Qp4FJpvrTX1ietD2fR/o9QZTX9JrmS4keUzZYYGtMYEApkXcB5baho7Cls5H81+1W/N4hu
        OioWw9dj0HsK2nSQgPUV4q0NpSKyvctnOen3PfAkRJrNbX9ihgchgxPujh2/1mUb+syPKt
        HkSuQ+RhKgWror/SUJJXbSk6HH4gYcXN/gH0ahS20PMctU7Yu1oistUJORQqO5v9TmyjGA
        N0mz320neLGLSe8uDX2/wNef86BdZM700xVB88muIyKTYn7WyrtE9ptSYMIilPaMToAmI6
        oYoWIU8a3uk+SRvnNiIjEoN/jHYYGhHdiUROvdKnX3kUQsFTgJPzq7VPFHPrfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DP6pxjDVTN/1Qkihg6zPcnQ2DSX38ywo5UpQGvLF+QY=;
        b=7tDfRMwYwa5IQRbQXc9fCZTnHecwGZXQ0j30Biur9lAoRe5HmaKM42MTGCuRAQm/IjdqlF
        fl/kApm3y2/dBxDQ==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Use same set of GFP flags as does single-argument
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861967.29796.6151266879848962264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ee6ddf58475cce8a3d3697614679cd8cb4a6f583
Gitweb:        https://git.kernel.org/tip/ee6ddf58475cce8a3d3697614679cd8cb4a6f583
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Fri, 29 Jan 2021 21:05:05 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

kvfree_rcu: Use same set of GFP flags as does single-argument

Running an rcuscale stress-suite can lead to "Out of memory" of a
system. This can happen under high memory pressure with a small amount
of physical memory.

For example, a KVM test configuration with 64 CPUs and 512 megabytes
can result in OOM when running rcuscale with below parameters:

../kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
--bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 \
  rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make

<snip>
[   12.054448] kworker/1:1H invoked oom-killer: gfp_mask=0x2cc0(GFP_KERNEL|__GFP_NOWARN), order=0, oom_score_adj=0
[   12.055303] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
[   12.055416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
[   12.056485] Workqueue: events_highpri fill_page_cache_func
[   12.056485] Call Trace:
[   12.056485]  dump_stack+0x57/0x6a
[   12.056485]  dump_header+0x4c/0x30a
[   12.056485]  ? del_timer_sync+0x20/0x30
[   12.056485]  out_of_memory.cold.47+0xa/0x7e
[   12.056485]  __alloc_pages_slowpath.constprop.123+0x82f/0xc00
[   12.056485]  __alloc_pages_nodemask+0x289/0x2c0
[   12.056485]  __get_free_pages+0x8/0x30
[   12.056485]  fill_page_cache_func+0x39/0xb0
[   12.056485]  process_one_work+0x1ed/0x3b0
[   12.056485]  ? process_one_work+0x3b0/0x3b0
[   12.060485]  worker_thread+0x28/0x3c0
[   12.060485]  ? process_one_work+0x3b0/0x3b0
[   12.060485]  kthread+0x138/0x160
[   12.060485]  ? kthread_park+0x80/0x80
[   12.060485]  ret_from_fork+0x22/0x30
[   12.062156] Mem-Info:
[   12.062350] active_anon:0 inactive_anon:0 isolated_anon:0
[   12.062350]  active_file:0 inactive_file:0 isolated_file:0
[   12.062350]  unevictable:0 dirty:0 writeback:0
[   12.062350]  slab_reclaimable:2797 slab_unreclaimable:80920
[   12.062350]  mapped:1 shmem:2 pagetables:8 bounce:0
[   12.062350]  free:10488 free_pcp:1227 free_cma:0
...
[   12.101610] Out of memory and no killable processes...
[   12.102042] Kernel panic - not syncing: System is deadlocked on memory
[   12.102583] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
[   12.102600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
<snip>

Because kvfree_rcu() has a fallback path, memory allocation failure is
not the end of the world.  Furthermore, the added overhead of aggressive
GFP settings must be balanced against the overhead of the fallback path,
which is a cache miss for double-argument kvfree_rcu() and a call to
synchronize_rcu() for single-argument kvfree_rcu().  The current choice
of GFP_KERNEL|__GFP_NOWARN can result in longer latencies than a call
to synchronize_rcu(), so less-tenacious GFP flags would be helpful.

Here is the tradeoff that must be balanced:
    a) Minimize use of the fallback path,
    b) Avoid pushing the system into OOM,
    c) Bound allocation latency to that of synchronize_rcu(), and
    d) Leave the emergency reserves to use cases lacking fallbacks.

This commit therefore changes GFP flags from GFP_KERNEL|__GFP_NOWARN to
GFP_KERNEL|__GFP_NORETRY|__GFP_NOMEMALLOC|__GFP_NOWARN.  This combination
leaves the emergency reserves alone and can initiate reclaim, but will
not invoke the OOM killer.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ecc1fb..4120d4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3463,7 +3463,7 @@ static void fill_page_cache_func(struct work_struct *work)
 
 	for (i = 0; i < rcu_min_cached_objs; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
-			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
 		if (bnode) {
 			raw_spin_lock_irqsave(&krcp->lock, flags);

Return-Path: <linux-tip-commits+bounces-2545-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E69AFBDA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA2BB23E25
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84A1CEEB8;
	Fri, 25 Oct 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQqAjjDN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0BuUikj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35A1C4A12;
	Fri, 25 Oct 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843335; cv=none; b=D/GQ4ajF65O0OexM+8KnlM8A4tK3b6YNC5BL2ughmO1q6G5KK33A4LZniefsttm57wIqm2kryS2sNjTIDD0D/eZa6qr+mPqc3x7ZN44fynCIk+DwTqJh6oROivwmVhA+waTUypTBCzBoqPKDxl+JCDVgmljpEg79dlWdosGKFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843335; c=relaxed/simple;
	bh=mrHQijhExrLkbSRNPq66ZACgLhbYQ4yj+NR6ZBveYEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PZ7mnN0MHv7OfT2kDcFvheUM1oH5FrmMT95vWtXho/HjFNl+fTs9IGz5iWXKKXAZkpsh/0tDeqe+A0GgHaIGdPilp2UAEu9qDSGLZHnHrjgEVWCbu5y8Ipm0i8xdzoC07feJn4oYbWhFBkfBRCYyiBIWaGCKVjdWzC1VdjbcrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQqAjjDN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0BuUikj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 08:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729843330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A3bkbqzE3mdyb6/CSaT0KRK5i9bRV70ZeKeG/hgY14=;
	b=gQqAjjDN3MEa3nJBdnt767WwvngTHmoUSr3GoC3WnqO5euFvLjU0X2elIVk3q+Dul2KOYg
	RjqCcDFwMJT6nwdrnDIjp828AUQfjS+7bleFBO3kH5pAbb0GbubdVxhIrpacw1CaOLFLfl
	mO7eyrorp/ZB0FhTKfO1WyfwNw35Mb/5Rdpg05z3atQD/+hnxp6CsJyeT+F0UVMTKHgHUF
	+NJA5nZUkLBdQ3r39IEyuFcqHXHWS8FeJz602CwggQPQ+XO1Os3757Rj+B+zYplshHf1fF
	CNZBQrqMJyBf5GQFRsdTXA47ySIffUIPG8vjPIBebGHM4+2KXr1MW3cTHR3XTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729843330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A3bkbqzE3mdyb6/CSaT0KRK5i9bRV70ZeKeG/hgY14=;
	b=v0BuUikjPWqqJjcgO9ZpMBtJySMst69cXLcWNap4nxAuKeb4bpZ9eM/4I7bFi2JRBaXFp2
	TMdTXfRJ0ATRLyBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix missing RCU reader protection in
 perf_event_clear_cpumask()
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Kan Liang <kan.liang@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240913162340.2142976-1-kan.liang@linux.intel.com>
References: <20240913162340.2142976-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172984332942.1442.8807119394229092755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e3dfd64c1f344ebec9397719244c27b360255855
Gitweb:        https://git.kernel.org/tip/e3dfd64c1f344ebec9397719244c27b360255855
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 13 Sep 2024 09:23:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Oct 2024 20:52:25 +02:00

perf: Fix missing RCU reader protection in perf_event_clear_cpumask()

Running rcutorture scenario TREE05, the below warning is triggered.

[   32.604594] WARNING: suspicious RCU usage
[   32.605928] 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238 Not tainted
[   32.607812] -----------------------------
[   32.609140] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
[   32.611595] other info that might help us debug this:
[   32.614247] rcu_scheduler_active = 2, debug_locks = 1
[   32.616392] 3 locks held by cpuhp/4/35:
[   32.617687]  #0: ffffffffb666a650 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
[   32.620563]  #1: ffffffffb666cd20 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
[   32.623412]  #2: ffffffffb677c288 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2f0

In perf_event_clear_cpumask(), uses list_for_each_entry_rcu() without an
obvious RCU read-side critical section.

Either pmus_srcu or pmus_lock is good enough to protect the pmus list.
In the current context, pmus_lock is already held. The
list_for_each_entry_rcu() is not required.

Fixes: 4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")
Closes: https://lore.kernel.org/lkml/2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop/
Closes: https://lore.kernel.org/oe-lkp/202409131559.545634cc-oliver.sang@intel.com
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240913162340.2142976-1-kan.liang@linux.intel.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd0976..df27d08 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13959,7 +13959,7 @@ static void perf_event_clear_cpumask(unsigned int cpu)
 	}
 
 	/* migrate */
-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+	list_for_each_entry(pmu, &pmus, entry) {
 		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
 		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
 			continue;


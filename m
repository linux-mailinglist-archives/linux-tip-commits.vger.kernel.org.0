Return-Path: <linux-tip-commits+bounces-5805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BDAD8480
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455DF7ABC9D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347372EBDCC;
	Fri, 13 Jun 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhxMusv1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iH+lnLKN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF92EB5BA;
	Fri, 13 Jun 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800252; cv=none; b=A4lf3r7NB1la8L1vf8+oIZqV0B7UIeul0YPUxfFLomE98tnjyrAAAdxpj6V2hqHCBAtn7R/330sCJetKzf/wcVWscZHqFDN6BOUCad5qdzWtIVEZTbbqTbruWpMpyylJFgSUcDjASOyl+dvk/PomlWzGvuvYtMKYvMaVpIddgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800252; c=relaxed/simple;
	bh=hY65CTl54Nh/RhOCoFPmRtpimId3Bf+PvMgwTQR812U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=opdFk3JnC2lw7JCtdGCyYxN3E4ROmb1KB1/7dU6ydpXsh9VjKGMpQi1zrlhjJs0Niu+k1KmR3r2ZHg32A9Hg3c37zIPP83BFiLcYZBpeVlj7jxIFYKvwjxev49iVmZOl2wuI3MPq7LHHLo3BnIqQmswY2VXtCis6/PMPTxzaGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhxMusv1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iH+lnLKN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytk3/Aq+BfkWFYq+jLSVo90u8f8Kw0iB6tyyXnl+0rY=;
	b=vhxMusv1Hh+OEDXNvEu0dRhSJmX7U2AGdr/s+zoJzCT2LgEWtoHUzq3V/fmN2EY7Hx4rj/
	mQfI/QJXThGqIyrB+6HJGDOPExyVV40bHpHnJDf3om1VPmKhfu44onbx+EAaLOeghBwrJ7
	V3mMPc46WCn6YzbOi7a3lA7SPeN2FDut+mW9nTnzXkp4KusIIOVt//JYC9/MefSMtpAF23
	+dVkG3SSJxP8CXjijsqSXDyQWxPoOrr1VRaMZWUTDZ/xUbJCt+tgToa7ZRcNVllbVJIYS1
	eV4ClSC8cxdDOkmwXg9jpFqmwS7DPJZw2biolRuU/1O62fZF3Rvq7QBy+NpN5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytk3/Aq+BfkWFYq+jLSVo90u8f8Kw0iB6tyyXnl+0rY=;
	b=iH+lnLKNoQgJ5H62a0v66bUR33BS+yW03wCgfJIGHHC17cbwTy5UCG5+LYrLNiXYLXqKzj
	WA3gfCVorep6FnAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/syscalls.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-18-mingo@kernel.org>
References: <20250528080924.2273858-18-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024818.406.18284991973415229497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23d27e2cfbee69d85b867a427c3021234bcf09ab
Gitweb:        https://git.kernel.org/tip/23d27e2cfbee69d85b867a427c3021234bcf09ab
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:18 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/syscalls.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-18-mingo@kernel.org
---
 kernel/sched/syscalls.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 547c1f0..5cb5e94 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -174,7 +174,7 @@ SYSCALL_DEFINE1(nice, int, increment)
 	return 0;
 }
 
-#endif
+#endif /* __ARCH_WANT_SYS_NICE */
 
 /**
  * task_prio - return the priority value of a given task.
@@ -255,8 +255,7 @@ int sched_core_idle_cpu(int cpu)
 
 	return idle_cpu(cpu);
 }
-
-#endif
+#endif /* CONFIG_SCHED_CORE */
 
 /**
  * find_process_by_pid - find a process with a matching PID value.
@@ -448,7 +447,7 @@ static inline int uclamp_validate(struct task_struct *p,
 }
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
-#endif
+#endif /* !CONFIG_UCLAMP_TASK */
 
 /*
  * Allow unprivileged RT tasks to decrease priority.
@@ -658,7 +657,7 @@ change:
 				goto unlock;
 			}
 		}
-#endif
+#endif /* CONFIG_SMP */
 	}
 
 	/* Re-check policy now with rq lock held: */


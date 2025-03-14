Return-Path: <linux-tip-commits+bounces-4224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B76A61C9F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B47319C425C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A42063D0;
	Fri, 14 Mar 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMcnU4n2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JL13NzfW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA5204F8D;
	Fri, 14 Mar 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983898; cv=none; b=dba9FnSdYwo9tpWCy+IZWiO7fQTNePveQDMlzgceDFyv8u1Gv64Z+Jb1pzlhkUrfQGP5ttG9k2LnKcZi53F6X+NneIVS/XtnHdZA7ebdyTEY8ANJS0LigzpNZPid7PDQ0jZYnOL/Wrsd1b3a6z4VJnbWuz+ij7NVpuSjbmBIpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983898; c=relaxed/simple;
	bh=p45vM0xMPg/lg4/VXoM5+vmaxs0CEy0qpaTqGyYOnJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cbWhAgYmyueytGF+JGzYIMrdwiE3LjgUuRCdydd348Imfw47RF6sZde3CXwBzFf2aewIOdpCLIOHdEs5JAUwLNwnm/4QkolMxURvKojgO/06HFiiylKaU3uTnZgyuyXo9teKQc7PZEALxzmBqGWgGvA5q/Tps1PDlkHBLcNoC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMcnU4n2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JL13NzfW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:24:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741983894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujiLRTsqzxMQjJn8lDFpHGxGGQtx3HwoP9PWymzQrVk=;
	b=JMcnU4n2nK0Nk2XZDbJrCnrun2S+SzGNqGxBZ21CziJ/A16lXX9Kzkq4ue4bW6cR3XYLT4
	iAF/2PjIFpIIwx7FI65hMgeLdPdhTSkLi0VRIsBSH4OZrm97RJuoBnglrRg5UEg9HEszEz
	CqgNDC7wQW9N9OlzqckBZH2ZKiA0Ny4TL25qrfz/eaINOAmJS7czV1yqqELv/9pYp3rHcl
	dgtCSeymPvCzI0Ctgf1spK2AkiII5LUwoi1S2nDe+IlfHMhoi5AXES72+nTDSaSYbgab91
	oZp35EMyZfa348XEVwYNgwc+7pef1Mhh3/cKwsFP3Q/m5SA/wDTbYA9gmdFuxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741983894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujiLRTsqzxMQjJn8lDFpHGxGGQtx3HwoP9PWymzQrVk=;
	b=JL13NzfWc6YG90gkyO1COdx/riuwzGzI7x+FFcDdFZSMYcW2/JRkmyvDRWbNDe2LYVgeUx
	Q83SZ6AFosPDh+Dw==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/uclamp: Add uclamp_is_used() check before enable it
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219093747.2612-2-xuewen.yan@unisoc.com>
References: <20250219093747.2612-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198389366.14745.13900064422716479622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4a14bd0c67d5670844c54356a163aa0ce623dbe1
Gitweb:        https://git.kernel.org/tip/4a14bd0c67d5670844c54356a163aa0ce623dbe1
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 19 Feb 2025 17:37:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Mar 2025 21:13:19 +01:00

sched/uclamp: Add uclamp_is_used() check before enable it

Because the static_branch_enable() would get the cpus_read_lock(),
and sometimes users may frequently set the uclamp value of tasks,
and this operation would call the static_branch_enable()
frequently, so add the uclamp_is_used() check to prevent calling
the cpus_read_lock() frequently.
And to make the code more concise, add a helper function to encapsulate
this and use it everywhere we enable sched_uclamp_used.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250219093747.2612-2-xuewen.yan@unisoc.com
---
 kernel/sched/core.c     |  6 +++---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/syscalls.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45daa41..03d7b63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1941,12 +1941,12 @@ static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
 	}
 
 	if (update_root_tg) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_update_root_tg();
 	}
 
 	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_sync_util_min_rt_default();
 	}
 
@@ -9294,7 +9294,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	guard(mutex)(&uclamp_mutex);
 	guard(rcu)();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8d42d3c..0212a0c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3407,6 +3407,18 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+/*
+ * Enabling static branches would get the cpus_read_lock(),
+ * check whether uclamp_is_used before enable it to avoid always
+ * calling cpus_read_lock(). Because we never disable this
+ * static key once enable it.
+ */
+static inline void sched_uclamp_enable(void)
+{
+	if (!uclamp_is_used())
+		static_branch_enable(&sched_uclamp_used);
+}
+
 static inline unsigned long uclamp_rq_get(struct rq *rq,
 					  enum uclamp_id clamp_id)
 {
@@ -3486,6 +3498,8 @@ static inline bool uclamp_is_used(void)
 	return false;
 }
 
+static inline void sched_uclamp_enable(void) {}
+
 static inline unsigned long
 uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
 {
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 9f40348..c326de1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -368,7 +368,7 @@ static int uclamp_validate(struct task_struct *p,
 	 * blocking operation which obviously cannot be done while holding
 	 * scheduler locks.
 	 */
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	return 0;
 }


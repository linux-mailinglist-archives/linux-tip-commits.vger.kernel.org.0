Return-Path: <linux-tip-commits+bounces-4771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B9A81581
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5762618978B4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FB2571BA;
	Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRFBdcGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Klcgt4Zi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EF2566F6;
	Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139142; cv=none; b=n0VwcUF5VhsLdIv2V5nwq8Dc9XlCYYsJM2/2BrjPv7eDvJwUno0FspnduI+SbAv0TwsRAxttte/5TssMbGFVr2HvjDYrYTJgXH6Q/AKV1GDtAI7mdAcw8/TYh4kdqD6LgB770VWz8DekNUld1GKOPKh8iJLkRqz0SYXO1LtOwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139142; c=relaxed/simple;
	bh=egQk8SE4EvVXg0k9opnExpx7g1hltmC3YPuvUS9IdvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lerhudRfFC/nNDPgEHSwAVpwMW2aHReI1f7Vxfdt/5sby5Wt2zcA+UkXdkozcKrIER4vkxZs8uGuhjyTqcu3PpErZ40J1X/4rmGW1ntX6yDL+sYin41ftWC3DC/3H+FPjxtvdKVOo8XpwbXWFactRRqwtcT6Kx8zqAJTlMi6AgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRFBdcGu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Klcgt4Zi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huxHGz968rmBlwh4/vl65pK6xYX8iswjfZAR2BG5mLI=;
	b=NRFBdcGuPRy9WLJ8mnydkaPQYDCqDNEtrIrgHSAU3JLYFQUfttVxrfW6PLe4ywIEZbk5OX
	gA3gXLYFu6FKTHVvQyR/X0iRRrAUYJq4IKIwUowQBv+y2bAa/ztb+ToeKVaLjoBP65E0sV
	aM+YyL2D567WdoAYrxdd67m4yYlRVzQ/Byy9QE34hT1bnHPh7i3KSzA/WxyaU6ApS8uCW4
	rXnRK3WOffzcdpcm143cRJLu2LOsu7wuUmuZ7ppiatruazojnJaymp1WoCiwRBtVqutRin
	z31fI64VuNN0j7kNBOpHvN5yC+x2nyeDE+Q7f9e/cf6uYLLb9SlCP7Ac4lalmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huxHGz968rmBlwh4/vl65pK6xYX8iswjfZAR2BG5mLI=;
	b=Klcgt4ZiCKewNmCmdi4Xnu+zmm/5uXG0KXk0m6AHvkOPzuOi5mOBUCXuA3GM2xxEh0Vpce
	MEiqpM4HUnwTNaAw==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Convert CONFIG_RT_GROUP_SCHED macros to code
 conditions
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-2-mkoutny@suse.com>
References: <20250310170442.504716-2-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913751.31282.777696833300765718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     433bce5dadb4ec3d5eda99c5125926c045b79005
Gitweb:        https://git.kernel.org/tip/433bce5dadb4ec3d5eda99c5125926c045b=
79005
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:52 +02:00

sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions

Convert the blocks guarded by macros to regular code so that the RT
group code gets more compile validation. Reasoning is in
Documentation/process/coding-style.rst 21) Conditional Compilation.
With that, no functional change is expected.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-2-mkoutny@suse.com
---
 kernel/sched/rt.c       | 10 ++++------
 kernel/sched/syscalls.c |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fa03ec3..2ade81e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1066,13 +1066,12 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int pr=
ev_prio)
 {
 	struct rq *rq =3D rq_of_rt_rq(rt_rq);
=20
-#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (&rq->rt !=3D rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt !=3D rt_rq)
 		return;
-#endif
+
 	if (rq->online && prio < prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
@@ -1082,13 +1081,12 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int pr=
ev_prio)
 {
 	struct rq *rq =3D rq_of_rt_rq(rt_rq);
=20
-#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (&rq->rt !=3D rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt !=3D rt_rq)
 		return;
-#endif
+
 	if (rq->online && rt_rq->highest_prio.curr !=3D prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rt_rq->highest_prio.curr);
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index c326de1..2bf5281 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -640,7 +640,7 @@ change:
 			retval =3D -EPERM;
 			goto unlock;
 		}
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 #ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {


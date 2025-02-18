Return-Path: <linux-tip-commits+bounces-3459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4EEA3987C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C403BAB04
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545812451F0;
	Tue, 18 Feb 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYFLYHEB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GtBBL5u3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F124395D;
	Tue, 18 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873219; cv=none; b=YNvpJ/gxio+7Ny047X50e2WB3gdY7XGIxpiX5V5Prp18qiuo47jJew5WeOznYp83YqTKQwqkXipMddF3GcFLkEoJ5LLjnL3sygXU02/R5C+YBiABNuFEwkPv7Kje3ps5M4Hv4tpZkdkzVxVpLWc/bfbQn7/zITQ1EJOZfJxYSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873219; c=relaxed/simple;
	bh=PuOA7xfSGzmES9oPL9OVcxee9wFqpbP4ttW4pO+hxw4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pUz+LeCtajG7zHQGZZ/vvKvtaCXn5ce+mlJ6nj8yN0lz6dsvf9aaQl9mN+SjmlzIkj3DdV663T+TP5rRTmwA57BPCof2RDuv7K9QHMBmCKF6CVELAYpKsWrOezIrJ0XxXmLSzevHB8VzkkQ2SGuRHRQ9WRiVLDFG8F6M7/qDyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYFLYHEB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GtBBL5u3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI/7eP3CztwJUlUoV53sswfTmWiKe0tyj0fOpt8KGEE=;
	b=XYFLYHEBXHlan32aDh1ZDp3MJxHfkX+d4vDeEExRCDt/DyPEhWXAPHxjdY/rDuKoKcN2qp
	y9sMnsaZZqwTLqwPdRydA3rmCgRTBjAcrsmmmQrfdtl/qoNzbJYYqr/Nvb2j4Dq7Ra79gF
	g2GdtH0smbDVtg/X4Mskn8kLeWq54jKOI/qC5O7z9j70ZdCT30l0IJ7VYlLazPgJPZOlEo
	Yq/w71kzezfN9fOqpWjaUwHfvbozflZ6n3RVWr63oOcRuPcYGl+LmXm/YfKSNgTAwCS/pA
	A+EAybSXWRjHl4b23sD7j5btXYIDyWzJCZ8tDlRN0rEsy5gH2CjOmVQTsHzQog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI/7eP3CztwJUlUoV53sswfTmWiKe0tyj0fOpt8KGEE=;
	b=GtBBL5u3PbLy/HVsaueDS+5OcX0Txuc3XXc/jUCa8y84P4Y/eMp4l1a1MNXnmSIWjlaev0
	q67T5aUKOCmJ5nAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net/sched: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf1d4843589dd924743b35de1f0920c4a4c43be01=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf1d4843589dd924743b35de1f0920c4a4c43be01=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321435.10177.2405286012826364127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     efcb2d32a8f5afb4173a868a7616db1718641420
Gitweb:        https://git.kernel.org/tip/efcb2d32a8f5afb4173a868a7616db1718641420
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:44 +01:00

net/sched: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/f1d4843589dd924743b35de1f0920c4a4c43be01.1738746872.git.namcao@linutronix.de

---
 net/sched/act_gate.c   | 3 +--
 net/sched/sch_api.c    | 3 +--
 net/sched/sch_taprio.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 91c0ec7..c1f75f2 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -287,8 +287,7 @@ static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
 	gact->param.tcfg_basetime = basetime;
 	gact->param.tcfg_clockid = clockid;
 	gact->tk_offset = tko;
-	hrtimer_init(&gact->hitimer, clockid, HRTIMER_MODE_ABS_SOFT);
-	gact->hitimer.function = gate_timer_func;
+	hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_ABS_SOFT);
 }
 
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf..6d85b34 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -619,8 +619,7 @@ static enum hrtimer_restart qdisc_watchdog(struct hrtimer *timer)
 void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qdisc,
 				 clockid_t clockid)
 {
-	hrtimer_init(&wd->timer, clockid, HRTIMER_MODE_ABS_PINNED);
-	wd->timer.function = qdisc_watchdog;
+	hrtimer_setup(&wd->timer, qdisc_watchdog, clockid, HRTIMER_MODE_ABS_PINNED);
 	wd->qdisc = qdisc;
 }
 EXPORT_SYMBOL(qdisc_watchdog_init_clockid);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a68e178..14021b8 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1932,8 +1932,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (!TXTIME_ASSIST_IS_ENABLED(q->flags) &&
 	    !FULL_OFFLOAD_IS_ENABLED(q->flags) &&
 	    !hrtimer_active(&q->advance_timer)) {
-		hrtimer_init(&q->advance_timer, q->clockid, HRTIMER_MODE_ABS);
-		q->advance_timer.function = advance_sched;
+		hrtimer_setup(&q->advance_timer, advance_sched, q->clockid, HRTIMER_MODE_ABS);
 	}
 
 	err = taprio_get_start_time(sch, new_admin, &start);
@@ -2056,8 +2055,7 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 
 	spin_lock_init(&q->current_entry_lock);
 
-	hrtimer_init(&q->advance_timer, CLOCK_TAI, HRTIMER_MODE_ABS);
-	q->advance_timer.function = advance_sched;
+	hrtimer_setup(&q->advance_timer, advance_sched, CLOCK_TAI, HRTIMER_MODE_ABS);
 
 	q->root = sch;
 


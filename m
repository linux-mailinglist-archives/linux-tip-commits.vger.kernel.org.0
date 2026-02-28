Return-Path: <linux-tip-commits+bounces-8328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFujK6YOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:58 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490941C422F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94FE31E46DF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2347D93E;
	Sat, 28 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3y82gz5Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drqxtr7q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EB480DF1;
	Sat, 28 Feb 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293025; cv=none; b=HJ6Ah4cmuVoiuoyh3WLIVCSvtpSvz24ecRZLfvZeQViMqw6/Nls82HjhbYEkWq0oEGEgIv2ezkk0aoLKpuQ9AIz8FC52TlPl8n9oNjM8cNMy97vssWAO0Y4gkRL72wCTX7rDp6Cbl3rOzOPxFRBUEzeMoTs0Qj6NAIFNWVTduEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293025; c=relaxed/simple;
	bh=Nk8BoOMJYnSxTqmOhwiIR2pEgwLeZqA35ZkfA3rc5P0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=owB4eGt+H1L43GlO+4wVjh9UihdlL28etnwjdir2EKu21h0jPq+I2m6G/KtLu0iSYsPmMB7PvhY9Zxikiu+cuU6hDUqTvDxMQT4D0gPVISBwOg1LwMge97UeapTRoJ61n6/n+ifGtOcFBKQ9pLDo3c2dgwvdm4j8CxFybIJsNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3y82gz5Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drqxtr7q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kADvfZsCO68G+54YDQmVqoP+aF1U+sSsvLrCmUi/p8c=;
	b=3y82gz5Y+TrPqV04NpqMIrAOw7VxK+OnBkY7Csp4xFpghGwTarwtLEx6ZTfPufkqMhuU4m
	iDZ7WkjVkeyqVCatfJlhuyuekn976EETtltdRNJM39hxB8R4iOOrgWsx0ayEmY2mIrUpBd
	OQOJ13rDY5NH8nrLC6Q387wmF2iO1Do5owB+b2xXMg670KP8FZs7MHPizGEK1EWMkzd3Oh
	TO3eTuHCm3bqqgXwwqLlJCgoc8aEFjpiHFUULM/LQXHxhJCtA7ENpd6fgxFMQFttQ31eOU
	Lv6fLAQ4pwKt/Hw2MQnHaTlIbuCxGHnPMAmedaNWZUdghah0tdhAdBSUjOWTjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kADvfZsCO68G+54YDQmVqoP+aF1U+sSsvLrCmUi/p8c=;
	b=drqxtr7qf7xS1viw2CPfGn2H8odGrMYF2gL6F7PZ4/dyOaSy4WEG7+ivoKDWNSAR8tsjhA
	oUpmN8rb18ODxeAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched: Use hrtimer_highres_enabled()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.203610956@kernel.org>
References: <20260224163429.203610956@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301706.1647592.17478654487746622082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8328-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 490941C422F
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     c3a92213eb3dd8ea6f664d16a08eda800e34eaad
Gitweb:        https://git.kernel.org/tip/c3a92213eb3dd8ea6f664d16a08eda800e3=
4eaad
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:05 +01:00

sched: Use hrtimer_highres_enabled()

Use the static branch based variant and thereby avoid following three
pointers.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.203610956@kernel.org
---
 include/linux/hrtimer.h |  6 ------
 kernel/sched/sched.h    | 37 +++++++++----------------------------
 2 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c9ca105..b500385 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -146,12 +146,6 @@ static inline ktime_t hrtimer_expires_remaining(const st=
ruct hrtimer *timer)
 	return ktime_sub(timer->node.expires, hrtimer_cb_get_time(timer));
 }
=20
-static inline int hrtimer_is_hres_active(struct hrtimer *timer)
-{
-	return IS_ENABLED(CONFIG_HIGH_RES_TIMERS) ?
-		timer->base->cpu_base->hres_active : 0;
-}
-
 #ifdef CONFIG_HIGH_RES_TIMERS
 extern unsigned int hrtimer_resolution;
 struct clock_event_device;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 73bc20c..0aa089d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3019,25 +3019,19 @@ extern unsigned int sysctl_numa_balancing_hot_thresho=
ld;
  *  - enabled by features
  *  - hrtimer is actually high res
  */
-static inline int hrtick_enabled(struct rq *rq)
+static inline bool hrtick_enabled(struct rq *rq)
 {
-	if (!cpu_active(cpu_of(rq)))
-		return 0;
-	return hrtimer_is_hres_active(&rq->hrtick_timer);
+	return cpu_active(cpu_of(rq)) && hrtimer_highres_enabled();
 }
=20
-static inline int hrtick_enabled_fair(struct rq *rq)
+static inline bool hrtick_enabled_fair(struct rq *rq)
 {
-	if (!sched_feat(HRTICK))
-		return 0;
-	return hrtick_enabled(rq);
+	return sched_feat(HRTICK) && hrtick_enabled(rq);
 }
=20
-static inline int hrtick_enabled_dl(struct rq *rq)
+static inline bool hrtick_enabled_dl(struct rq *rq)
 {
-	if (!sched_feat(HRTICK_DL))
-		return 0;
-	return hrtick_enabled(rq);
+	return sched_feat(HRTICK_DL) && hrtick_enabled(rq);
 }
=20
 extern void hrtick_start(struct rq *rq, u64 delay);
@@ -3047,22 +3041,9 @@ static inline bool hrtick_active(struct rq *rq)
 }
=20
 #else /* !CONFIG_SCHED_HRTICK: */
-
-static inline int hrtick_enabled_fair(struct rq *rq)
-{
-	return 0;
-}
-
-static inline int hrtick_enabled_dl(struct rq *rq)
-{
-	return 0;
-}
-
-static inline int hrtick_enabled(struct rq *rq)
-{
-	return 0;
-}
-
+static inline bool hrtick_enabled_fair(struct rq *rq) { return false; }
+static inline bool hrtick_enabled_dl(struct rq *rq) { return false; }
+static inline bool hrtick_enabled(struct rq *rq) { return false; }
 #endif /* !CONFIG_SCHED_HRTICK */
=20
 #ifndef arch_scale_freq_tick


Return-Path: <linux-tip-commits+bounces-8316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIdsEG4Oo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433831C41FC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC1D53069C73
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145348035D;
	Sat, 28 Feb 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XkhNlu4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtzgkwZ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613547DFAA;
	Sat, 28 Feb 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293011; cv=none; b=Vak8caJrUlWPxrrpzCBg/v0J3Qwrw//tj7NAdDHdovP3Dz3VoK5xys2QibpsVW1nzbe8r8VkN9XeZ92Y5EypqX7IYEvvFaugAiIcD478YC1bRlCmaLjQSP+meYfK3jxcaXKeF2wmVWCupWCXPNSL+YrRFV9aPuoKI24ajbMts3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293011; c=relaxed/simple;
	bh=nmWjLLMsT//O6hzeVknngsf384ccPxrF1Yl9e5Yed9o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pvVuB0nzTrmNQVD6ZEOQVoM7oO+J0EKLwwFqJTUPHCNf2mrfVVsRVTlebpuZ6qmWwM4J8WJxEU4YRUFd3/tGsLkGYGiFq6ksAhfxZh91H8qljw92r0QHC76U6RHezPawttdVQGaJMsy+3U1dQlJDMjwSj1ii9YfaoDuOlCi6nH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XkhNlu4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtzgkwZ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0wnY7fmx82cxhujRI8Hyyb3neZgFjgqzhmREOuqR+k=;
	b=3XkhNlu48aX2+BJ8g2I1kanZpY+ntdoIV3CY1HYnZCuWCvIJc1cZdBjVeHY8YwlWayvoQj
	JaIp9KMLz/bTdRoklVQgnO++Iu697PSI4vKFvYRf1XP1aQg1bDl/L+ivXUq+qzqL34DNVo
	HOyZseaH0qp4fakaHjwMLgERe/KzO8KBzbf2GKKLBslpwo0s5RKmE9nziBhs0fshELjOO7
	hlAbD3kbh68KYyleS5d0C0LZPfnm3XOKwZGvrHYkcGHAdSO7Q/tKiLtIvnaacknn8kX6PX
	mWWXPWtzTXzfpK7LEYrdjpRXCpAG1BiDOcBg+bM4qL+d8kSyIccfgp4MxezL5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0wnY7fmx82cxhujRI8Hyyb3neZgFjgqzhmREOuqR+k=;
	b=rtzgkwZ98ziYFjyUVE4W2ZOozCL/60lLccCqwxaYBvwJrCKDyCfnAkBBLl//uXWNaSTTEv
	n4+LHHu95x8cvQAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] clockevents: Provide support for clocksource
 coupled comparators
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.010425428@kernel.org>
References: <20260224163430.010425428@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300396.1647592.13052142813602282295.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8316-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 433831C41FC
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     89f951a1e8ad781e7ac70eccddab0e0c270485f9
Gitweb:        https://git.kernel.org/tip/89f951a1e8ad781e7ac70eccddab0e0c270=
485f9
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:08 +01:00

clockevents: Provide support for clocksource coupled comparators

Some clockevent devices are coupled to the system clocksource by
implementing a less than or equal comparator which compares the programmed
absolute expiry time against the underlying time counter.

The timekeeping core provides a function to convert and absolute
CLOCK_MONOTONIC based expiry time to a absolute clock cycles time which can
be directly fed into the comparator. That spares two time reads in the next
event progamming path, one to convert the absolute nanoseconds time to a
delta value and the other to convert the delta value back to a absolute
time value suitable for the comparator.

Provide a new clocksource callback which takes the absolute cycle value and
wire it up in clockevents_program_event(). Similar to clocksources allow
architectures to inline the rearm operation.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.010425428@kernel.org
---
 include/linux/clockchips.h |  7 ++++--
 kernel/time/Kconfig        |  4 +++-
 kernel/time/clockevents.c  | 44 ++++++++++++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 5e8f781..92d9022 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -43,8 +43,9 @@ enum clock_event_state {
 /*
  * Clock event features
  */
-# define CLOCK_EVT_FEAT_PERIODIC	0x000001
-# define CLOCK_EVT_FEAT_ONESHOT		0x000002
+# define CLOCK_EVT_FEAT_PERIODIC		0x000001
+# define CLOCK_EVT_FEAT_ONESHOT			0x000002
+# define CLOCK_EVT_FEAT_CLOCKSOURCE_COUPLED	0x000004
=20
 /*
  * x86(64) specific (mis)features:
@@ -100,6 +101,7 @@ struct clock_event_device {
 	void			(*event_handler)(struct clock_event_device *);
 	int			(*set_next_event)(unsigned long evt, struct clock_event_device *);
 	int			(*set_next_ktime)(ktime_t expires, struct clock_event_device *);
+	void			(*set_next_coupled)(u64 cycles, struct clock_event_device *);
 	ktime_t			next_event;
 	u64			max_delta_ns;
 	u64			min_delta_ns;
@@ -107,6 +109,7 @@ struct clock_event_device {
 	u32			shift;
 	enum clock_event_state	state_use_accessors;
 	unsigned int		features;
+	enum clocksource_ids	cs_id;
 	unsigned long		retries;
=20
 	int			(*set_state_periodic)(struct clock_event_device *);
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b51bc56..e1968ab 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -50,6 +50,10 @@ config GENERIC_CLOCKEVENTS_MIN_ADJUST
 config GENERIC_CLOCKEVENTS_COUPLED
 	bool
=20
+config GENERIC_CLOCKEVENTS_COUPLED_INLINE
+	select GENERIC_CLOCKEVENTS_COUPLED
+	bool
+
 # Generic update of CMOS clock
 config GENERIC_CMOS_UPDATE
 	bool
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5abaeef..83712aa 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -292,6 +292,38 @@ static int clockevents_program_min_delta(struct clock_ev=
ent_device *dev)
=20
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST */
=20
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_COUPLED
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_COUPLED_INLINE
+#include <asm/clock_inlined.h>
+#else
+static __always_inline void
+arch_inlined_clockevent_set_next_coupled(u64 u64 cycles, struct clock_event_=
device *dev) { }
+#endif
+
+static inline bool clockevent_set_next_coupled(struct clock_event_device *de=
v, ktime_t expires)
+{
+	u64 cycles;
+
+	if (unlikely(!(dev->features & CLOCK_EVT_FEAT_CLOCKSOURCE_COUPLED)))
+		return false;
+
+	if (unlikely(!ktime_expiry_to_cycles(dev->cs_id, expires, &cycles)))
+		return false;
+
+	if (IS_ENABLED(CONFIG_GENERIC_CLOCKEVENTS_COUPLED_INLINE))
+		arch_inlined_clockevent_set_next_coupled(cycles, dev);
+	else
+		dev->set_next_coupled(cycles, dev);
+	return true;
+}
+
+#else
+static inline bool clockevent_set_next_coupled(struct clock_event_device *de=
v, ktime_t expires)
+{
+	return false;
+}
+#endif
+
 /**
  * clockevents_program_event - Reprogram the clock event device.
  * @dev:	device to program
@@ -300,11 +332,10 @@ static int clockevents_program_min_delta(struct clock_e=
vent_device *dev)
  *
  * Returns 0 on success, -ETIME when the event is in the past.
  */
-int clockevents_program_event(struct clock_event_device *dev, ktime_t expire=
s,
-			      bool force)
+int clockevents_program_event(struct clock_event_device *dev, ktime_t expire=
s, bool force)
 {
-	unsigned long long clc;
 	int64_t delta;
+	u64 cycles;
 	int rc;
=20
 	if (WARN_ON_ONCE(expires < 0))
@@ -323,6 +354,9 @@ int clockevents_program_event(struct clock_event_device *=
dev, ktime_t expires,
 	if (unlikely(dev->features & CLOCK_EVT_FEAT_HRTIMER))
 		return dev->set_next_ktime(expires, dev);
=20
+	if (likely(clockevent_set_next_coupled(dev, expires)))
+		return 0;
+
 	delta =3D ktime_to_ns(ktime_sub(expires, ktime_get()));
 	if (delta <=3D 0)
 		return force ? clockevents_program_min_delta(dev) : -ETIME;
@@ -330,8 +364,8 @@ int clockevents_program_event(struct clock_event_device *=
dev, ktime_t expires,
 	delta =3D min(delta, (int64_t) dev->max_delta_ns);
 	delta =3D max(delta, (int64_t) dev->min_delta_ns);
=20
-	clc =3D ((unsigned long long) delta * dev->mult) >> dev->shift;
-	rc =3D dev->set_next_event((unsigned long) clc, dev);
+	cycles =3D ((u64)delta * dev->mult) >> dev->shift;
+	rc =3D dev->set_next_event((unsigned long) cycles, dev);
=20
 	return (rc && force) ? clockevents_program_min_delta(dev) : rc;
 }


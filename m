Return-Path: <linux-tip-commits+bounces-8312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKRbNAQOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:47:16 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EF1C41D6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D007309DB45
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104847F2FB;
	Sat, 28 Feb 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOu2wB+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BB1hT4gN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565847F2C4;
	Sat, 28 Feb 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293007; cv=none; b=SfysMPq0ptIlbn4tyIa/YMuSN1UQklM+j0OERgaCJRs1M1gGWCAMf/O9E6fQGQ4HzfyM/i1wm4A3DeAucczJ0KnIILDi9LVolg9BMHHOiD3SB1kvRHQJA09Ef0ZIx0+1FYXfbwLwuICQ4RNl1jl3RE9dC6PxbRwjaZrR7k8Fg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293007; c=relaxed/simple;
	bh=BpoypbnFrdt1E5AFq5/qoaQBX7UkKHa3xcMcUFP00yU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PTbG85zwzSflhwXXhbbFonibpF/2AQao060xeg8QIcP0bhmbt/+grieCMFrxum/CDdz0ka/tq0cB1AzPmbVNBBES6yMKRV6RkK/rVc/46knRN438LxOEIKo0tjR9Z6b9tKMZwilmfDapBbVNwSFRYKeWtOzZhl/oPswW4tYizjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOu2wB+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BB1hT4gN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF8xM3wvusxSPE/2lKlDoOpJNSIg73ckNdFIrUvmgS8=;
	b=dOu2wB+e/OYypmEdBdVs2rchvo5egPNyyg/zg6cBj5ClalWjff/XfP/7NGwau/mmHsVFsV
	sT/3z63gOC2biW+Xaw6JaztRyvZqoOUXXC1r7HssYpjwTePB0naGIGRBZKM1XvlZxAERVp
	OFhVnyKygARXsHCXyBODQul7BXi/LDbS740RYhh3JujEqNPafPZMNdkhfAsisxKduabQ/f
	mFM43bVYNxHcLF77NsItVV+E4qkXNHd402RBwwrJRSnsphHFxlF3LwQRWCmXHeQLfjmCYC
	t7f1A+Y5ouct5YeEnlG3rMlgMHl4YzBhm7Tr36tokfQ7Tk6wBiiKLXrF0Khcjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF8xM3wvusxSPE/2lKlDoOpJNSIg73ckNdFIrUvmgS8=;
	b=BB1hT4gND/ig6NL/4wtHM4uUhau3+fp7BNHa2dwrS5adi0Obp8imXWAvi8bDOfNXlLS5Pt
	p7kHuPHjkeuwhuDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Add debug object init assertion
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.143098153@kernel.org>
References: <20260224163430.143098153@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300190.1647592.12957074566521425878.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8312-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto];
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
X-Rspamd-Queue-Id: F07EF1C41D6
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     513e744a0a4a70ebdb155611b897e9ed4d83831c
Gitweb:        https://git.kernel.org/tip/513e744a0a4a70ebdb155611b897e9ed4d8=
3831c
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:09 +01:00

hrtimer: Add debug object init assertion

The debug object coverage in hrtimer_start_range_ns() happens too late to
do anything useful. Implement the init assert assertion part and invoke
that early in hrtimer_start_range_ns().

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.143098153@kernel.org
---
 kernel/time/hrtimer.c | 43 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e54f8b5..fa63e0b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -441,12 +441,37 @@ static bool hrtimer_fixup_free(void *addr, enum debug_o=
bj_state state)
 	}
 }
=20
+/* Stub timer callback for improperly used timers. */
+static enum hrtimer_restart stub_timer(struct hrtimer *unused)
+{
+	WARN_ON_ONCE(1);
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * hrtimer_fixup_assert_init is called when:
+ * - an untracked/uninit-ed object is found
+ */
+static bool hrtimer_fixup_assert_init(void *addr, enum debug_obj_state state)
+{
+	struct hrtimer *timer =3D addr;
+
+	switch (state) {
+	case ODEBUG_STATE_NOTAVAILABLE:
+		hrtimer_setup(timer, stub_timer, CLOCK_MONOTONIC, 0);
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct debug_obj_descr hrtimer_debug_descr =3D {
-	.name		=3D "hrtimer",
-	.debug_hint	=3D hrtimer_debug_hint,
-	.fixup_init	=3D hrtimer_fixup_init,
-	.fixup_activate	=3D hrtimer_fixup_activate,
-	.fixup_free	=3D hrtimer_fixup_free,
+	.name			=3D "hrtimer",
+	.debug_hint		=3D hrtimer_debug_hint,
+	.fixup_init		=3D hrtimer_fixup_init,
+	.fixup_activate		=3D hrtimer_fixup_activate,
+	.fixup_free		=3D hrtimer_fixup_free,
+	.fixup_assert_init	=3D hrtimer_fixup_assert_init,
 };
=20
 static inline void debug_hrtimer_init(struct hrtimer *timer)
@@ -470,6 +495,11 @@ static inline void debug_hrtimer_deactivate(struct hrtim=
er *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
=20
+static inline void debug_hrtimer_assert_init(struct hrtimer *timer)
+{
+	debug_object_assert_init(timer, &hrtimer_debug_descr);
+}
+
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -483,6 +513,7 @@ static inline void debug_hrtimer_init_on_stack(struct hrt=
imer *timer) { }
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
+static inline void debug_hrtimer_assert_init(struct hrtimer *timer) { }
 #endif
=20
 static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enu=
m hrtimer_mode mode)
@@ -1359,6 +1390,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktim=
e_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
=20
+	debug_hrtimer_assert_init(timer);
+
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT =3D n. With PREEMPT_RT check the hard


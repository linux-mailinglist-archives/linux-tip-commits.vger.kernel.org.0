Return-Path: <linux-tip-commits+bounces-8301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ld1Ad4Mo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949141C40E6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB8C310558A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78AA47DD73;
	Sat, 28 Feb 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vP60oqsW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ety9+bS/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FA47DD63;
	Sat, 28 Feb 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292991; cv=none; b=PR2vPheOaxh/70R/PSoVzrD+ruIgTG9n2BGJbbcdp88SUsMHaYl8z7THKP75mMwQmYzf/JhzGX5Qg6ucdcjvK73KAsKIe+ps1QfNUhw99eMgETbjphRow5fGzsAV3JP0Ri88ATI741PCTClqSOo8kV5zInl4rRCPGP2HI14wjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292991; c=relaxed/simple;
	bh=YY2BTI+mSwCPmxiB6r/FXrJB/PMVPPMfkVf7b8dNrw8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o+9Xz8Wk22D0vpjNLFE4B7uBQebt4lMfzsAflo416BKl8lRu3pBo3wyTydu/NnnIrKaNe+skjqQvFYxOdEAkdXTaECa9VvIfOHhDKF5wgKEIS9bGW7LMq3zKRG6Xmmi0D+yiOhSzjFxptkOcaS2J6TaxokE4DPf5WWxi5Ygvjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vP60oqsW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ety9+bS/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0gPmqs2LbsmP0Ji+9jvvUGr/1NHgwF8s18NBJbCFFc=;
	b=vP60oqsWKVLWT75lEckLIZJKuk6wWIOtLaLIX3Q/fLQTE2ZIPCCIDq+EWEE+lo3D/56hO1
	YloNpH5DONmdwOXfdt5ZvIZG+PvbaP4flQuecjKIXruMHD5lLwhzQVWCxdVxKceRmwuW2y
	RyhBYGECENh2dkkXwJIYTZBjuZpHuyg8uWmjjSOF5KmzfQE4Wv9N+pFYgxWn4TC/WWdvWT
	OQtcgks7XJkDRr5P/evGVmSE2rtrkXdatMDvOLWrPKI0B82WaPsYIZa9Gk/npKQAwH7n+b
	m/4ZeryhPK1L8pea/D2eZaLsxHlMoThiuDxFHnsG/pEVmSXMkVfl+HpkY8cHTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0gPmqs2LbsmP0Ji+9jvvUGr/1NHgwF8s18NBJbCFFc=;
	b=Ety9+bS/CwQcr8lAP4GBoi7iDLXrKxOZQNNYodc6r+SR/hyLBD5rBUxXSJUn91rnTENU4J
	LPvZ8B2L2h8F4nAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Prepare stubs for deferred rearming
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.000891171@kernel.org>
References: <20260224163431.000891171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298739.1647592.5687684061084490215.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8301-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 949141C40E6
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     a43b4856bc039675165a50d9ef5f41b28520f0f4
Gitweb:        https://git.kernel.org/tip/a43b4856bc039675165a50d9ef5f41b2852=
0f0f4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:13 +01:00

hrtimer: Prepare stubs for deferred rearming

The hrtimer interrupt expires timers and at the end of the interrupt it
rearms the clockevent device for the next expiring timer.

That's obviously correct, but in the case that a expired timer set
NEED_RESCHED the return from interrupt ends up in schedule(). If HRTICK is
enabled then schedule() will modify the hrtick timer, which causes another
reprogramming of the hardware.

That can be avoided by deferring the rearming to the return from interrupt
path and if the return results in a immediate schedule() invocation then it
can be deferred until the end of schedule().

To make this correct the affected code parts need to be made aware of this.

Provide empty stubs for the deferred rearming mechanism, so that the
relevant code changes for entry, softirq and scheduler can be split up into
separate changes independent of the actual enablement in the hrtimer code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.000891171@kernel.org
---
 include/linux/hrtimer.h       |  1 +
 include/linux/hrtimer_rearm.h | 21 +++++++++++++++++++++
 kernel/time/Kconfig           |  4 ++++
 3 files changed, 26 insertions(+)
 create mode 100644 include/linux/hrtimer_rearm.h

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4ad4a45..c087b71 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -13,6 +13,7 @@
 #define _LINUX_HRTIMER_H
=20
 #include <linux/hrtimer_defs.h>
+#include <linux/hrtimer_rearm.h>
 #include <linux/hrtimer_types.h>
 #include <linux/init.h>
 #include <linux/list.h>
diff --git a/include/linux/hrtimer_rearm.h b/include/linux/hrtimer_rearm.h
new file mode 100644
index 0000000..6293076
--- /dev/null
+++ b/include/linux/hrtimer_rearm.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_HRTIMER_REARM_H
+#define _LINUX_HRTIMER_REARM_H
+
+#ifdef CONFIG_HRTIMER_REARM_DEFERRED
+static __always_inline void __hrtimer_rearm_deferred(void) { }
+static __always_inline void hrtimer_rearm_deferred(void) { }
+static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_wor=
k) { }
+static __always_inline bool
+hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long=
 tif_mask) { return false; }
+static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void) { re=
turn false; }
+#else  /* CONFIG_HRTIMER_REARM_DEFERRED */
+static __always_inline void __hrtimer_rearm_deferred(void) { }
+static __always_inline void hrtimer_rearm_deferred(void) { }
+static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_wor=
k) { }
+static __always_inline bool
+hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long=
 tif_mask) { return false; }
+static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void) { re=
turn false; }
+#endif  /* !CONFIG_HRTIMER_REARM_DEFERRED */
+
+#endif
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index e1968ab..b95bfee 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -58,6 +58,10 @@ config GENERIC_CLOCKEVENTS_COUPLED_INLINE
 config GENERIC_CMOS_UPDATE
 	bool
=20
+# Deferred rearming of the hrtimer interrupt
+config HRTIMER_REARM_DEFERRED
+       def_bool n
+
 # Select to handle posix CPU timers from task_work
 # and not from the timer interrupt context
 config HAVE_POSIX_CPU_TIMERS_TASK_WORK


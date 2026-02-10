Return-Path: <linux-tip-commits+bounces-8213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHmbG0Yui2lEQgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 14:10:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B611B1DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9E4F3009F1D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1462320CAA;
	Tue, 10 Feb 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XE2JKBTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbn9KOe6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3D15624B;
	Tue, 10 Feb 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729024; cv=none; b=ClY3BEpxMurq7nwz9KLQfnv7YarI5DavIgdT12LEIFrMGswkwqwyigbHVa6ILz4JVsxHu/vrWiVaqFPWBIOqzQRjKlpSyD06V8qeVW6Tnpnhc9Oti0rbT4cpwKLrMEznhtdPLvtY1DiKl8l++99BrVKr5MQ2gwDN/mGbYiNPq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729024; c=relaxed/simple;
	bh=KP8uwg2KuTZi9wNTtr6og0k4m90DlZYSHsQ4aYi/2uM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jD9fvlLpVGnyLOKz6ehMFRrHz5cCzJTt+er/l9VZp01iYjfnSHi52i/KfzpoXmFTHkFnZQOlvJWQhdObVQ/y3ay1heSLdqQROSYhLNzR+L+H+UibPxC/tKsPmlNsnzT57X+PwXp4O+U1N9NCnUtM9R7CbGnXepo4oip7QI6Wby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XE2JKBTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbn9KOe6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Feb 2026 13:10:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770729022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV+8p8rmxdJvSXekQupKUMhyYJpcyIolJyD6CCl1Gyo=;
	b=XE2JKBTcVv93V20hplmm0RiAmPNqRoBh+QQbeEFwcE9y60l6uwvfWq7PVVt3feT8cls7ys
	j4vVGMBLZXBHpPGu7/mRYt7up3mmM/I51ZnGAOOaMADZ7UuUbdVyO4d1kiUFRGe7nFmPO6
	iIVyQpCmgysHxBUFBWvKcRpDK7WqtDfV/SQLhy0pReScUDSC5kHUgAzF43jOh0ZTlDFhl7
	pftQJFqnVRRbGQNCjWaaF8MBDleotSkjt8PKuyPbZHm1McyzfffSvBrqxJufdvl7Pdq4xh
	LU6arC82j5ZTn3xy8fp9wGafiyCtKUkiTKEKOtG70iVGBeVHBS48Dvk38kRGiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770729022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV+8p8rmxdJvSXekQupKUMhyYJpcyIolJyD6CCl1Gyo=;
	b=jbn9KOe6nDScYXnpspffuEU868dOXHBKnzIsO4pQyAne7ZApub4QWhlymkgUuIhJiNQ5kk
	gMsgMsl2TcebFYBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobject: Make it work with deferred page
 initialization - again
Cc: Thomas Gleixner <tglx@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87pl6gznti.ffs@tglx>
References: <87pl6gznti.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177072902062.542.10454591270525273120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8213-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 5F7B611B1DB
X-Rspamd-Action: no action

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     fd3634312a04f336dcbfb481060219f0cd320738
Gitweb:        https://git.kernel.org/tip/fd3634312a04f336dcbfb481060219f0cd3=
20738
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sat, 07 Feb 2026 14:27:05 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 10 Feb 2026 13:26:19 +01:00

debugobject: Make it work with deferred page initialization - again

debugobjects uses __GFP_HIGH for allocations as it might be invoked
within locked regions. That worked perfectly fine until v6.18. It still
works correctly when deferred page initialization is disabled and works
by chance when no page allocation is required before deferred page
initialization has completed.

Since v6.18 allocations w/o a reclaim flag cause new_slab() to end up in
alloc_frozen_pages_nolock_noprof(), which returns early when deferred
page initialization has not yet completed. As the deferred page
initialization takes quite a while the debugobject pool is depleted and
debugobjects are disabled.

This can be worked around when PREEMPT_COUNT is enabled as that allows
debugobjects to add __GFP_KSWAPD_RECLAIM to the GFP flags when the context
is preemtible. When PREEMPT_COUNT is disabled the context is unknown and
the reclaim bit can't be set because the caller might hold locks which
might deadlock in the allocator.

In preemptible context the reclaim bit is harmless and not a performance
issue as that's usually invoked from slow path initialization context.

That makes debugobjects depend on PREEMPT_COUNT || !DEFERRED_STRUCT_PAGE_INIT.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://patch.msgid.link/87pl6gznti.ffs@tglx
---
 lib/Kconfig.debug  |  1 +
 lib/debugobjects.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939..a874146 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -723,6 +723,7 @@ source "mm/Kconfig.debug"
=20
 config DEBUG_OBJECTS
 	bool "Debug object operations"
+	depends on PREEMPT_COUNT || !DEFERRED_STRUCT_PAGE_INIT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, additional code will be inserted into the
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 89a1d67..12f50de 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -398,9 +398,26 @@ static void fill_pool(void)
=20
 	atomic_inc(&cpus_allocating);
 	while (pool_should_refill(&pool_global)) {
+		gfp_t gfp =3D __GFP_HIGH | __GFP_NOWARN;
 		HLIST_HEAD(head);
=20
-		if (!kmem_alloc_batch(&head, obj_cache, __GFP_HIGH | __GFP_NOWARN))
+		/*
+		 * Allow reclaim only in preemptible context and during
+		 * early boot. If not preemptible, the caller might hold
+		 * locks causing a deadlock in the allocator.
+		 *
+		 * If the reclaim flag is not set during early boot then
+		 * allocations, which happen before deferred page
+		 * initialization has completed, will fail.
+		 *
+		 * In preemptible context the flag is harmless and not a
+		 * performance issue as that's usually invoked from slow
+		 * path initialization context.
+		 */
+		if (preemptible() || system_state < SYSTEM_SCHEDULING)
+			gfp |=3D __GFP_KSWAPD_RECLAIM;
+
+		if (!kmem_alloc_batch(&head, obj_cache, gfp))
 			break;
=20
 		guard(raw_spinlock_irqsave)(&pool_lock);


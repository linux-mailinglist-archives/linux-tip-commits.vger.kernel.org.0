Return-Path: <linux-tip-commits+bounces-8212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LO5DdMNi2lXPQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 11:52:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F3119D7F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0088B302DB46
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Feb 2026 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544E3090FF;
	Tue, 10 Feb 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0aZL2siA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="algiY7Lo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7C34C818;
	Tue, 10 Feb 2026 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720720; cv=none; b=brSilLlxfK1/q0695hOqxaxwOeCcpbtiYdBz/76ZNWvqJZNFwfgGhDvaTjambt5jIxNrRGnYt3QA2s2ZlL5AGU2oF64kqKDWoDNiHLP6pijHd66tzKiZtJSl9S65q7zatLAbZFkMZtfQfOkU42rw9tSZiPZC9C8LAWAT851V48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720720; c=relaxed/simple;
	bh=SmrEHFaIjHqrB3sHvej+pnJ+ZxFfTdM/D+iXBMhyTUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RKMace9cbQUqyeAiPVuCrwP8nT3btpgPyrQipccuQ4v5+efLFbE9g4jmIdApxIzGR+LNDdNV2aaBueLCi4JCsqp2j4hrIuhGlJDvpcUOywk5CxUrD1Pyk4uKP4Zuwe9/aMY6NifGFvkmLDhb+w6JIFbzgl+u/ASSDyYMmSZUAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0aZL2siA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=algiY7Lo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Feb 2026 10:51:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770720708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQcc1apRMly/QJaPof08vXELH69pfkqg8keYXajlxjo=;
	b=0aZL2siAPIFJIVIByD4t8HXKgEzRPEE5MCshg1IcUIRDATk7K1I0EAP6R3DapRPdnvns4q
	2WNmV4q4YJKlqMV1YrX9gl7cP/MuhphClAp+gzPuhkeD2rV+D48/FRic/vryTo4GuY0WQH
	p/OUIP4mn0QER2Ni7eDncOv0vGdowKNW+Mhw2IHK2PFFLLr5y60tF9Y2hbHwNPknOyoXtX
	2FFZw9fP6eR0RFECQfsEnV+ljORFjw4gP3OkbtVQd9PzyKHIKU+doMUQHkT7ENXT7jGYcS
	vOTtJ26LBvkkz8sGiOHleK/uW2XDGuCPz1oGkDT4uOUiNTpIyC3WhYeW2u66IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770720708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQcc1apRMly/QJaPof08vXELH69pfkqg8keYXajlxjo=;
	b=algiY7Lo31tRKM7OsqdCR3AWI7e0ALR8mkT0ii29NzdV6gfdJavQsDLyHQc4Md4/VIIkkb
	7qXG9VR4bzhB13DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobject: Make it work with deferred page
 initialization - again
Cc: Thomas Gleixner <tglx@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
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
Message-ID: <177072070352.542.12916536901134546139.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-8212-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 642F3119D7F
X-Rspamd-Action: no action

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     998d5a6164d9fb33224f24b3e36dac0a8b0496e5
Gitweb:        https://git.kernel.org/tip/998d5a6164d9fb33224f24b3e36dac0a8b0=
496e5
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sat, 07 Feb 2026 14:27:05 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 10 Feb 2026 11:47:35 +01:00

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


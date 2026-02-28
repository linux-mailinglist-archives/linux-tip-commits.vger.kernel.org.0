Return-Path: <linux-tip-commits+bounces-8319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI39OMYOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA51C4256
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C316530B21A8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F321480976;
	Sat, 28 Feb 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHWmI586";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60ezy2XW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9C480340;
	Sat, 28 Feb 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293015; cv=none; b=lF0oue/T2RrwUkK8Fd0rU7Nx6VFkjuVUeZ1FHk6O9MFUkXeFMltWdjWnMldBG3FNyboR2lG22p82HmEmhlqSY12Jdlx+MVG6KWWnWSta4t92gKMR7zqCF6tPBFA+dJse/QWv+MvbxtoXoAUSv01inFfYklAQ/pFcD7Xok4muPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293015; c=relaxed/simple;
	bh=3Bcc34TP487mHbfG8vzPgj6poK++nPp2EAVTC3+PgIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nx5j/5AslEuR9lYT0z5mlCsSj5aN5hCGFcgJmT9V3ufXWYId8sEWWAzSKyleo0j+BoFFAu479WlHn6lNGSf43uQNcqA+0cWZ8GfXl466Is5h/yHVn6QSiHcfNouh/aORfF91fD3HtBfcEAOUz2oLqcK3Msns1aSY9UQKt5ft77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHWmI586; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60ezy2XW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/WcW7kgH4mUkRHILTuDqhjUy1PKftmsrSzQ/UH5o2s=;
	b=GHWmI586CYUDI7y10xeI2Rdxw+zXv/j1PyngiKNb2hECPsYTglMxbMVmi7+HIvPKR0DiBN
	ofIsfwtfgtSFpy/dHPsmYMtiDM8K3iArpEBx9Iti9xXPxhBygjCF+DZ6vcKsoCDeLjA248
	WPqg7wAZrArh7EpXy5LKBdHhNJBXIymje1V1QGmYNvcm5cr0QHw2F/Nua9gLVLc+eFlDw9
	NQFAUGh0gwEv5G5vuQ1tb/W2JEDF0sRzAjIZDGrDXrJUjycPJlnSrxe7YmPmwhaDrVLg4Z
	/pcP+YUUiAEJNLlm7pYymMujKI/SFT1Ti1wNOckAnKQx1bJ1RAtbkk3p+4bb+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/WcW7kgH4mUkRHILTuDqhjUy1PKftmsrSzQ/UH5o2s=;
	b=60ezy2XWRKYk02eyjcNuEK8kWo61yS7F03IOW7lQQhzA/L6V56zLTy6FHzTnqfHhIdnacU
	GLpWIul9xiBMtbAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/hrtick] x86/apic: Remove pointless fence in lapic_next_deadline()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.809059527@kernel.org>
References: <20260224163429.809059527@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300755.1647592.4809561562793394467.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8319-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 1CDA51C4256
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     92d0e753d57ec581a424d9903afff5e17bd1e6e4
Gitweb:        https://git.kernel.org/tip/92d0e753d57ec581a424d9903afff5e17bd=
1e6e4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:07 +01:00

x86/apic: Remove pointless fence in lapic_next_deadline()

lapic_next_deadline() contains a fence before the TSC read and the write to
the TSC_DEADLINE MSR with a content free and therefore useless comment:

    /* This MSR is special and need a special fence: */

The MSR is not really special. It is just not a serializing MSR, but that
does not matter at all in this context as all of these operations are
strictly CPU local.

The only thing the fence prevents is that the RDTSC is speculated ahead,
but that's not really relevant as the delta is calculated way before based
on a previous TSC read and therefore inaccurate by definition.

So removing the fence is just making it slightly more inaccurate in the
worst case, but that is irrelevant as it's way below the actual system
immanent latencies and variations.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.809059527@kernel.org
---
 arch/x86/kernel/apic/apic.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d93f87f..18208be 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -412,22 +412,20 @@ EXPORT_SYMBOL_GPL(setup_APIC_eilvt);
 /*
  * Program the next event, relative to now
  */
-static int lapic_next_event(unsigned long delta,
-			    struct clock_event_device *evt)
+static int lapic_next_event(unsigned long delta, struct clock_event_device *=
evt)
 {
 	apic_write(APIC_TMICT, delta);
 	return 0;
 }
=20
-static int lapic_next_deadline(unsigned long delta,
-			       struct clock_event_device *evt)
+static int lapic_next_deadline(unsigned long delta, struct clock_event_devic=
e *evt)
 {
-	u64 tsc;
-
-	/* This MSR is special and need a special fence: */
-	weak_wrmsr_fence();
+	/*
+	 * There is no weak_wrmsr_fence() required here as all of this is purely
+	 * CPU local. Avoid the [ml]fence overhead.
+	 */
+	u64 tsc =3D rdtsc();
=20
-	tsc =3D rdtsc();
 	wrmsrq(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
 	return 0;
 }


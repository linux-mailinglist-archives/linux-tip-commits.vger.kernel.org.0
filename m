Return-Path: <linux-tip-commits+bounces-7423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A4FC73B1B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A3E04E7AAC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA88335070;
	Thu, 20 Nov 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JxZiykSB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3KtLJcQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18E3346BB;
	Thu, 20 Nov 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637612; cv=none; b=griI2eU/HBLDZir3DWiZBASuuv62Q44986UkpLNfU+22jijqyoH3gxRrVEYWfQWaV8nuqGrF8WvLoOzUQlcMV9RFcTNqsAdcQZpnYsgPn3bdlChLTkRf2hAEzD3uUlBsoRzooqiQih3azZrSvdW09BO0Bs/KgA25izkKK8grqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637612; c=relaxed/simple;
	bh=8E6pSXWAeX6AKyajeAB3g3oAiZxCxiQeH+37eD2/jnk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nefxseismCt/v27YGDHZWRfuxfb2+Bmi1EuQZoSz1c295z2Yefm3UdbfecfXHA5qTLg0R76A33qvoI/5+QlEDMpOt0PV3qPFGkbjf7oIwV0FGvcROmqkUxi7RApL2P7OEJ/fCjyqIBJ3zEs0Hfg8b07B+nbTil0wZQYAP9XgIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JxZiykSB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3KtLJcQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jab8zsqm/V8zIgIyyaDmU0wgzW0tAZ5bzi/XQ7iOUmM=;
	b=JxZiykSBi/cQzIaYabxigGffRkTEicJavrq6yUL+5Ch2HNFN6XkFhOrUPLCXmvbf7eULkh
	/f8D9wK5ZDLwWl7R4FZC+d7n4s+lpuTi0kacytzlSkCcGfJZdoLhq2IA7r4s7gJ6Kg0KjU
	26TUQGjnXkmzm6i3rJjAtiQ3rBkfWe00kBXN6vrWx5yfMljUitl0Z26+jp1yydYhabia4z
	75Rgc9wDXfNvNBqg3rPsTHtexQ12HU5GExO8oXw4H4X+r99ntSNHlojK4pTczUYYPzq/Ps
	jC6L3zhQZaaNKWFX1a4xwbrd52vjjZ+HZjy5esM3vvTo+EZOigjX8laKrZ0h4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jab8zsqm/V8zIgIyyaDmU0wgzW0tAZ5bzi/XQ7iOUmM=;
	b=z3KtLJcQGwm72qNGvxiEONqmTNaHekfK2RDDoBsJk0qmdcac2SiASm34eEdqMwQDHjLbO9
	1OvDHMTxKR5+JTCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched: Fixup whitespace damage
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.258651925@linutronix.de>
References: <20251119172549.258651925@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760521.498.14689367243514895204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     925b7847bb7d4eb523a7698b309e8441647796f2
Gitweb:        https://git.kernel.org/tip/925b7847bb7d4eb523a7698b309e8441647=
796f2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:53 +01:00

sched: Fixup whitespace damage

With whitespace checks enabled in the editor this makes eyes bleed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.258651925@linutronix.de
---
 kernel/sched/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b1aa7d1..b667171 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5278,15 +5278,15 @@ context_switch(struct rq *rq, struct task_struct *pre=
v,
 	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
 	 *   user ->   user   switch
 	 */
-	if (!next->mm) {                                // to kernel
+	if (!next->mm) {				// to kernel
 		enter_lazy_tlb(prev->active_mm, next);
=20
 		next->active_mm =3D prev->active_mm;
-		if (prev->mm)                           // from user
+		if (prev->mm)				// from user
 			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm =3D NULL;
-	} else {                                        // to user
+	} else {					// to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
@@ -5299,7 +5299,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 		lru_gen_use_mm(next->mm);
=20
-		if (!prev->mm) {                        // from kernel
+		if (!prev->mm) {			// from kernel
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm =3D prev->active_mm;
 			prev->active_mm =3D NULL;


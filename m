Return-Path: <linux-tip-commits+bounces-7756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD0CC9331
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 19:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC6732B7976
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9D357A31;
	Wed, 17 Dec 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAUNG/0x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjTOekHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E103557E5;
	Wed, 17 Dec 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993715; cv=none; b=RHL3+7NmCHezHiDrNVXw4ZSc2ZAuP3AWIfQ7QGWlogknsRcOAMaEDcgb+pfnkn5GcNrpO7qquS8wF6thbAfVWKzxGXg/byNXsziwc5qCVwfzaXRPQaSsOSodznc3ElBTeW4CiHBSI6LCCDLSvHh2tMCVXxlWbFCt8w3jpmPoCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993715; c=relaxed/simple;
	bh=V6T8A+h59XaJvzFB/ipnriWZIcslBV20rAtK/vNg3Fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qgiNn7CtgBjBerXW5m3IQvtF63kcJO+74Xa9Q1BpvXczOdVrTgfDvYMNjpSofAeqKqasgzrmwN2LHjt+n3Li9TmtvBDrKXlSBjwG8/ptvkSxI0AVquVm8JvNC16D3l7qPaC1GsafJ3DXylh2b0SE5p3DvYBEIjYxF6cmYTFqriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAUNG/0x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjTOekHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 17:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765993712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26x4O52CL5dhCTo7Ls55DxMhI2zlXHiIdII9FwxrlzQ=;
	b=mAUNG/0xOGK77OG38pwByyNC+Wkp9HufL/CeHI3nzuts2HrnVzq6dTsN+Mt/YqZtafS5R+
	BCTxezatN9UYShQK/HkxracZK0fsrdVJa8lR2iS9ocIL4WEOe+ZzSXWJAlvoOh/Q8BmSUC
	ro2UlL2ZWxZdlyspChUrQJxXNx6OgAlGnMhnEGF6UeOek+OLJY0Kv3bIUT8MPVffhtTniv
	+ZE5bnhxJOkXr4KuDwpUzDqgKaPEMHazCWbUj/FdpAp4s1rjYocP+ts1CpF9fTcuWqe1b5
	S4WkOOA58iQY+1MmOb328vLRxfsid8UmHNBiemGq4wgdbLM7kmZIQwrhLXC7kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765993712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26x4O52CL5dhCTo7Ls55DxMhI2zlXHiIdII9FwxrlzQ=;
	b=PjTOekHL6LhJXEmsHcMP/Lz2U66G9lzE5cxG75s1WrR9yKBQkB1VMTdKGiDTpZOza4nmqK
	OJLIvSJTEQpSF1BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Cleanup posted MSI code
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251125214631.108458942@linutronix.de>
References: <20251125214631.108458942@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176599371103.510.4280287185202960147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     329e2051476858f264e2c217c6db4e68e203d5db
Gitweb:        https://git.kernel.org/tip/329e2051476858f264e2c217c6db4e68e20=
3d5db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Nov 2025 22:50:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Dec 2025 18:44:16 +01:00

x86/irq: Cleanup posted MSI code

Make code and comments readable and use __this_cpu..() as this is
guaranteed to be invoked with interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251125214631.108458942@linutronix.de
---
 arch/x86/kernel/irq.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index b2fe618..7bc640d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -401,11 +401,9 @@ static DEFINE_PER_CPU_CACHE_HOT(bool, posted_msi_handler=
_active);
=20
 void intel_posted_msi_init(void)
 {
-	u32 destination;
-	u32 apic_id;
+	u32 destination, apic_id;
=20
 	this_cpu_write(posted_msi_pi_desc.nv, POSTED_MSI_NOTIFICATION_VECTOR);
-
 	/*
 	 * APIC destination ID is stored in bit 8:15 while in XAPIC mode.
 	 * VT-d spec. CH 9.11
@@ -449,8 +447,8 @@ static __always_inline bool handle_pending_pir(unsigned l=
ong *pir, struct pt_reg
 }
=20
 /*
- * Performance data shows that 3 is good enough to harvest 90+% of the benef=
it
- * on high IRQ rate workload.
+ * Performance data shows that 3 is good enough to harvest 90+% of the
+ * benefit on high interrupt rate workloads.
  */
 #define MAX_POSTED_MSI_COALESCING_LOOP 3
=20
@@ -460,11 +458,8 @@ static __always_inline bool handle_pending_pir(unsigned =
long *pir, struct pt_reg
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 {
+	struct pi_desc *pid =3D __this_cpu_ptr(&posted_msi_pi_desc);
 	struct pt_regs *old_regs =3D set_irq_regs(regs);
-	struct pi_desc *pid;
-	int i =3D 0;
-
-	pid =3D this_cpu_ptr(&posted_msi_pi_desc);
=20
 	/* Mark the handler active for intel_ack_posted_msi_irq() */
 	__this_cpu_write(posted_msi_handler_active, true);
@@ -472,25 +467,25 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 	irq_enter();
=20
 	/*
-	 * Max coalescing count includes the extra round of handle_pending_pir
-	 * after clearing the outstanding notification bit. Hence, at most
-	 * MAX_POSTED_MSI_COALESCING_LOOP - 1 loops are executed here.
+	 * Loop only MAX_POSTED_MSI_COALESCING_LOOP - 1 times here to take
+	 * the final handle_pending_pir() invocation after clearing the
+	 * outstanding notification bit into account.
 	 */
-	while (++i < MAX_POSTED_MSI_COALESCING_LOOP) {
+	for (int i =3D 1; i < MAX_POSTED_MSI_COALESCING_LOOP; i++) {
 		if (!handle_pending_pir(pid->pir, regs))
 			break;
 	}
=20
 	/*
-	 * Clear outstanding notification bit to allow new IRQ notifications,
-	 * do this last to maximize the window of interrupt coalescing.
+	 * Clear the outstanding notification bit to rearm the notification
+	 * mechanism.
 	 */
 	pi_clear_on(pid);
=20
 	/*
-	 * There could be a race of PI notification and the clearing of ON bit,
-	 * process PIR bits one last time such that handling the new interrupts
-	 * are not delayed until the next IRQ.
+	 * Clearing the ON bit can race with a notification. Process the
+	 * PIR bits one last time so that handling the new interrupts is
+	 * not delayed until the next notification happens.
 	 */
 	handle_pending_pir(pid->pir, regs);
=20


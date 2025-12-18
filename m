Return-Path: <linux-tip-commits+bounces-7767-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D6CCDBFF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F9CE302ACCE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A12D94A1;
	Thu, 18 Dec 2025 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0+pI6+b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nv63IsDO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CB27B34E;
	Thu, 18 Dec 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095418; cv=none; b=WswwZiIY83TXYq0fcsCMFTsLnrr1Fh9VrxV65ejdYhv2R8aaYgPQQ/OV2/epItInchNfUECZAMNO8tuP/40HbgfRCeqHTpo5ixsSBOqSyd69ib0BIYhbOku+5LugKZDjtkzV0FRZFvWRxaEHf1rrfaAsC94h1w7WLlZCv6ifmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095418; c=relaxed/simple;
	bh=gENyyz2QcJ0XuT7kJLAAOdnozblOKgWa6ErM/9rY/VI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q2Q2mMXQz8zO7RtElDHzFZoufwpvhEG8KQfKAlUPWfRyM+ZrTIWzlMjRi6nSiuoMgIp1orlTRKB/Sy/qrXkBWpUZalz7DN4ab4cLdoDKL7gk+e8u1ett2x0Bp7kQsXK2bTCzcr6Fu9ud5OUcSowVHSfHxfijf9bJZus14O90y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0+pI6+b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nv63IsDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 22:03:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766095415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YVC036pG5YL9PblYwkF2+aJWByL9c+wJVwofdptRWM=;
	b=J0+pI6+bKZMbQzkSsx351D2bqyVOfWjGlnJVNSGQDaapmPkFuhRzJ33CLI8rC4w2V+NJgD
	Qp9Tph20ew0VWqvZ+wFZ4ha6SLAEfJrk1vFU//ebLQ5jcLS4+PCs2p06NAmbUpQNM6G6gM
	6N4+4M2BWQHzpnn8r+T3Fb+3W18sLV7fI7f907jb1jmbcTsFEJca3PCVeNUMX/jHgdTLYx
	yiksg6NiV6NC9eiBwGWqx6h2TbTNvCGQycsmNmPwbZu1YTYtf6RjIiMCT7bR5iUR9T3kjE
	10TODyq0xcxrtwmYnZPE11oBhJVqTPqZonZNDPKg8HhUUOYbySOGFfiJgUqC4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766095415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YVC036pG5YL9PblYwkF2+aJWByL9c+wJVwofdptRWM=;
	b=Nv63IsDOEKrAmaPCn6fOft6m6INAAB39s9XEFLFAcRFGBa6RzmV3f2u7ARP9U/rg4kn3gq
	1m7F48L/JBo2KhCg==
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
Message-ID: <176609541421.510.43008113684219474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     4021a6dad720273a95ac3c0816fc48e35e77dace
Gitweb:        https://git.kernel.org/tip/4021a6dad720273a95ac3c0816fc48e35e7=
7dace
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Nov 2025 22:50:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Dec 2025 22:59:40 +01:00

x86/irq: Cleanup posted MSI code

Make code and comments readable and use __this_cpu..() as this is
guaranteed to be invoked with interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251125214631.108458942@linutronix.de
---
 arch/x86/kernel/irq.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index b2fe618..d817feb 100644
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
+	struct pi_desc *pid =3D this_cpu_ptr(&posted_msi_pi_desc);
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


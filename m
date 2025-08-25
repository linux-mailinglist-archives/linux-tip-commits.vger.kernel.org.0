Return-Path: <linux-tip-commits+bounces-6337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB5B33A9D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B85274E2F64
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA959230BFD;
	Mon, 25 Aug 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRcRAPC6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN3a27CP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFA153BED;
	Mon, 25 Aug 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113656; cv=none; b=PNdMKPch6hqB0/v0ja+pudZSX9PZQX+YWcxGeAxh0poGvie0g7oK3f9T1qFcGIH+xY849BXwW0CfcyWUqaRo7ZojQsLiLKo8D4yXZjJ6GBO+qQchbEMxOEVgLWmgmzoHcDzMLk1zv+23vxIBvXQEj6hV84XDIphdHBRZaamDsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113656; c=relaxed/simple;
	bh=/UnZzcEBOG8IbUNq37NCuj1WryHrBMMhoM8FotSnrVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FCD4uqxn1DSqm/baCfXvoweGZbJPXTNAoww6twgOGUPvRKHGrFqfGunyn/131mYpzzVU5dlGUtFXHSFkHpdCz6yzlw6wNR4sSEP9GF9cvo/wctv/RQAp6E6u75IZfrFJZ2gcF8l/Yk2K98StA23R3j7ZswHGiy+7beZzzF+pV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRcRAPC6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN3a27CP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 09:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756113652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1Mo1Lorz/zCWI+Q67uVMdqU1QlYPmUJoZPKIFcW8Cc=;
	b=JRcRAPC6Pv9GAy/vbtj4TPJnIelS8xAMyfnOYYvst2SOBF4Rbx+uD+avp5x3+FvSe/sn82
	wKvpYEgu2kZe5nMBUKDyNUWeYhjHmZtYJvDjeycMJ0YICwvZqlxYl9rAWGiDkPWyxY+9Eo
	TWdcl6xUQmIqaGY9bk5sxIi6XatGhL1vSMMvuFIySmbAqVM7QIQ1o9ArOruK+ixjTttsH0
	stEJhI0p/PaideTqCeUKJnd6VYsfp4oGnBZ655zmS+3ASbwD7+pYm8pk1MzkPJ1RdKnseb
	Xcr+vatNWrk3Aj35AAgGjhu1RJmwIuehbUrE82S3YTJWUAVcbW31JKmds9G8aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756113652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1Mo1Lorz/zCWI+Q67uVMdqU1QlYPmUJoZPKIFcW8Cc=;
	b=LN3a27CPARZ6phedqnwLeHM0DwzbnmbuYIPImuojL4lEZRpzOQhJfC2qBR0tp1pIF8zP5a
	I1Vw/8gVF6xAskAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Make the ISR clearing sane
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <871ppwih4s.ffs@tglx>
References: <871ppwih4s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611364865.1420.9416920361326381558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1b558e14f3c17dc29ce2e8cd0b8bd385e108734b
Gitweb:        https://git.kernel.org/tip/1b558e14f3c17dc29ce2e8cd0b8bd385e10=
8734b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 31 Jul 2025 16:12:19 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Aug 2025 11:05:27 +02:00

x86/apic: Make the ISR clearing sane

apic_pending_intr_clear() is fundamentally voodoo programming. It's primary
purpose is to clear stale ISR bits in the local APIC, which would otherwise
lock the corresponding interrupt priority level.

The comments and the implementation claim falsely that after clearing the
stale ISR bits, eventually stale IRR bits would be turned into ISR bits and
can be cleared as well. That's just wishful thinking because:

  1) If interrupts are disabled, the APIC does not propagate an IRR bit to
     the ISR.

  2) If interrupts are enabled, then the APIC propagates the IRR bit to the
     ISR and raises the interrupt in the CPU, which means that code _cannot_
     observe the ISR bit for any of those IRR bits.

Rename the function to reflect the purpose and make exactly _one_ attempt
to EOI the pending ISR bits and add comments why traversing the pending bit
map in low to high priority order is correct.

Instead of trying to "clear" IRR bits, simply print a warning message when
the IRR is not empty.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/871ppwih4s.ffs@tglx
---
 arch/x86/kernel/apic/apic.c | 77 +++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d73ba5a..ff4029b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1428,63 +1428,61 @@ union apic_ir {
 	u32		regs[APIC_IR_REGS];
 };
=20
-static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
+static bool apic_check_and_eoi_isr(union apic_ir *isr)
 {
 	int i, bit;
=20
-	/* Read the IRRs */
-	for (i =3D 0; i < APIC_IR_REGS; i++)
-		irr->regs[i] =3D apic_read(APIC_IRR + i * 0x10);
-
 	/* Read the ISRs */
 	for (i =3D 0; i < APIC_IR_REGS; i++)
 		isr->regs[i] =3D apic_read(APIC_ISR + i * 0x10);
=20
+	/* If the ISR map empty, nothing to do here. */
+	if (bitmap_empty(isr->map, APIC_IR_BITS))
+		return true;
+
 	/*
-	 * If the ISR map is not empty. ACK the APIC and run another round
-	 * to verify whether a pending IRR has been unblocked and turned
-	 * into a ISR.
+	 * There can be multiple ISR bits set when a high priority
+	 * interrupt preempted a lower priority one. Issue an EOI for each
+	 * set bit. The priority traversal order does not matter as there
+	 * can't be new ISR bits raised at this point. What matters is that
+	 * an EOI is issued for each ISR bit.
 	 */
-	if (!bitmap_empty(isr->map, APIC_IR_BITS)) {
-		/*
-		 * There can be multiple ISR bits set when a high priority
-		 * interrupt preempted a lower priority one. Issue an ACK
-		 * per set bit.
-		 */
-		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
-			apic_eoi();
-		return true;
-	}
+	for_each_set_bit(bit, isr->map, APIC_IR_BITS)
+		apic_eoi();
=20
-	return !bitmap_empty(irr->map, APIC_IR_BITS);
+	/* Reread the ISRs, they should be empty now */
+	for (i =3D 0; i < APIC_IR_REGS; i++)
+		isr->regs[i] =3D apic_read(APIC_ISR + i * 0x10);
+
+	return bitmap_empty(isr->map, APIC_IR_BITS);
 }
=20
 /*
- * After a crash, we no longer service the interrupts and a pending
- * interrupt from previous kernel might still have ISR bit set.
+ * If a CPU services an interrupt and crashes before issuing EOI to the
+ * local APIC, the corresponding ISR bit is still set when the crashing CPU
+ * jumps into a crash kernel. Read the ISR and issue an EOI for each set
+ * bit to acknowledge it as otherwise these slots would be locked forever
+ * waiting for an EOI.
  *
- * Most probably by now the CPU has serviced that pending interrupt and it
- * might not have done the apic_eoi() because it thought, interrupt
- * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
- * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
- * a vector might get locked. It was noticed for timer irq (vector
- * 0x31). Issue an extra EOI to clear ISR.
+ * If there are pending bits in the IRR, then they won't be converted into
+ * ISR bits as the CPU has interrupts disabled. They will be delivered once
+ * the CPU enables interrupts and there is nothing which can prevent that.
  *
- * If there are pending IRR bits they turn into ISR bits after a higher
- * priority ISR bit has been acked.
+ * In the worst case this results in spurious interrupt warnings.
  */
-static void apic_pending_intr_clear(void)
+static void apic_clear_isr(void)
 {
-	union apic_ir irr, isr;
+	union apic_ir ir;
 	unsigned int i;
=20
-	/* 512 loops are way oversized and give the APIC a chance to obey. */
-	for (i =3D 0; i < 512; i++) {
-		if (!apic_check_and_ack(&irr, &isr))
-			return;
-	}
-	/* Dump the IRR/ISR content if that failed */
-	pr_warn("APIC: Stale IRR: %256pb ISR: %256pb\n", irr.map, isr.map);
+	if (!apic_check_and_eoi_isr(&ir))
+		pr_warn("APIC: Stale ISR: %256pb\n", ir.map);
+
+	for (i =3D 0; i < APIC_IR_REGS; i++)
+		ir.regs[i] =3D apic_read(APIC_IRR + i * 0x10);
+
+	if (!bitmap_empty(ir.map, APIC_IR_BITS))
+		pr_warn("APIC: Stale IRR: %256pb\n", ir.map);
 }
=20
 /**
@@ -1541,8 +1539,7 @@ static void setup_local_APIC(void)
 	value |=3D 0x10;
 	apic_write(APIC_TASKPRI, value);
=20
-	/* Clear eventually stale ISR/IRR bits */
-	apic_pending_intr_clear();
+	apic_clear_isr();
=20
 	/*
 	 * Now that we are all set up, enable the APIC


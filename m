Return-Path: <linux-tip-commits+bounces-5070-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6467A934DD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01FD8A7C77
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158126FA7D;
	Fri, 18 Apr 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiSTExmK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J080rVux"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573726B2D3;
	Fri, 18 Apr 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965988; cv=none; b=h+Y8iiyqumwdzCzScFqP/YyX9zq6sy+3VSlCOrgAYayGK0ws5acQnszYQMEMTlRX+AALD94tdhZWc1iHDo3e+gQ2ooK2XjppVdal+gwW5gR1khcsAruGrWdChw6vOGGfg0rpINEGVJUnQNkCLu6gwdVxf1PMSLTAh6H6yIDiqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965988; c=relaxed/simple;
	bh=xwDpBoVIKECY1p4SNUHpqa8gG61ldCofU2V3WLM/0ck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tRz6qGqafuGiBgJ0BMGJ7zJQZeJXsXp9idXrbkmz1HAnRipd3FUwmLjAMlq8o999DVxiKrGySziIr6K4UBB0sR+45wfQTvs6nsA+rtEF2WJOPZvKJqW44G47Ni6MC6gGOtBqglrtFDu3sU+VMOxvtK+EV9IxqmqMkSpI8aRCttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiSTExmK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J080rVux; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:46:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVVzJkcGt6qe/IXFLdEhDJkg024u/q09Uv0/t7d7nA=;
	b=eiSTExmKCLCQYQehaPTDCfbai3UuAoLpefx6URFp+/SuMybx1Tl8VRgoDtWnuwdVFNkdbu
	Y/D+3dLAATWI4raBlpUqOARI8mmHvIloawDlc3N83lpOAdVOsQ7JdBgfYsjDVSJoHekuwD
	hdmmycoMiXqpkbF0tM2Y6XX3L8YtqxIWFt2f0loV3laedW3OV0TE8ytE54Z/JDHKL+uNvD
	BzNwu7hUgv0GAFpplCd9qTaevXEckzzMHJ2o63Z9kypWfzc4PLr6Jd7/jOogeSiAKkpNVD
	8BOsWBwxjC45N+Y/H3PruaDaYEi1i3YOKU98WpHEm8nnLN7uCfIoIG5jISVAuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVVzJkcGt6qe/IXFLdEhDJkg024u/q09Uv0/t7d7nA=;
	b=J080rVux7HhP0/dYINS2XOnCPRjeYzUEOfbRq+zExemZDRxSKq3OaiULqHu/ALr8sCq+9i
	cuMfu9Iik3CFn7Cw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Replace "REP; NOP" with PAUSE mnemonic
Cc: Nikolay Borisov <nik.borisov@suse.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418080805.83679-2-ubizjak@gmail.com>
References: <20250418080805.83679-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496598484.31282.5671192677885545892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d109ff4f0bc32de354247a6e8ede3ffc8ef14cd0
Gitweb:        https://git.kernel.org/tip/d109ff4f0bc32de354247a6e8ede3ffc8ef14cd0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 18 Apr 2025 10:07:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:19:25 +02:00

x86/asm: Replace "REP; NOP" with PAUSE mnemonic

Current minimum required version of binutils is 2.25,
which supports PAUSE instruction mnemonic.

Replace "REP; NOP" with this proper mnemonic.

No functional change intended.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250418080805.83679-2-ubizjak@gmail.com
---
 arch/x86/boot/boot.h                  | 2 +-
 arch/x86/include/asm/vdso/processor.h | 4 ++--
 arch/x86/kernel/relocate_kernel_64.S  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 38f17a1..f899717 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -34,7 +34,7 @@
 extern struct setup_header hdr;
 extern struct boot_params boot_params;
 
-#define cpu_relax()	asm volatile("rep; nop")
+#define cpu_relax()	asm volatile("pause")
 
 static inline void io_delay(void)
 {
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index c9b2ba7..240d761 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -7,10 +7,10 @@
 
 #ifndef __ASSEMBLER__
 
-/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+/* PAUSE is a good thing to insert into busy-wait loops. */
 static __always_inline void rep_nop(void)
 {
-	asm volatile("rep; nop" ::: "memory");
+	asm volatile("pause" ::: "memory");
 }
 
 static __always_inline void cpu_relax(void)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1d63552..ea604f4 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -405,7 +405,7 @@ SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
 	inb	%dx, %al
 	testb	$XMTRDY, %al
 	jnz	.Lready
-	rep nop
+	pause
 	jmp .Lxmtrdy_loop
 
 .Lready:
@@ -426,7 +426,7 @@ SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
 	movb	(LSR*4)(%rdx), %ah
 	testb	$XMTRDY, %ah
 	jnz	.Lready_mmio
-	rep nop
+	pause
 	jmp .Lxmtrdy_loop_mmio
 
 .Lready_mmio:


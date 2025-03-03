Return-Path: <linux-tip-commits+bounces-3833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29DA4CC23
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAA6189610E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B6233120;
	Mon,  3 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCBwR/sS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="89eYe2Hx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B0231CB0;
	Mon,  3 Mar 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030967; cv=none; b=c5CRGKiJnqqlvbmYiGbG8RyHaDEz9yIitUPnTZI7tmxiAWHapIESUEpsKQBQLzIjfCiVi1na9pB4zxyyQJFLe7poEiI/k3B0pNt2juq7xReHq4faeUrywnwI55loAeIVxZ/r4kjQ9Ak5FI9M1KQRqA5uJzyOGxs9dvjz2h0WHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030967; c=relaxed/simple;
	bh=H+gR3PQ/Dx77ugktUrmlqnLP+dzHy9b5ULJAAHrRYYQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y262aqrmYoTRAG3DQq45t9BG+e9H+al1rqI4YIciSg7vZyF5xfv1uyJlUemZEn8/zYskNf7vdTsL98s+AuiPuJuObeW60iWlGMWloLqCBjZnfA7h24Y9W+6ZTQYQaEoNGcGZzEAfYgEpOJwLkInxz7jocUpZgbW4x//uHGPLrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCBwR/sS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=89eYe2Hx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741030963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GTzabpC7n36RDcyJGC0/dNMq1h9TWvPKpFpVF7s6V4=;
	b=JCBwR/sSIYWmKw+Bvjp6KmIMOJqCQFfXoFicpfdWLHoG7E9b78F2WBjoZ/gUpykqOcFGdK
	J4X3hiv3TJJxRufoLcgGJCdDN3zUCJBI64C80PTD9XktZhULi3MW+J46LWbvncAFCes2l2
	2QJrhwfWP+ddmxURo+xO4ifo1QyJdN6P9HnToEAUsliTx43NX9+Jj+8kqTBIo1SrkFXSKC
	TAzas7H4uvVl72GKsOlOGftGhHAF489PQ4Iq+awCU3Uj7GyzhVD34aYpFXMrwH7Ab7eI4Z
	ybQBSAmT2XBxVACaapoQIy5VpWYvp4tD5ygw0LwfaH9g/GLM4QBt8+1SZOW4hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741030963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GTzabpC7n36RDcyJGC0/dNMq1h9TWvPKpFpVF7s6V4=;
	b=89eYe2Hxgk6kC9vmJPiQD9MTxj6RLmjklVnL7OGZHlWzVnEfKtRJ1yZMrAm6y8v4xflUfV
	eXdm7u92DQDcKUDA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp/32: Remove safe_smp_processor_id()
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Uros Bizjak <ubizjak@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303170115.2176553-1-brgerst@gmail.com>
References: <20250303170115.2176553-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174103096111.14745.14730277832097676622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     604ea3e90b17f27928a64d86259c57710c254438
Gitweb:        https://git.kernel.org/tip/604ea3e90b17f27928a64d86259c57710c254438
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 12:01:15 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 20:30:09 +01:00

x86/smp/32: Remove safe_smp_processor_id()

The safe_smp_processor_id() function was originally implemented in:

  dc2bc768a009 ("stack overflow safe kdump: safe_smp_processor_id()")

to mitigate the CPU number corruption on a stack overflow.  At the time,
x86-32 stored the CPU number in thread_struct, which was located at the
bottom of the task stack and thus vulnerable to an overflow.

The CPU number is now located in percpu memory, so this workaround
is no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250303170115.2176553-1-brgerst@gmail.com
---
 arch/x86/include/asm/cpu.h |  1 -
 arch/x86/include/asm/smp.h |  6 ------
 arch/x86/kernel/apic/ipi.c | 30 ------------------------------
 arch/x86/kernel/crash.c    |  2 +-
 arch/x86/kernel/reboot.c   |  2 +-
 5 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 98eced5..f44bbce 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -12,7 +12,6 @@
 #ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
 #define cpu_acpi_id(cpu)			0
-#define safe_smp_processor_id()			0
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f4..2419e50 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -136,12 +136,6 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
 #define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
 #define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
 
-#ifdef CONFIG_X86_32
-extern int safe_smp_processor_id(void);
-#else
-# define safe_smp_processor_id()	smp_processor_id()
-#endif
-
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return per_cpu(cpu_llc_shared_map, cpu);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5da693d..23025a3 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -287,34 +287,4 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
-
-#ifdef CONFIG_SMP
-static int convert_apicid_to_cpu(u32 apic_id)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		if (per_cpu(x86_cpu_to_apicid, i) == apic_id)
-			return i;
-	}
-	return -1;
-}
-
-int safe_smp_processor_id(void)
-{
-	u32 apicid;
-	int cpuid;
-
-	if (!boot_cpu_has(X86_FEATURE_APIC))
-		return 0;
-
-	apicid = read_apic_id();
-	if (apicid == BAD_APICID)
-		return 0;
-
-	cpuid = convert_apicid_to_cpu(apicid);
-
-	return cpuid >= 0 ? cpuid : 0;
-}
-#endif
 #endif
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af81..0be61c4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -140,7 +140,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	x86_platform.guest.enc_kexec_begin();
 	x86_platform.guest.enc_kexec_finish();
 
-	crash_save_cpu(regs, safe_smp_processor_id());
+	crash_save_cpu(regs, smp_processor_id());
 }
 
 #if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 9aaac1f..964f6b0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -921,7 +921,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 		return;
 
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
-	crashing_cpu = safe_smp_processor_id();
+	crashing_cpu = smp_processor_id();
 
 	shootdown_callback = callback;
 


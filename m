Return-Path: <linux-tip-commits+bounces-2041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9F950D7A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E0C1F22B6C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBC1A2C14;
	Tue, 13 Aug 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHELRHAI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+kT+4mD5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1942E416;
	Tue, 13 Aug 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579408; cv=none; b=YB5TZsdrEjhh9hZ8sZX4W7qoBrdfyUk49sqzwT2FKnjdX8UyII21vJioThSEAtvuZgSXOu2R05ykxghHzzVxc6ODmQYm2DOnxxd0kboeJIRaN4QwaLkctoxQ2gETiFi4Nnk1EZiaM9KN8lG0/yPvxA1UrHBrBEZrndwDwqoOrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579408; c=relaxed/simple;
	bh=GvA7nOoxLc6+ww87Bqo5/tL8atvpVCJvdrusb77NrOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NwgzLgOJ8rytPNwFVFYzbB5ANbI6nCPlpzA5yYYQPIl1fR/c09lsObKRpkEC5Xnolf3QlNmGBUK7ZNZkWn2xWLtCEV2jaxqVnb6yRWa0LxVOMBBYyNutIdvLdBSokGj+9DyOIDN7D9KVMIhO2QmQD5lohHR59iGfqWdj3JG91ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHELRHAI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+kT+4mD5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 20:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723579405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcCy5cOuK/90xAkinn2NSJw+draZWh0P7iK8xg+KPHo=;
	b=tHELRHAI4Kp1ZlJsHEhTOdYPSFYWEblVkumKzpNyUsKqJQEW85PCnDn+70zHqrtB8ru9Yk
	ntvPf0e9nmRiVUbt1nhPJ5/gkLrBAKeqH9s3DrGR1pHhXD9JZj66Vvy6L6bYFoTGl2IGrv
	/AWnGEHF3Ri5OKgiBp0Mt80tcS29cJM63Hfq67EeVQNCW7dFIDvND/cFxEEn7T6nb19V96
	T5g7psDdcXtywAekgWXD8xC7Dhkn8gViLEeH8G5JhA4ONicUzCEowQtlqBkn7G3dH+2Yiw
	v8chP9mdayTcPk7WBDsA+kururtekGU1kuLFOc1g8SRPKW/p3fNXqbTkeueJKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723579405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcCy5cOuK/90xAkinn2NSJw+draZWh0P7iK8xg+KPHo=;
	b=+kT+4mD5o8TYotDN0nfSdIwXL6IL19j0VTOulcBaYzLbSTXGgKhdcgqPhVk9LIfBvB4kBq
	cSmMeFm9GCAJq/CQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Move FRED RSP initialization into a
 separate function
Cc: "Xin Li (Intel)" <xin@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240709154048.3543361-3-xin@zytor.com>
References: <20240709154048.3543361-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172357940513.2215.12539377108944074409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     73270c1f2369fb37683121ebe097cd37172602b6
Gitweb:        https://git.kernel.org/tip/73270c1f2369fb37683121ebe097cd37172602b6
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 09 Jul 2024 08:40:47 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 21:59:21 +02:00

x86/fred: Move FRED RSP initialization into a separate function

To enable FRED earlier, move the RSP initialization out of
cpu_init_fred_exceptions() into cpu_init_fred_rsps().

This is required as the FRED RSP initialization depends on the availability
of the CPU entry areas which are set up late in trap_init(),

No functional change intended. Marked with Fixes as it's a depedency for
the real fix.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240709154048.3543361-3-xin@zytor.com
---
 arch/x86/include/asm/fred.h  |  2 ++
 arch/x86/kernel/cpu/common.c |  6 ++++--
 arch/x86/kernel/fred.c       | 28 +++++++++++++++++++---------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index e86c7ba..66d7dbe 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -84,11 +84,13 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int 
 }
 
 void cpu_init_fred_exceptions(void);
+void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
 
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
+static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
 static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 #endif /* CONFIG_X86_FRED */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 10a5402..6de12b3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2195,10 +2195,12 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		cpu_init_fred_exceptions();
-	else
+		cpu_init_fred_rsps();
+	} else {
 		load_current_idt();
+	}
 }
 
 /*
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 4bcd879..99a134f 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -32,6 +32,25 @@ void cpu_init_fred_exceptions(void)
 	       FRED_CONFIG_INT_STKLVL(0) |
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
+	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
+	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+	wrmsrl(MSR_IA32_FRED_RSP1, 0);
+	wrmsrl(MSR_IA32_FRED_RSP2, 0);
+	wrmsrl(MSR_IA32_FRED_RSP3, 0);
+
+	/* Enable FRED */
+	cr4_set_bits(X86_CR4_FRED);
+	/* Any further IDT use is a bug */
+	idt_invalidate();
+
+	/* Use int $0x80 for 32-bit system calls in FRED mode */
+	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+}
+
+/* Must be called after setup_cpu_entry_areas() */
+void cpu_init_fred_rsps(void)
+{
 	/*
 	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
 	 * (remember that user space faults are always taken on stack level 0)
@@ -47,13 +66,4 @@ void cpu_init_fred_exceptions(void)
 	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
 	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
 	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
-
-	/* Enable FRED */
-	cr4_set_bits(X86_CR4_FRED);
-	/* Any further IDT use is a bug */
-	idt_invalidate();
-
-	/* Use int $0x80 for 32-bit system calls in FRED mode */
-	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
-	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }


Return-Path: <linux-tip-commits+bounces-278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7248449A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 22:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227D328790D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6A3B187;
	Wed, 31 Jan 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLDJgbk6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXM+oxwo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964043A26E;
	Wed, 31 Jan 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735690; cv=none; b=iD5ZMyHPC9KGzKt3Dd30Yn2EDpDScZM0FFa7c4q2lUl30IJrkjG8cLtx6cLhnpFa7I8er0aW/iDlFW6qCNlJxkdpMgg3EwnPxzWfn5t7qaeM2ePXtTUAxAHikMnSEwj+UPH4YRGyvFVGS/z7ibx0qKGJGar+PHM+d2HVW/y3/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735690; c=relaxed/simple;
	bh=Db4Q/mmSWJ7ayxncUQUglDlAIqfsF0qJwmH9qDJ34KE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RczYfa+8cGtf7nF8xox7d6f4PmslUosEPe11ooA8bZtQg0fk0GRV7nFNzQ2qSOj1LEGWAAWUfknDkhGmfgeL3VYfqYep0MOjtAP1FnY/RTIXYHopLjoT2pHuLQu0oyMne0cs0h+EVbrh7Zmk0DXN2GncUwgu/SUAYnJRnpOQERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLDJgbk6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXM+oxwo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaJbSjlL5eExN8VmWlU2UKC3RlkZ91GxSqOwO4Ce42g=;
	b=zLDJgbk61H5m8KB4T5N4aL7Yq8fGouF8eBB1w2WriIdpy3lwS/jUfa8OhNIRxr6fIGg6+/
	pkLxTm82VeNng3f3x+cLy5OpYy6GkxtVB6YNUi5V9W4qhUMroxJgzGdBqQQQ11wpEBWQis
	ogjB/07oXhYJIEyD6HHMnvKVzHU5w5UchYS944vMInvKspq162gzafgTctIpod9VHBIMhE
	D9mINpa/kvFJV1h/IVkj/Fx6PlGl4wPgPR2WtaTCYiiE7PhIfW3OI28lLetQwscpfQ0EIL
	TBSvLKCXHxh/vbzpzjeTSj2ow1wYJ5Q6orHI1m2GpfRv9inF6T14QpO4nXzZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaJbSjlL5eExN8VmWlU2UKC3RlkZ91GxSqOwO4Ce42g=;
	b=nXM+oxwo4iGVTeaxGuT99WbfiFxpvOZjOA/D/xbK5atx53ybW5ya+1H7Q+DfsZrFRiveF5
	9QIUNvvzpd4MiGCg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a debug fault entry stub for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-24-xin3.li@intel.com>
References: <20231205105030.8698-24-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568630.398.8349428214851567532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     99fcc968e7c4b117c91f7d03c302d860b74b947b
Gitweb:        https://git.kernel.org/tip/99fcc968e7c4b117c91f7d03c302d860b74b947b
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:12 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:15 +01:00

x86/fred: Add a debug fault entry stub for FRED

When occurred on different ring level, i.e., from user or kernel context,
stack, while kernel #DB on a dedicated stack. This is exactly how FRED
event delivery invokes an exception handler: ring 3 event on level 0
stack, i.e., current task stack; ring 0 event on the #DB dedicated stack
specified in the IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED debug
exception entry stub doesn't do stack switch.

On a FRED system, the debug trap status information (DR6) is passed on
the stack, to avoid the problem of transient state. Furthermore, FRED
transitions avoid a lot of ugly corner cases the handling of which can,
and should be, skipped.

The FRED debug trap status information saved on the stack differs from
DR6 in both stickiness and polarity; it is exactly in the format which
debug_read_clear_dr6() returns for the IDT entry points.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-24-xin3.li@intel.com
---
 arch/x86/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c37489..1b19a17 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/ftrace.h>
 #include <asm/traps.h>
 #include <asm/desc.h>
+#include <asm/fred.h>
 #include <asm/fpu/api.h>
 #include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
@@ -935,8 +936,7 @@ static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 	return false;
 }
 
-static __always_inline void exc_debug_kernel(struct pt_regs *regs,
-					     unsigned long dr6)
+static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 {
 	/*
 	 * Disable breakpoints during exception handling; recursive exceptions
@@ -948,6 +948,11 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 *
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
+	 *
+	 * For FRED, nested #DB should just work fine. But when a watchpoint or
+	 * breakpoint is set in the code path which is executed by #DB handler,
+	 * it results in an endless recursion and stack overflow. Thus we stay
+	 * with the IDT approach, i.e., save DR7 and disable #DB.
 	 */
 	unsigned long dr7 = local_db_save();
 	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
@@ -977,7 +982,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
 	 */
-	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    (dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
 	/*
@@ -1009,8 +1015,7 @@ out:
 	local_db_restore(dr7);
 }
 
-static __always_inline void exc_debug_user(struct pt_regs *regs,
-					   unsigned long dr6)
+static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)
 {
 	bool icebp;
 
@@ -1094,6 +1099,34 @@ DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
 	exc_debug_user(regs, debug_read_clear_dr6());
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #DB needs to be handled on different stack: User #DB on
+ * current task stack, while kernel #DB on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #DB dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED debug exception
+ * entry stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_DEBUG(exc_debug)
+{
+	/*
+	 * FRED #DB stores DR6 on the stack in the format which
+	 * debug_read_clear_dr6() returns for the IDT entry points.
+	 */
+	unsigned long dr6 = fred_event_data(regs);
+
+	if (user_mode(regs))
+		exc_debug_user(regs, dr6);
+	else
+		exc_debug_kernel(regs, dr6);
+}
+#endif /* CONFIG_X86_FRED */
+
 #else
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)


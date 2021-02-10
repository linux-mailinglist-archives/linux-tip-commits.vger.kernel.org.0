Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72C4316691
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBJMZ1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 07:25:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhBJMXs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 07:23:48 -0500
Date:   Wed, 10 Feb 2021 12:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612959782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQVL9DyeN/TePUg/Z4cAv4C7Yah//iWSAblU5bnN9+k=;
        b=cP94gF+QcI+QkQdTn1quAHkYTXj/KK0Y8p2+Sv28VikBYYnVtU7bHK4Q7tLmuLlMtWx6St
        FORXPLGtTvztK/UcWvjpijAH1DLitT5JghQIISSU806su1srfbJvS8syBgGGJDCddBXZl1
        EnIuYMTV1ezAxkYH+IsIMH7qGZvUwjNsoNjh2YNiK5k6FCQ5Qk4Gic7c2DD0QY34AeoIYU
        wmJD8XK1xN0VKLYteWpYEpAicLw8cq0KPDr3+Z98P8FNIudzCFFqvSOzqwqB47+rv1ZpGz
        K+Z73Ld1+7ypH6MTJCqR2CC7TsBJgl+r7EY/S+qzDoCo+FgTGjAWMEKbMSQBjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612959782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQVL9DyeN/TePUg/Z4cAv4C7Yah//iWSAblU5bnN9+k=;
        b=RAKbj200Z7qt0FgjITjdcpzQeu70Mdsv2UT/TKTkICT7m2MPdQCPRdH9jQmLAKtZ0x8MP2
        2BHwNa2u18AarbCw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/xen: Use specific Xen pv interrupt entry for DF
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120135555.32594-4-jgross@suse.com>
References: <20210120135555.32594-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161295978163.23325.10478028782418680739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     5b4c6d65019bff65757f61adbbad5e45a333b800
Gitweb:        https://git.kernel.org/tip/5b4c6d65019bff65757f61adbbad5e45a333b800
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 20 Jan 2021 14:55:43 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 12:13:40 +01:00

x86/xen: Use specific Xen pv interrupt entry for DF

Xen PV guests don't use IST. For double fault interrupts, switch to
the same model as NMI.

Correct a typo in a comment while copying it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210120135555.32594-4-jgross@suse.com
---
 arch/x86/include/asm/idtentry.h |  3 +++
 arch/x86/xen/enlighten_pv.c     | 10 ++++++++--
 arch/x86/xen/xen-asm.S          |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 616909e..41e2e2e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -608,6 +608,9 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 
 /* #DF */
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
+#endif
 
 /* #VC */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9db1d31..1fec2ee 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -567,10 +567,16 @@ void noist_exc_debug(struct pt_regs *regs);
 
 DEFINE_IDTENTRY_RAW(xenpv_exc_nmi)
 {
-	/* On Xen PV, NMI doesn't use IST.  The C part is the sane as native. */
+	/* On Xen PV, NMI doesn't use IST.  The C part is the same as native. */
 	exc_nmi(regs);
 }
 
+DEFINE_IDTENTRY_RAW_ERRORCODE(xenpv_exc_double_fault)
+{
+	/* On Xen PV, DF doesn't use IST.  The C part is the same as native. */
+	exc_double_fault(regs, error_code);
+}
+
 DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
 {
 	/*
@@ -622,7 +628,7 @@ struct trap_array_entry {
 
 static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY_REDIR(exc_debug,			true  ),
-	TRAP_ENTRY(exc_double_fault,			true  ),
+	TRAP_ENTRY_REDIR(exc_double_fault,		true  ),
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY_REDIR(exc_machine_check,		true  ),
 #endif
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index cd330ce..eac9dac 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -161,7 +161,7 @@ xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
 xen_pv_trap asm_exc_device_not_available
-xen_pv_trap asm_exc_double_fault
+xen_pv_trap asm_xenpv_exc_double_fault
 xen_pv_trap asm_exc_coproc_segment_overrun
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present

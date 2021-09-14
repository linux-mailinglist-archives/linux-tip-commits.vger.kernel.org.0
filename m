Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71740B7DD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhINTU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhINTUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1BC0613CF;
        Tue, 14 Sep 2021 12:19:36 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7Y1SwaK8XKHkzFgLX+KApB8GqLbt1cLYesscxLLXX4=;
        b=DVNAQfEC4nRLSZzeimhhUiTDYtaOUeEkf3f3/7aPwhCYenFhX1uhf7YSiqdirnogiuwQVy
        OaxBQXvGAhWqVxxXoSGObYUmuc0s6utzpnvuj1J3VLc93+2i9uQN/2BgnAhGGAWppKyplo
        nzl4QkVMyqwaL+ba/0Mf7Fr9kAuhcE0MHhQHKPjUo+tBz1o4Q4rlHIixFefSZFp6zj1WHP
        t0r1LsrEB3nk+v2HYpVZ9NljZDzbWaQ2kLc3c/8hrzQOFkdgtECRVqamOC1wuvhICcbvp5
        FGkDs4y2DXyExWZw+hiNlO0qBTMqynIyyCy/qQ0evGHBeetZ/qIJykISEMBq/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7Y1SwaK8XKHkzFgLX+KApB8GqLbt1cLYesscxLLXX4=;
        b=85MW2BtBf60/2UurS3rYApUzE62UWa3uIXb090Ojr9Egrbe9bYE8yWOfpm9rrPQHDWFWtY
        LH4qZ2O/frDeagCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and
 EX_TYPE_FAULT_MCE_SAFE
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.269689153@linutronix.de>
References: <20210908132525.269689153@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717400.25758.12520336585385649795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2cadf5248b9316d3c8af876e795d61c55476f6e9
Gitweb:        https://git.kernel.org/tip/2cadf5248b9316d3c8af876e795d61c55476f6e9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 17:56:56 +02:00

x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE

Provide exception fixup types which can be used to identify fixups which
allow in kernel #MC recovery and make them invoke the existing handlers.

These will be used at places where #MC recovery is handled correctly by the
caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.269689153@linutronix.de
---
 arch/x86/include/asm/extable_fixup_types.h | 3 +++
 arch/x86/kernel/cpu/mce/severity.c         | 2 ++
 arch/x86/mm/extable.c                      | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 0adc117..409524d 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -16,4 +16,7 @@
 #define	EX_TYPE_WRMSR_IN_MCE		10
 #define	EX_TYPE_RDMSR_IN_MCE		11
 
+#define	EX_TYPE_DEFAULT_MCE_SAFE	12
+#define	EX_TYPE_FAULT_MCE_SAFE		13
+
 #endif
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 74fe763..d9b77a7 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -278,6 +278,8 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
 	case EX_TYPE_FAULT:
+	case EX_TYPE_FAULT_MCE_SAFE:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 	default:
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 5db46df..f37e290 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -131,8 +131,10 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 
 	switch (e->type) {
 	case EX_TYPE_DEFAULT:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		return ex_handler_default(e, regs);
 	case EX_TYPE_FAULT:
+	case EX_TYPE_FAULT_MCE_SAFE:
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr);

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9713540C8C0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhIOPu5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbhIOPuq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:46 -0400
Date:   Wed, 15 Sep 2021 15:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fjhbXEKppGuKB+xUAOkAcN5O7s+cDx0ovQHGHwFteM=;
        b=mBn9aEQuyL//ZbqtrjYoYrSJ/n1rfunh7yXrk2iJeNyDHVc4e9SmceuUL/crKdoG3dpDv5
        EVveqGo12kcoJ1KbxVssMwfPg+pQywuzBv2ZmZRDNRXNzWCntlC7XWM7LvNfMJTHofePNr
        X/5sMf8yXcos55M1fDAAlCSxX5WC5GJ/+KFqtyu90Ig/mZzrmA9JFCQRbiUdb7SPqSG5Jv
        e/9Enxa72M4j20iGHqRJ/7ASxZPkqdu1INmT3TwN49yoQEI7qy9L279ADtFJoUo+ImKGKP
        0ArH1GVAJkiQupA9CpbQPr0r55qjZEfH8jPhxMpscb5XqSpOBX/pt3+9kQhIlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fjhbXEKppGuKB+xUAOkAcN5O7s+cDx0ovQHGHwFteM=;
        b=k0N/k4U6zC+XYbV7saGLM0tE+MvfMNl2uqR9ng5V0gUU0172FfhhsFbxlJAsSdDo7O4sA+
        keipQqi64zHmd2Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/paravirt: Mark arch_local_irq_*() __always_inline
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.373073648@infradead.org>
References: <20210624095148.373073648@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096597.25758.2067221531217278079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e9382440de18718fb6f878986c0844c30abc6f99
Gitweb:        https://git.kernel.org/tip/e9382440de18718fb6f878986c0844c30abc6f99
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:47 +02:00

x86/paravirt: Mark arch_local_irq_*() __always_inline

vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x72: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x73: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: match_held_lock()+0x11f: call to arch_local_save_flags() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0x4e: call to arch_local_irq_save() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0x65: call to arch_local_irq_disable() leaves .noinstr.text section

vmlinux.o: warning: objtool: lock_is_held_type()+0xfe: call to arch_local_irq_enable() leaves .noinstr.text section

It makes no sense to not inline these things.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.373073648@infradead.org
---
 arch/x86/include/asm/paravirt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index da3a1ac..89a5322 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -678,23 +678,23 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	((struct paravirt_callee_save) { func })
 
 #ifdef CONFIG_PARAVIRT_XXL
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
 				ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
 	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline notrace unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long f;
 

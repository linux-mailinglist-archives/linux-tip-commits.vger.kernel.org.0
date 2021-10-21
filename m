Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE5436565
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJUPOz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhJUPOt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:49 -0400
Date:   Thu, 21 Oct 2021 15:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWmMIgje3kCNVNAM6KyVr+i7erC+6mI2PBaCTEQcScw=;
        b=nlcySJ4O9IZFhbSiwNZyURrOrulKgnlFyexJ61lFhui1tLYYDcck7kjoHgOV4LicFhjwDj
        rH/TUL2nScY13WS4vHpKlAjQUdhoY8uGBRdNcg8qS/m2XUr29O7V7F4Cb9qw6VB3Navam+
        q+UJueFRTggKinj0SUQZUXAXJKSTOMC2f62hF3jHPWxE6PuzAOfuQuvcEWmaFIQRZqIU6w
        O4pIVsfiGyKzS9AEuBXdQPYWs5CDyKqFjYPgI2oXrv5UrCaRLYcrZF69ZEvwlOrVyNg97E
        bjiaQzeyjsCD+nMDl6gv2BahJyb55jh++4L7Csgbw7/HiDSRlC65XeaFaZpyag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWmMIgje3kCNVNAM6KyVr+i7erC+6mI2PBaCTEQcScw=;
        b=ht9FocV2p2KNMPbKt5qaqO2DA87l7C1Dcnbb2sbHopuWLgc7x+volTsmdw/IBT063QThnY
        nptQPSb+rHJzzHBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/math-emu: Convert to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.711347464@linutronix.de>
References: <20211013145322.711347464@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915140.25758.6638128318451756940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     63d6bdf36ce1541e656966604c12ac4d9fc5d1f0
Gitweb:        https://git.kernel.org/tip/63d6bdf36ce1541e656966604c12ac4d9fc5d1f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 23:57:54 +02:00

x86/math-emu: Convert to fpstate

Convert math emulation code to the new register storage
mechanism in preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.711347464@linutronix.de
---
 arch/x86/math-emu/fpu_aux.c    | 2 +-
 arch/x86/math-emu/fpu_entry.c  | 4 ++--
 arch/x86/math-emu/fpu_system.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/math-emu/fpu_aux.c b/arch/x86/math-emu/fpu_aux.c
index 0347484..d62662b 100644
--- a/arch/x86/math-emu/fpu_aux.c
+++ b/arch/x86/math-emu/fpu_aux.c
@@ -53,7 +53,7 @@ void fpstate_init_soft(struct swregs_state *soft)
 
 void finit(void)
 {
-	fpstate_init_soft(&current->thread.fpu.state.soft);
+	fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
 }
 
 /*
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 50195e2..7fe56c5 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -640,7 +640,7 @@ int fpregs_soft_set(struct task_struct *target,
 		    unsigned int pos, unsigned int count,
 		    const void *kbuf, const void __user *ubuf)
 {
-	struct swregs_state *s387 = &target->thread.fpu.state.soft;
+	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
 	void *space = s387->st_space;
 	int ret;
 	int offset, other, i, tags, regnr, tag, newtop;
@@ -691,7 +691,7 @@ int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
 		    struct membuf to)
 {
-	struct swregs_state *s387 = &target->thread.fpu.state.soft;
+	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
 	const void *space = s387->st_space;
 	int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index 9b41391..eec3e48 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -73,7 +73,7 @@ static inline bool seg_writable(struct desc_struct *d)
 	return (d->type & SEG_TYPE_EXECUTE_MASK) == SEG_TYPE_WRITABLE;
 }
 
-#define I387			(&current->thread.fpu.state)
+#define I387			(&current->thread.fpu.fpstate->regs)
 #define FPU_info		(I387->soft.info)
 
 #define FPU_CS			(*(unsigned short *) &(FPU_info->regs->cs))

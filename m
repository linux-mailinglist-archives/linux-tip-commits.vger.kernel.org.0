Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE30440B7D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhINTU5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhINTUv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:51 -0400
Date:   Tue, 14 Sep 2021 19:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=el4OwPBZPN6izhwEQDnB/jHrC2CM798RCjQcJZKN/p0=;
        b=K1AibxR4R3+3yOKAytytNqCaRmmA0dAJGR8eA5y/sRYyLPNd7NgRlRBI8ehS8/NF1Q/xru
        mfPRbW8Y+UjCCVshL59gG+KcM0h/H+dh109a+cD3aSfORkOakQNNF56LBr8LaI1NlvhcZA
        823JfXH8ySorLwOUJzHORPtsWchFlByJAVUUJjoZiCcgnNLh+6nQchIqclsV745LYgGzQk
        oBdpEoOXYj4TDjujBO58VuaZ8UqczTT+0h/kDZnIy0vh30XnKrobTxZrd4bYIoih432Z0G
        5RK6pnNU6qhgd5oLIF6mx2BUkcbi3KVM8ZrIvXae8izEzhZ5J7UChf4phys5fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=el4OwPBZPN6izhwEQDnB/jHrC2CM798RCjQcJZKN/p0=;
        b=IsVgyfXUAUVABT8DabBmiNSluRXHmtrUHs04+4uthldstZVTMwk4/PPIlOS/jG8L+sQTlF
        WjXJuCovbBKzXRAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.387464538@linutronix.de>
References: <20210908132525.387464538@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717246.25758.6728273019405759859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c6304556f3ae98c943bbb4042a30205c98e4f921
Gitweb:        https://git.kernel.org/tip/c6304556f3ae98c943bbb4042a30205c98e4f921
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 18:15:30 +02:00

x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups

The macros used for restoring FPU state from a user space buffer can handle
all exceptions including #MC. They need to return the trap number in the
error case as the code which invokes them needs to distinguish the cause of
the failure. It aborts the operation for anything except #PF.

Use the new EX_TYPE_FAULT_MCE_SAFE exception table fixup type to document
the nature of the fixup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.387464538@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index ce6fc4f..cb1ca60 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -102,7 +102,7 @@ extern void save_fpregs_to_fpstate(struct fpu *fpu);
 		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -209,7 +209,7 @@ static inline void fxsave(struct fxregs_state *fx)
 		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")

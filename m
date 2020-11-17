Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79402B6D44
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKQSY3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:24:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgKQSY3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:24:29 -0500
Date:   Tue, 17 Nov 2020 18:24:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605637467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MTvaS+eHXfB2N2NJjdGT/l6a3wpaVEznEXmdnV2axg=;
        b=g7jjYObIEAiwZGEDPamCdKZ+mblD2MDTsUH0EF9DLLU/bC9nw/g8hs/T1DjWHGIgW327oz
        wSMXPEuwZr5i89MStI5Ya4meI1rNUrD7ihoY+iaFPgsWjEe4x5JLZfFbkmsxtau981SIxz
        dwAVeSCLp0Ihn+kruLxND9IVzZR1AGyjtlM1Xj5RaMJqB+Ofva8auVl62295ZGq5y1a6/v
        yKdFXklydSE/wWvZGoedo95HvpVSCnrgfAFnb7aLaWGqKJ8+BUBUdaxInXQd9g9Bvent69
        /Oa104k1PLxosJiiyhvrEB0nhzA1htug5ZJbeRy503R1ghZht8oEPHhgVOGWAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605637467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MTvaS+eHXfB2N2NJjdGT/l6a3wpaVEznEXmdnV2axg=;
        b=a2Ro4KDFjFDjXIa/Y/WM9lAEAplDNbqA4DB/rAiOu87wJzbl8WNOhbW6WQrjjrA/gNR91Z
        jSMjNc8PSjOhX0DQ==
From:   "tip-bot2 for Hui Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/dumpstack: Make show_trace_log_lvl() static
Cc:     Hui Su <sh_def@163.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201113133943.GA136221@rlk>
References: <20201113133943.GA136221@rlk>
MIME-Version: 1.0
Message-ID: <160563746591.11244.16727538335255681874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     09a217c10504bcaef911cf2af74e424338efe629
Gitweb:        https://git.kernel.org/tip/09a217c10504bcaef911cf2af74e424338efe629
Author:        Hui Su <sh_def@163.com>
AuthorDate:    Fri, 13 Nov 2020 21:39:43 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 19:05:32 +01:00

x86/dumpstack: Make show_trace_log_lvl() static

show_trace_log_lvl() is not used by other compilation units so make it
static and remove the declaration from the header file.

Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201113133943.GA136221@rlk
---
 arch/x86/include/asm/stacktrace.h | 3 ---
 arch/x86/kernel/dumpstack.c       | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 4960064..f248eb2 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -88,9 +88,6 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 	return (unsigned long *)task->thread.sp;
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, const char *log_lvl);
-
 /* The form of the top of the frame on the stack */
 struct stack_frame {
 	struct stack_frame *next_frame;
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 25c06b6..067de0d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -168,7 +168,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	}
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;

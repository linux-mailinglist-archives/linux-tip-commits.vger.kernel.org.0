Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF14843BA8D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 21:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhJZTTd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 15:19:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35600 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhJZTTT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 15:19:19 -0400
Date:   Tue, 26 Oct 2021 19:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635275812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mvf9A+VpmAK/81H7m3DxamyZbj9rH42BDQ1I0Ad68tw=;
        b=4HWxd7hKIbUur4+OrUs0JYY4AwVEAsoUuVeW/ccMl6Cnbc8pgSHZjEvjpWtL41znnzAr6i
        uHGQudQeBB4zlcSy2CdfH/lkFEFxc1NFWDiwhTxaw2kC/ZhBDSSjHxNCdxCfHuL8bmvAwq
        Z2u0HNoi5IPldPlir0E2bT/fzBdZyS0hDlo9bz/hru8m6eSStrDWlMBRJoMBfCke2US4hQ
        WaXUy3xVHVbfU9RRXSmb3nQqS/46yIBzDIsV8EduCLsb2qDCIaJsDjvrMCdmyg62EGm2PB
        qcWFupoxB+t3CTbIa+zh//Kq6CGgF4VD014sItOyN0JYYEXYdalhwzlPWh2KTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635275812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mvf9A+VpmAK/81H7m3DxamyZbj9rH42BDQ1I0Ad68tw=;
        b=hGih5IsW5CVZ+bFbHbhS2bcrp8l+Q+40tj+F20ieWNSVq/8wqhlePYLmTmzIxRJBwd9cRt
        wJqRSfdi8Ilx1nBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86: Fix __get_wchan() for !STACKTRACE
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211022152104.137058575@infradead.org>
References: <20211022152104.137058575@infradead.org>
MIME-Version: 1.0
Message-ID: <163527581141.626.3323791861027345987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4
Gitweb:        https://git.kernel.org/tip/5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 22 Oct 2021 16:53:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Oct 2021 21:10:12 +02:00

x86: Fix __get_wchan() for !STACKTRACE

Use asm/unwind.h to implement wchan, since we cannot always rely on
STACKTRACE=y.

Fixes: bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20211022152104.137058575@infradead.org
---
 arch/x86/kernel/process.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index a69885a..8fb6bd4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/unwind.h>
 
 #include "process.h"
 
@@ -944,10 +945,20 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long __get_wchan(struct task_struct *p)
 {
-	unsigned long entry = 0;
+	struct unwind_state state;
+	unsigned long addr = 0;
 
-	stack_trace_save_tsk(p, &entry, 1, 0);
-	return entry;
+	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		if (in_sched_functions(addr))
+			continue;
+		break;
+	}
+
+	return addr;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,

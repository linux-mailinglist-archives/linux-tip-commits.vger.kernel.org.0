Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E82D4959
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgLISp3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:45:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733209AbgLISpX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:23 -0500
Date:   Wed, 09 Dec 2020 18:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uVoy/HjPdG+AVEOR58Fz+PMi+GVHWFcnLLIpyQKie0=;
        b=gEQ1K6TTEnLAeMFOV32JnurQ11+Z7d0DgTKtQnDlBfgz6wEBrJHis30YnAnVPvV+1Ks+VD
        ZKM+7x9DRJcJ5mukwwHoh32QVYNznLlWYicvpTad9enudLCKjyuFsKTXyRULq6lb7hHNuJ
        gE4e8j2ni7tCY9B6ekcLFUc2uBOh9dMzkTZ1xvmMO2+WGboNKruCRTbDlyiMDKd+IvUtAL
        mgRzB5lGk2jcBNOU+0WFoqZVxoH1cy91szjVC0KziUx9KGJrSK6PEj0hNvlXS3lGTBRaYM
        t00JfnwEWqAZix597Rvt7iVECUSInlMTJX8ER30KMMvEm6zRC5E/mKcN483ABw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uVoy/HjPdG+AVEOR58Fz+PMi+GVHWFcnLLIpyQKie0=;
        b=vUaFIfRq24IzVSW34u37WkXc9U7UDygZltOhh80oIGL3lURxE5r9kljJpe62HaDjNV6O8W
        +n8AhfhrQmuZ9QAQ==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/kprobes: Restore BTF if the single-stepping is cancelled
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <160389546985.106936.12727996109376240993.stgit@devnote2>
References: <160389546985.106936.12727996109376240993.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160753948030.3364.13136176345925305619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     78ff2733ff352175eb7f4418a34654346e1b6cd2
Gitweb:        https://git.kernel.org/tip/78ff2733ff352175eb7f4418a34654346e1b6cd2
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 28 Oct 2020 23:31:10 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:57 +01:00

x86/kprobes: Restore BTF if the single-stepping is cancelled

Fix to restore BTF if single-stepping causes a page fault and
it is cancelled.

Usually the BTF flag was restored when the single stepping is done
(in resume_execution()). However, if a page fault happens on the
single stepping instruction, the fault handler is invoked and
the single stepping is cancelled. Thus, the BTF flag is not
restored.

Fixes: 1ecc798c6764 ("x86: debugctlmsr kprobes")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/160389546985.106936.12727996109376240993.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 547c7ab..39f7d8c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -937,6 +937,11 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * So clear it by resetting the current kprobe:
 		 */
 		regs->flags &= ~X86_EFLAGS_TF;
+		/*
+		 * Since the single step (trap) has been cancelled,
+		 * we need to restore BTF here.
+		 */
+		restore_btf();
 
 		/*
 		 * If the TF flag was set before the kprobe hit,

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C2346294
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhCWPPT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:15:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhCWPPL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:15:11 -0400
Date:   Tue, 23 Mar 2021 15:15:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBjzVHLAvFeGArpcQnjxVmPZYzJCNXzIfMDe5P7eMDI=;
        b=Pz67XxsZNJkDszWoY11RLbiYQAUaibianDqlejbExzttpyVx5MxZ2U4MpikNUnx+RECjmu
        ViB1k5gjNk3E8hZbS9pWYkaz4pDkBbClxE6fRcAAIaS8+AuQ9K4WCjukn3mNBDLaygAQYI
        h0LQK4WN1px4Ui4jDkOqfNAdWXQZv2Qh93LuhW/8FmLtqS/MwmTWaUTfIyObijh+i/bzb6
        VVJPmiPBDMlpsoYfyI9A1kbYzEIPxq6ksBbsdpsEWhclct4POr9IWT/DPDja35oF0Wq581
        KQjAr478WDvVbGIA3y4NCq//ZQj6QqjpzIu+AtKfE7Ym7WNHfi0E8QDK135cug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBjzVHLAvFeGArpcQnjxVmPZYzJCNXzIfMDe5P7eMDI=;
        b=jf1egwsAQ0ZhN9KOgY8WkWstlUAybZLXBHoRQVOoUV02hC0rpbKtrmEb9ANAwLmVCRne0m
        JE/Rx9WlDyAEyWBQ==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Identify far indirect JMP correctly
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161469873475.49483.13257083019966335137.stgit@devnote2>
References: <161469873475.49483.13257083019966335137.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <161651250937.398.11142844620287353744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a194acd316f93f3435a64de3b37dca2b5a77b338
Gitweb:        https://git.kernel.org/tip/a194acd316f93f3435a64de3b37dca2b5a77b338
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 03 Mar 2021 00:25:34 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:07:56 +01:00

x86/kprobes: Identify far indirect JMP correctly

Since Grp5 far indirect JMP is FF "mod 101 r/m", it should be
(modrm & 0x38) == 0x28, and near indirect JMP is also 0x38 == 0x20.
So we can mask modrm with 0x30 and check 0x20.
This is actually what the original code does, it also doesn't care
the last bit. So the result code is same.

Thus, I think this is just a cosmetic cleanup.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469873475.49483.13257083019966335137.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 9b31790..f6ec57f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -467,8 +467,7 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 			p->ainsn.is_call = 1;
 			p->ainsn.is_abs_ip = 1;
 			break;
-		} else if (((opcode & 0x31) == 0x20) ||
-			   ((opcode & 0x31) == 0x21)) {
+		} else if ((opcode & 0x30) == 0x20) {
 			/*
 			 * jmp near and far, absolute indirect
 			 * ip is correct.

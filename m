Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0C3B0399
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFVMGC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:06:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhFVMF5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:57 -0400
Date:   Tue, 22 Jun 2021 12:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqtesPobExbORom3TGQmLJ6gP59SEzi6pkHdGPfl04Q=;
        b=4O57v1rgEcr+2dR0ViPBfw1CsyeFS3TQzpmIY8w0gmhgLZfQtNA1gKGGJK7ZNhYqFexCaH
        ObKbzbk/tFNvorxZfeuwVbSAMw4S1k5e82p3IJVyAWNklqK58UjFsoqg0cU0Elwlx41Cuw
        OxgEolsVnhe5lkztcfQKQXr/0fIkLQbxTrL5kMx33fjwNMLRzAsVLucFomZsXD+rX0et7C
        wQ1y5rdW3R3e1JDPWkW+ZrwP0oPe9pQu0YfMTM0bPcFD8hTk6Yd6NrXXJWF7SAC5bsmYxY
        wwphM4aD9JAXXvb7RUjAiglNAFrF8AtAOgIl8cQzcUn2uV7Br8j/mXJCmPHvvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqtesPobExbORom3TGQmLJ6gP59SEzi6pkHdGPfl04Q=;
        b=L93mDHbuw9BmRfmyNC/AwcHYe5/N+rVCBgfMP/6mgdHdapcGjsyTXGWNi1Dl/wp/r93Wpd
        Ni2ohBIq8bhgp7Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/entry: Fix noinstr fail in __do_fast_syscall_32()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621120120.467898710@infradead.org>
References: <20210621120120.467898710@infradead.org>
MIME-Version: 1.0
Message-ID: <162436341981.395.1786035684192237114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     240001d4e3041832e8a2654adc3ccf1683132b92
Gitweb:        https://git.kernel.org/tip/240001d4e3041832e8a2654adc3ccf1683132b92
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 13:12:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 13:56:42 +02:00

x86/entry: Fix noinstr fail in __do_fast_syscall_32()

Fix:

  vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xf5: call to trace_hardirqs_off() leaves .noinstr.text section

Fixes: 5d5675df792f ("x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210621120120.467898710@infradead.org
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b..a6bf516 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -130,8 +130,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
 
-		instrumentation_end();
 		local_irq_disable();
+		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 		return false;
 	}

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43D43974E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhFAOGj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhFAOGh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:37 -0400
Date:   Tue, 01 Jun 2021 14:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWI2L6s1F7+MymY4K+fcX9pXcbXpSqNZ2j3qDVj4Dco=;
        b=MSP7vHCTraz3zC3FhN3pyE+IrFMV+t540n6loMFszQfitLIjMblmebr6NtJ3u4MKxNn2wF
        1mxqqJl1cnEU77c+vBHyYx1DJtsSkn7lN18Bbm2pDsb1qkfBvz6LVAI8uDW0SdSsGGt00O
        szCNjdf5fKschoGTzqazBdwPfzZ/HKGP6OJ0O1E36lYDkfhHgo1+U2YNyawR7ZEyAVaL5L
        LhVMscT0nREX6dHRaxShwuFT/zhkO6PoGeDbo1+WP/SC4ayYVwzYB7r+YV9Fj9OfpDlIWY
        WaOoXpHrtjlttdUvjyUL7bKhJQ+77wdIGUxkNdjdnZYbxRfDgZwR321QYO0CSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWI2L6s1F7+MymY4K+fcX9pXcbXpSqNZ2j3qDVj4Dco=;
        b=CWPndis6hbGnBSAGthhW9ircbFYk4bgnQ5paNfsUgTwxZy1rIpcaLfx+WdPMHRO2vj6uYY
        yO8MSmYfvtNIIdDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86,kprobes: WARN if kprobes tries to handle a fault
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525073213.660594073@infradead.org>
References: <20210525073213.660594073@infradead.org>
MIME-Version: 1.0
Message-ID: <162255629094.29796.13447590338407313221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     00afe83098f59d3091a800d0db188ca495b2bc02
Gitweb:        https://git.kernel.org/tip/00afe83098f59d3091a800d0db188ca495b2bc02
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 May 2021 09:25:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:09 +02:00

x86,kprobes: WARN if kprobes tries to handle a fault

With the removal of kprobe::handle_fault there is no reason left that
kprobe_page_fault() would ever return true on x86, make sure it
doesn't happen by accident.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210525073213.660594073@infradead.org
---
 arch/x86/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1c548ad..362255b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1186,7 +1186,7 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		return;
 
 	/* kprobes don't want to hook the spurious faults: */
-	if (kprobe_page_fault(regs, X86_TRAP_PF))
+	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;
 
 	/*
@@ -1239,7 +1239,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	/* kprobes don't want to hook the spurious faults: */
-	if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
+	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;
 
 	/*

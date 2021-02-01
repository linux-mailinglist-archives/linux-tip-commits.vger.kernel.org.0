Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2870D30A69E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBALdI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBALdI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:08 -0500
Date:   Mon, 01 Feb 2021 11:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtxAiTfDiaWDoGdfKdfcuFT+l7KH4rdObYVT05rEDsw=;
        b=TZbsUREUEH3mOGtsopvS5ZKBGoQLqE26wMD0tbOkdNRt3lMEhVriUSPv/FcGQx+16uP3xg
        //HwaKtjfHsXtgWicbPQNWIzTiedoeEdOp/dnLE/eqYjKMSInCW0ifLaIUNA/JLTS8Y37x
        azDaT5OEi2CfUdAQghRO/lcLuQee+LQfFX0Aj9JQC/6WQJQTS1Y9Ir2s4gMOJr0/2nR3Un
        tz+J7I4fjy3ardG04NFRPzUp3hBBE8SG+zW9dKQ9sREZDdDaLfSfEErsnyWyuQPDWx/4bQ
        3QntKvUn9Exwk/RqnfB/3zrJR/cmp+0hgXOlobA2tiw0HeOLZC6wVuMipIkSSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtxAiTfDiaWDoGdfKdfcuFT+l7KH4rdObYVT05rEDsw=;
        b=klct4roqnMRPIErSHjPVgTBinpuX4kQwtJSpgoYHYIFRqKvJqxXxPUuC+YGx36yYt0ozod
        ecZd/9noFqKGiCDw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT
 page-tables
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127235347.1402-7-will@kernel.org>
References: <20210127235347.1402-7-will@kernel.org>
MIME-Version: 1.0
Message-ID: <161217914514.23325.15895050534940378697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     8cf55f24ce6cf90eb8828421e15e9efcd508bd2c
Gitweb:        https://git.kernel.org/tip/8cf55f24ce6cf90eb8828421e15e9efcd508bd2c
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:47 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:29 +01:00

x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables

free_ldt_pgtables() uses the MMU gather API for batching TLB flushes
over the call to free_pgd_range(). However, tlb_gather_mmu() expects
to operate on user addresses and so passing LDT_{BASE,END}_ADDR will
confuse the range setting logic in __tlb_adjust_range(), causing the
gather to identify a range starting at TASK_SIZE. Such a large range
will be converted into a 'fullmm' flush by the low-level invalidation
code, so change the caller to invoke tlb_gather_mmu_fullmm() directly.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20210127235347.1402-7-will@kernel.org
---
 arch/x86/kernel/ldt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 7ad9834..aa15132 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,7 +398,13 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm);
+	/*
+	 * Although free_pgd_range() is intended for freeing user
+	 * page-tables, it also works out for kernel mappings on x86.
+	 * We use tlb_gather_mmu_fullmm() to avoid confusing the
+	 * range-tracking logic in __tlb_adjust_range().
+	 */
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
 	tlb_finish_mmu(&tlb);
 #endif

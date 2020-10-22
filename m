Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83C295CFB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Oct 2020 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896734AbgJVKvM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Oct 2020 06:51:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896729AbgJVKuT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Oct 2020 06:50:19 -0400
Date:   Thu, 22 Oct 2020 10:49:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603363798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKE4tkuVx1iI+TMuSjokY4LRT13L/xCo/XlvF52HAFc=;
        b=NDGSsM0HrAgfwGgrZbeXJPqXGP5Wg8U341eSxX/xi7KE++8oSijZfNQsqfYM8YAaedKcvw
        1zA7NnwBH55wnXIHcMiSLytqG/g6ZH17ajSssCIfLWkatlzyqGqnwFn+08mb7Fb0vijmgV
        /VW7N4gwvuOpkUV0gxO+t8g1YtrgM+QPgoRp2Wu6iCJB9qHjPchpzi8VvW9Yr/jE1ZHPUe
        qrkWBidmx6QZr1qsYg4/54yVe22pCazaLeHfajBUvavAo3AGe+3u7gsFtXZsrLSCt5WO7L
        TJI8sR6/xn+c+nFtWL1aVkFIaY95Msd6WaomAxClWxtlqPrDylie9FvYAmostQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603363798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKE4tkuVx1iI+TMuSjokY4LRT13L/xCo/XlvF52HAFc=;
        b=MhRdHG7MYuGCgtHEfoQG1xwR6ThiVZmkax2QP5iVLaSgXtO1iexDSr49IaZKUfaP5bcNYu
        o2PxjEUw8Euka1Aw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Don't call text_poke() in lazy TLB mode
Cc:     Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201009144225.12019-1-jgross@suse.com>
References: <20201009144225.12019-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <160336379724.7002.17024152211307266195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     abee7c494d8c41bb388839bccc47e06247f0d7de
Gitweb:        https://git.kernel.org/tip/abee7c494d8c41bb388839bccc47e06247f0d7de
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 09 Oct 2020 16:42:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Oct 2020 12:37:23 +02:00

x86/alternative: Don't call text_poke() in lazy TLB mode

When running in lazy TLB mode the currently active page tables might
be the ones of a previous process, e.g. when running a kernel thread.

This can be problematic in case kernel code is being modified via
text_poke() in a kernel thread, and on another processor exit_mmap()
is active for the process which was running on the first cpu before
the kernel thread.

As text_poke() is using a temporary address space and the former
address space (obtained via cpu_tlbstate.loaded_mm) is restored
afterwards, there is a race possible in case the cpu on which
exit_mmap() is running wants to make sure there are no stale
references to that address space on any cpu active (this e.g. is
required when running as a Xen PV guest, where this problem has been
observed and analyzed).

In order to avoid that, drop off TLB lazy mode before switching to the
temporary address space.

Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201009144225.12019-1-jgross@suse.com
---
 arch/x86/kernel/alternative.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cdaab30..cd6be6f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	temp_mm_state_t temp_state;
 
 	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate.is_lazy))
+		leave_mm(smp_processor_id());
+
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
 

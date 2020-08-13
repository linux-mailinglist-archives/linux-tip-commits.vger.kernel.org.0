Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE92439AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Aug 2020 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMMPT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 Aug 2020 08:15:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMMPS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 Aug 2020 08:15:18 -0400
Date:   Thu, 13 Aug 2020 12:15:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597320916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKkEG/5K5y7F2Yw2IcGjRVzdQIU/oD6i7aVmBszFYnA=;
        b=xCWRXRnXiOoWcHAZcgC3/FjAuA1dycfTMIhZasTk/qcBKwmMxH7nI1DZXkefX3QX/TdCXZ
        2IMmjMZ5aZzMP5qr6jCzy6f+207Yk/97fhZTuSqo+To2FSKrwkAOYvwCPfPvdT7X1DWMNs
        r+UZBGfWpBPKLpSfmSBcvlqUEjEBfRXw+tsKw6z/HG1CZtLmbShA68BEjrj8idBI6DGbU2
        j1g2qQaaY/WcnhT8MaPW2bvAaFJsixNWjKmzdnIjwaBBztn2y7xeZchqXUCZ4B390cZbys
        tpKh4si6sQ+GoKXjkbb1Z2pxEFRka2z6ZUU0pG94nYLT6NEmJDPfb1MN95Q6TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597320916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKkEG/5K5y7F2Yw2IcGjRVzdQIU/oD6i7aVmBszFYnA=;
        b=q2GiVcQNMFken73bLIu8FQGR6L9R1cSiqjRyel5CyzEUDzb1HDaMhyJeqJqej35ZZSF6eu
        OaM5nwrNmy2MxADQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Acquire pte lock with interrupts enabled
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200813105026.bvugytmsso6muljw@linutronix.de>
References: <20200813105026.bvugytmsso6muljw@linutronix.de>
MIME-Version: 1.0
Message-ID: <159732091559.3192.7404769548939834518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a6d996cbd38b42341ad3fce74506b9fdc280e395
Gitweb:        https://git.kernel.org/tip/a6d996cbd38b42341ad3fce74506b9fdc280e395
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 13 Aug 2020 12:50:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Aug 2020 14:11:54 +02:00

x86/alternatives: Acquire pte lock with interrupts enabled

pte lock is never acquired in-IRQ context so it does not require interrupts
to be disabled. The lock is a regular spinlock which cannot be acquired
with interrupts disabled on RT.

RT complains about pte_lock() in __text_poke() because it's invoked after
disabling interrupts.

__text_poke() has to disable interrupts as use_temporary_mm() expects
interrupts to be off because it invokes switch_mm_irqs_off() and uses
per-CPU (current active mm) data.

Move the PTE lock handling outside the interrupt disabled region.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200813105026.bvugytmsso6muljw@linutronix.de

---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c826cdd..34a1b85 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -874,8 +874,6 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
 
-	local_irq_save(flags);
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -892,6 +890,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	VM_BUG_ON(!ptep);
 
+	local_irq_save(flags);
+
 	pte = mk_pte(pages[0], pgprot);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
 
@@ -941,8 +941,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
 
-	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
+	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }
 

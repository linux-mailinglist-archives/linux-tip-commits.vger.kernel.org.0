Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352837BB9C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhELLRQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 07:17:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELLRP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 07:17:15 -0400
Date:   Wed, 12 May 2021 11:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620818167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olAPH+qlTtRvDRw/5mnZHrpwcl+RHyE3lW+ASOFu8sQ=;
        b=2cBRX/VfeU/SXQLqXqEu8i9m9tP1P09bh3yVyAAozqDNop7GRtk626qbiCOgIhWN8pTOqV
        1KhLjY1bu9KFfdjCSsrUZREGzb0b+ibj5pAW+W9DhFDx9YnDMrTWjOa8xRLGp0dZUeIJV8
        vxjlfQPUKUNwWDS9c60yN4i7ooD1jnEgjbAgBtggi/f1lI+LmAOeJoTpbMfAOnqyMEF0bI
        Qe/xkpRa+KVyLCHkfug0uZv5IM7JvLLqbPxXW9diWAWyxRRGb+cX0XUDT93PZVnn4oFDMK
        rNy9nj9OyWmw+IzvaKcXGBFhc+hwkuX0jty9DdBO9LbHYlfLleqQBiuTOP/Nkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620818167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olAPH+qlTtRvDRw/5mnZHrpwcl+RHyE3lW+ASOFu8sQ=;
        b=SBLCO6AwZR/e+PY5OHuR0m5SN2qZGtFpty/kc4bcswc0XTZgbXTIwVlhzRp1YDIrm9XZuu
        OS6zA5+NjanqCvAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Simplify __smp_mb() definition
Cc:     Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512093310.5635-1-bp@alien8.de>
References: <20210512093310.5635-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <162081816620.29796.2497014508324890386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1bc67873d401e6c2e6e30be7fef21337db07a042
Gitweb:        https://git.kernel.org/tip/1bc67873d401e6c2e6e30be7fef21337db07a042
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 12 May 2021 11:33:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 12:22:57 +02:00

x86/asm: Simplify __smp_mb() definition

Drop the bitness ifdeffery in favor of using _ASM_SP,
which is the helper macro for the rSP register specification
for 32 and 64 bit depending on the build.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512093310.5635-1-bp@alien8.de
---
 arch/x86/include/asm/barrier.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 4819d5e..3ba772a 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -54,11 +54,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
 
-#ifdef CONFIG_X86_32
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
-#else
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
-#endif
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
+
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)

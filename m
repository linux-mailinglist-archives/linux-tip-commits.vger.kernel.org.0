Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7E45F5D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbhKZU2V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:28:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33302 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbhKZU0M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:12 -0500
Date:   Fri, 26 Nov 2021 20:22:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ci8CAmqtULssZpjLJuV6qAm+TNGLRK6r0nE+1ouyd0=;
        b=qtW59iuDWnauXCf6/sOgpePogbFMCIMN+pety2/chJyNRZ2qNw3vQEdJQdHl+pA0mdRjNu
        Fqu2h9Sw3yjpqo9EqHGu+cYzcY0xy+TWdKU0aSI0UMIyxKE67XIIqlKpAauHYCyUFjZyyO
        SwHqD9OyPelW9mVQ/a+QoHEjlO+sk+z3hEFDx5goVJBi1irQn7dl/7+9j9Z3aEh8EaO6Qw
        D49ZaE1OjwlnC+mGkd57vgcYGqvQx8l6x+tRGAXvVpHX8keufhEXlGenf/1crhNVtBhFhD
        tO2THSO1PnCqkSEtqkl/yRm3myEe42hG0lUeoeqGui3ef4tUPusK9JOn+s0csQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ci8CAmqtULssZpjLJuV6qAm+TNGLRK6r0nE+1ouyd0=;
        b=udpTGiYXBbw16oQhi8jzP+cxBxOCvJUNmw7Os2BZUF/K2Y0ru49BTkdg3a/IHvDQCqeBiA
        +7FNHDF6uw6z/8AQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] ARM: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-6-mark.rutland@arm.com>
References: <20211117163050.53986-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817763.11128.3056423618976237723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     3fe5dec062dfc8344356823457f5f43e0730c074
Gitweb:        https://git.kernel.org/tip/3fe5dec062dfc8344356823457f5f43e0730c074
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:43 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

ARM: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Link: https://lore.kernel.org/r/20211117163050.53986-6-mark.rutland@arm.com
---
 arch/arm/kernel/signal.c | 2 +-
 arch/arm/mm/alignment.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a41e27a..c532a60 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -631,7 +631,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index ea81e89..adbb381 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -990,7 +990,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * there is no work pending for this thread.
 		 */
 		raw_local_irq_disable();
-		if (!(current_thread_info()->flags & _TIF_WORK_MASK))
+		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
 	}
 

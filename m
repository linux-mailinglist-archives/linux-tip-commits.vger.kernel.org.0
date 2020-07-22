Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9B22A1B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbgGVWBN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 18:01:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgGVWBM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 18:01:12 -0400
Date:   Wed, 22 Jul 2020 22:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZqBD0H1LWlJxsQ61ALlfHIsDMsog0tR1YbzLAy24MU=;
        b=tMUtattnLiy/f81y1b9WlqyqgmeJCvL+wuy/O2YPg3jOSStlP6SzqdNXSGMqgPu3ik1jhI
        34k/04qha7opJcq0LWQHZAz9HmjzCHC39BGJnZ9UThwXzEODvaqWSDwjowkn2Kp3y+3L/M
        tprMQFhiXKlom/VI543UznhKGDLKm48yh/TXRHoQ/9wkONZIhPVHkK2gVNStexkEId+qEK
        i+zrNj6/JSr+SCMDoEojhSYC6vrRcDmKRwcupTPbI3CU4PuLsmuPI0efYHSF0RE6up1U+8
        LGU5JJrJjmNMXlzm/TDy+mWuDr/94vcn3z+t16naQ53JqlkBu84txBGpPJ1znw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZqBD0H1LWlJxsQ61ALlfHIsDMsog0tR1YbzLAy24MU=;
        b=ZCpyLTN2StsvsyvGJKpOHRg8gPsy1ExlMOWZnldTaXWI1YGAepurM6UpN+JoJQoITe/2iF
        5Lq4Uz/Wq3g7RJBw==
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/dumpstack: Add log_lvl to show_iret_regs()
Cc:     Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200629144847.492794-2-dima@arista.com>
References: <20200629144847.492794-2-dima@arista.com>
MIME-Version: 1.0
Message-ID: <159545526999.4006.11438373366826140681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fd07f802a70935fbbfb9cc2d11e1d8ac95f28e44
Gitweb:        https://git.kernel.org/tip/fd07f802a70935fbbfb9cc2d11e1d8ac95f28e44
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 29 Jun 2020 15:48:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:56:53 +02:00

x86/dumpstack: Add log_lvl to show_iret_regs()

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, there is a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

Add log_lvl parameter to show_iret_regs() as a preparation to add it
to __show_regs() and show_regs_if_on_stack().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20200629144847.492794-2-dima@arista.com

---
 arch/x86/include/asm/kdebug.h | 2 +-
 arch/x86/kernel/dumpstack.c   | 8 ++++----
 arch/x86/kernel/process_64.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 247ab14..da024bb 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -37,7 +37,7 @@ void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
 extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
-extern void show_iret_regs(struct pt_regs *regs);
+extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
 
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b037cfa..c36d629 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -126,10 +126,10 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 	show_opcodes(regs, loglvl);
 }
 
-void show_iret_regs(struct pt_regs *regs)
+void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 {
-	show_ip(regs, KERN_DEFAULT);
-	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
+	show_ip(regs, log_lvl);
+	printk("%sRSP: %04x:%016lx EFLAGS: %08lx", log_lvl, (int)regs->ss,
 		regs->sp, regs->flags);
 }
 
@@ -155,7 +155,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs);
+		show_iret_regs(regs, KERN_DEFAULT);
 	}
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415..09bcb29 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -69,7 +69,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	unsigned int fsindex, gsindex;
 	unsigned int ds, es;
 
-	show_iret_regs(regs);
+	show_iret_regs(regs, KERN_DEFAULT);
 
 	if (regs->orig_ax != -1)
 		pr_cont(" ORIG_RAX: %016lx\n", regs->orig_ax);

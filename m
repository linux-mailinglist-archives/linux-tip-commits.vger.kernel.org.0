Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0FFE6F9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKOVNM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:13:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfKOVMm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:42 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitR-0007Tb-UX; Fri, 15 Nov 2019 22:12:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C27731C18D8;
        Fri, 15 Nov 2019 22:12:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ptrace: Prevent truncation of bitmap size
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191113210103.819769574@linutronix.de>
References: <20191113210103.819769574@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385235077.12247.4923575564089714664.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     c5d623b17c2424272b3355a524b094ff02cfd9aa
Gitweb:        https://git.kernel.org/tip/c5d623b17c2424272b3355a524b094ff02cfd9aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:14:59 +01:00

x86/ptrace: Prevent truncation of bitmap size

The active() callback of the IO bitmap regset divides the IO bitmap size by
the word size (32/64 bit). As the I/O bitmap size is in bytes the active
check fails for bitmap sizes of 1-3 bytes on 32bit and 1-7 bytes on 64bit.

Use DIV_ROUND_UP() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210103.819769574@linutronix.de



---
 arch/x86/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 3c5bbe8..7c52674 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -697,7 +697,7 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
 static int ioperm_active(struct task_struct *target,
 			 const struct user_regset *regset)
 {
-	return target->thread.io_bitmap_max / regset->size;
+	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
 }
 
 static int ioperm_get(struct task_struct *target,

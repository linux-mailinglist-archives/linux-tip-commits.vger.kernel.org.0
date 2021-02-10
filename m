Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD7316D31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBJRr5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:47:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhBJRr2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:28 -0500
Date:   Wed, 10 Feb 2021 17:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlFRQdosrvSG4Z+z5xThNF8ZqFDl+f7i2Lkgl3Mz5+Y=;
        b=M97yjJs3EU93m2Nh+1Z86HLoQG5s8YJ31JoU6YatooJiEWa8E1u4Bc7JAWu+kbiebJ3DwC
        CoW/ndZgrscVjSr43KHnLpIiKT+RbWwjnwod1BLkaCgfCdqm+9r1vCEffGHVlRQIkLZ8xb
        3CoYkotWa6776vZy0TVWXGIOf87F8dYh23gVjT/L8tDKliFkSCU8HLENd6d+sk+SubMzvN
        T1UaybsHU+S8XBGe5009M+0Qjw71HyZAy+lZPe0Yqko76vJkQOaNw/gBPIVd6sVOwLsXQn
        P0jJW/AwW/S37aPwA9EuyWGI8ovEVaX0X6jC0Gp1c8jDhSY7J4cyu1mMBdMpMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlFRQdosrvSG4Z+z5xThNF8ZqFDl+f7i2Lkgl3Mz5+Y=;
        b=Z5d42dhzFz559Vj+YDCB+9G/KFmT2sEEYyu65BDYX9OOm8p6b7i0DRjs0C4dJSRql+y862
        gY7jYoLqa/RtiJBw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Improve kernel-executing-user-memory handling
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ab8719c7afb8bd501c4eee0e36493150fbbe5f6a.1612924255.git.luto@kernel.org>
References: <ab8719c7afb8bd501c4eee0e36493150fbbe5f6a.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915554.23325.425213946291884977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     03c81ea3331658f613bb2913d33764a4e0410cbd
Gitweb:        https://git.kernel.org/tip/03c81ea3331658f613bb2913d33764a4e0410cbd
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:39 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:20:54 +01:00

x86/fault: Improve kernel-executing-user-memory handling

Right now, the case of the kernel trying to execute from user memory
is treated more or less just like the kernel getting a page fault on a
user access. In the failure path, it checks for erratum #93, tries to
otherwise fix up the error, and then oopses.

If it manages to jump to the user address space, with or without SMEP,
it should not try to resolve the page fault. This is an error, pure and
simple. Rearrange the code so that this case is caught early, check for
erratum #93, and bail out.

 [ bp: Massage commit message. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/ab8719c7afb8bd501c4eee0e36493150fbbe5f6a.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b110484..cbb1a97 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -447,6 +447,9 @@ static int is_errata93(struct pt_regs *regs, unsigned long address)
 	    || boot_cpu_data.x86 != 0xf)
 		return 0;
 
+	if (user_mode(regs))
+		return 0;
+
 	if (address != regs->ip)
 		return 0;
 
@@ -744,9 +747,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-	if (is_errata93(regs, address))
-		return;
-
 	/*
 	 * Buggy firmware could access regions which might page fault, try to
 	 * recover from such faults.
@@ -1239,6 +1239,21 @@ void do_user_addr_fault(struct pt_regs *regs,
 	tsk = current;
 	mm = tsk->mm;
 
+	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) == X86_PF_INSTR)) {
+		/*
+		 * Whoops, this is kernel mode code trying to execute from
+		 * user memory.  Unless this is AMD erratum #93, which
+		 * corrupts RIP such that it looks like a user address,
+		 * this is unrecoverable.  Don't even try to look up the
+		 * VMA.
+		 */
+		if (is_errata93(regs, address))
+			return;
+
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
 	/* kprobes don't want to hook the spurious faults: */
 	if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
 		return;

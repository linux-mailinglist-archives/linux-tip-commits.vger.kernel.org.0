Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E511316D3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhBJRsM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:48:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Date:   Wed, 10 Feb 2021 17:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5cpuOmD8cEP353a6nVpYT84YVOvs1fELkcfNv/GQ/Y=;
        b=v7f5V6g6rT85iR0MQPXGyotwdato0cEgv3FxH/jBwVGzifA2wXxWYG4iw9+i1rrQrynA7q
        lWtwlv7aLA7Th2mACty1w9riPcESzLD3fyzAMFWS18sYQTSUkv0wypqlWV5QG4h8dpYbQU
        LF+PcJZvWgZolR9L2PSwBaI4rBx1uwRuJ2yLFD0ZaDgXcV230+CiUQ7ueHTaCDWCJNtr0a
        aVJ/V7q4GclOeaS5fZWETsOsO3y3UeJDlEbWmeogdN6w0TRajGykzGbTjwdQnQNG+w+JIh
        Mip8WiX01Jqhrk7/gwXijzvwcX5DGBPFiuQ7Mad1UR6o5L4h1jKfedCu1JcEkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5cpuOmD8cEP353a6nVpYT84YVOvs1fELkcfNv/GQ/Y=;
        b=SXpeCQrfe3RD2SMuABOMr1sKENDkJNLRAuBRh4VC4hn7ZigCyDLwFVf+kl8UlJ4YzN+YSl
        0DoBPWYfKsEcdECw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault/32: Move is_f00f_bug() to do_kern_addr_fault()
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e9668729a48ce6754022b0a4415631e8ebdd00e7.1612924255.git.luto@kernel.org>
References: <e9668729a48ce6754022b0a4415631e8ebdd00e7.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915621.23325.11879363405011117616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f42a40fd53fb5c77bae67d917d66078dbaa46bc2
Gitweb:        https://git.kernel.org/tip/f42a40fd53fb5c77bae67d917d66078dbaa46bc2
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:36 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:11:07 +01:00

x86/fault/32: Move is_f00f_bug() to do_kern_addr_fault()

bad_area() and its relatives are called from many places in fault.c, and
exactly one of them wants the F00F workaround.

__bad_area_nosemaphore() no longer contains any kernel fault code, which
prepares for further cleanups.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/e9668729a48ce6754022b0a4415631e8ebdd00e7.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 91cf7a6..3ffed00 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -482,10 +482,12 @@ static int is_errata100(struct pt_regs *regs, unsigned long address)
 }
 
 /* Pentium F0 0F C7 C8 bug workaround: */
-static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
+static int is_f00f_bug(struct pt_regs *regs, unsigned long error_code,
+		       unsigned long address)
 {
 #ifdef CONFIG_X86_F00F_BUG
-	if (boot_cpu_has_bug(X86_BUG_F00F) && idt_is_f00f_address(address)) {
+	if (boot_cpu_has_bug(X86_BUG_F00F) && !(error_code & X86_PF_USER) &&
+	    idt_is_f00f_address(address)) {
 		handle_invalid_op(regs);
 		return 1;
 	}
@@ -853,9 +855,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 	}
 
-	if (is_f00f_bug(regs, address))
-		return;
-
 	no_context(regs, error_code, address, SIGSEGV, si_code);
 }
 
@@ -1195,6 +1194,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	}
 #endif
 
+	if (is_f00f_bug(regs, hw_error_code, address))
+		return;
+
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;

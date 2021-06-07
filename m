Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8B39DC1F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jun 2021 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGMYO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Jun 2021 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Jun 2021 08:24:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461DEC061766;
        Mon,  7 Jun 2021 05:22:22 -0700 (PDT)
Date:   Mon, 07 Jun 2021 12:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623068540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxx0YVyuhLwmmQ+qv1rHzjwKlRvyEJBfZxyMGFIJ9Ro=;
        b=UqTst/zhHLMPguii70EYaSwr0zfug/H/bYjeU3APn8+dnjF4Jdh+e42PlYEUgQ6dYV6Hf6
        92c+Cbl+R48ieZguIG7zjNxlazD8yhR6duQsDOCvxRTDnqPXpKc4n41iOKV6jG5Jf/vD0n
        HS4YEJiqUNaa5sabeBEENpgEc+WMZG75uoPLLcz8Upjm6Y/bHPYinAEDM9pJ5KTnM/hF22
        Fd/hIOoWW1Yu1RykZSwmkit9klMhk+qGfOT37jEBggaSXo1QStrx/x6m94Ar1AGMx2kroi
        gZwXDOF/QU5LeM4AcO/dVeShYGFxrWvyzss35KrKo3kSDBoq4KP2f192QvBW1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623068540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxx0YVyuhLwmmQ+qv1rHzjwKlRvyEJBfZxyMGFIJ9Ro=;
        b=9EjMX86UYbbl7+jhDcPWKLqoC/WJg8DwCQF1rHQ+BMnbU3PLjDb0/HDjGKiJnfu2wMVHGP
        tpgOwoPKbriMIcAg==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/crash: Remove crash_reserve_low_1M()
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210601075354.5149-4-rppt@kernel.org>
References: <20210601075354.5149-4-rppt@kernel.org>
MIME-Version: 1.0
Message-ID: <162306853884.29796.12879946484223593923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     23721c8e92f73f9f89e7362c50c2996a5c9ad483
Gitweb:        https://git.kernel.org/tip/23721c8e92f73f9f89e7362c50c2996a5c9ad483
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 01 Jun 2021 10:53:54 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Jun 2021 12:14:45 +02:00

x86/crash: Remove crash_reserve_low_1M()

The entire memory range under 1M is unconditionally reserved in
setup_arch(), so there is no need for crash_reserve_low_1M() anymore.

Remove this function.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210601075354.5149-4-rppt@kernel.org
---
 arch/x86/include/asm/crash.h |  6 ------
 arch/x86/kernel/crash.c      | 13 -------------
 2 files changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index f58de66..8b6bd63 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -9,10 +9,4 @@ int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
 void crash_smp_send_stop(void);
 
-#ifdef CONFIG_KEXEC_CORE
-void __init crash_reserve_low_1M(void);
-#else
-static inline void __init crash_reserve_low_1M(void) { }
-#endif
-
 #endif /* _ASM_X86_CRASH_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 54ce999..e8326a8 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -70,19 +70,6 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
 	rcu_read_unlock();
 }
 
-/*
- * When the crashkernel option is specified, only use the low
- * 1M for the real mode trampoline.
- */
-void __init crash_reserve_low_1M(void)
-{
-	if (cmdline_find_option(boot_command_line, "crashkernel", NULL, 0) < 0)
-		return;
-
-	memblock_reserve(0, 1<<20);
-	pr_info("Reserving the low 1M of memory for crashkernel\n");
-}
-
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)

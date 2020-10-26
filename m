Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40520298D46
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772066AbgJZMxQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:53:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775647AbgJZMwh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:37 -0400
Date:   Mon, 26 Oct 2020 12:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i8S4VmJkahrkJHlUzRFlkFPLK4tmrxJPrfUuq6JmpU=;
        b=QTs4Z1Lcl8L37PdCGWKzFfw4gI739Rlzf3NfztfuU8WynowR+79oqm51RlBo+cs+iT1b1r
        MVE1oKNCap97FlCLuSt2duKa+WmG7C5dlDLF5lGQAL3pjE7PxZrGGYeB60J+XGBlCLpuaP
        uUGdCDfkS7xYYFjd10wHTcYiUeFKQ5wqYtYDUprTOyYNpA7uTaIfvnQnDmekDyMO1A8yEU
        3RRVjg4jfsPmle8e/n+vWb0iBSnsSzd/U7o58QAWJdn4xGEF1p3nDMNh8Y1x4Hklh/+W9H
        pA+EhCfLPqOQRW+eKWNypqtNIPQYdtoRxdu8M32QsQPGjXd+TaEsSB6+v82f6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i8S4VmJkahrkJHlUzRFlkFPLK4tmrxJPrfUuq6JmpU=;
        b=qNGLNgBZynIPXV2j1J1Y+s5mg4oiXj3bCWQLAINnBBMhTT3VZMP1l/x6r0wc/j/bNPbjef
        pm9kYHg1uIvAtWAQ==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/elf: Use e_machine to select start_thread for x32
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-7-krisman@collabora.com>
References: <20201004032536.1229030-7-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675483.397.13437948801906513925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2424b14605c71a7187c14edd525044eb36bdea47
Gitweb:        https://git.kernel.org/tip/2424b14605c71a7187c14edd525044eb36bdea47
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:32 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

x86/elf: Use e_machine to select start_thread for x32

Since TIF_X32 is going away, avoid using it to find the ELF type in
compat_start_thread.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when executing start_thread()
in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201004032536.1229030-7-krisman@collabora.com


---
 arch/x86/include/asm/elf.h   | 5 +++--
 arch/x86/kernel/process_64.c | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9220efc..109697a 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -186,8 +186,9 @@ static inline void elf_common_init(struct thread_struct *t,
 #define	COMPAT_ELF_PLAT_INIT(regs, load_addr)		\
 	elf_common_init(&current->thread, regs, __USER_DS)
 
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp);
-#define compat_start_thread compat_start_thread
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32);
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp, ex->e_machine == EM_X86_64)
 
 void set_personality_ia32(bool);
 #define COMPAT_SET_PERSONALITY(ex)			\
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index df342be..5fb4103 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -511,11 +511,10 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
 {
 	start_thread_common(regs, new_ip, new_sp,
-			    test_thread_flag(TIF_X32)
-			    ? __USER_CS : __USER32_CS,
+			    x32 ? __USER_CS : __USER32_CS,
 			    __USER_DS, __USER_DS);
 }
 #endif

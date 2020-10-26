Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C5298D37
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775681AbgJZMwl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775668AbgJZMwj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:39 -0400
Date:   Mon, 26 Oct 2020 12:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xrKcqz2UIwg/Q8cfRTWfEHLz8qfVeEVrJfwrDBxk8E=;
        b=IXmW3I6N6Go0MBOF16Yy/M22Rs+s/GOe+y98ZTFmVWdKGPcwOgR6OX/hbhEGqRn/NIAMAJ
        i9EvCUUb2g+abMf51Ul1xXaMF4n6UMSs+7wB/SlHVva3uh52QqfD603IC73N+KcAW7jEoQ
        C7HjQOfZwAvpjhlSpcYHHAByxjNFiCdlEbc+/kP0rW95KYH7/KsDi7/ifw1ajZ45e9xXh3
        CiIJxqxTyELe0r81T88T7+saJK6OUuQNufhYl/85idHgsu0BMRSbbXy2kO/pftBXWnz7b7
        CfhyDHj0M3Azvrca0fkdronbyw3hsJP0vNTolQ/nVjMWBnwSeXud9BgdjKdu6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xrKcqz2UIwg/Q8cfRTWfEHLz8qfVeEVrJfwrDBxk8E=;
        b=ETCvjm1eLcJQa16RhO1rlCLOB3YGujn/9nBVJeC3JSs8FMRsE5v78NIHxGdwS2lEOsaGCB
        ueYORWrpXE5E0wBg==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/compat: Simplify compat syscall userspace allocation
Cc:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-3-krisman@collabora.com>
References: <20201004032536.1229030-3-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675721.397.3164323953920306327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     214f0e804358cdd13b5cbe4445189f23e30618b4
Gitweb:        https://git.kernel.org/tip/214f0e804358cdd13b5cbe4445189f23e30618b4
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:28 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

x86/compat: Simplify compat syscall userspace allocation

When allocating user memory space for a compat system call, don't consider
whether the originating code is IA32 or X32, just allocate from a safe
region for both, beyond the redzone.  This should be safe for IA32, and has
the benefit of avoiding TIF_IA32, which is about to be removed.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-3-krisman@collabora.com

---
 arch/x86/include/asm/compat.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 0e327a0..f145e33 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -177,14 +177,13 @@ typedef struct user_regs_struct compat_elf_gregset_t;
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
-	compat_uptr_t sp;
-
-	if (test_thread_flag(TIF_IA32)) {
-		sp = task_pt_regs(current)->sp;
-	} else {
-		/* -128 for the x32 ABI redzone */
-		sp = task_pt_regs(current)->sp - 128;
-	}
+	compat_uptr_t sp = task_pt_regs(current)->sp;
+
+	/*
+	 * -128 for the x32 ABI redzone.  For IA32, it is not strictly
+	 * necessary, but not harmful.
+	 */
+	sp -= 128;
 
 	return (void __user *)round_down(sp - len, 16);
 }

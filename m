Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4C298D42
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775679AbgJZMwl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773153AbgJZMwj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:39 -0400
Date:   Mon, 26 Oct 2020 12:52:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fb9+gjwENfRPWJUTHHuvHRxj5wYQesZR3Xa4pqv6mps=;
        b=zc0oGSBYswlF5B9zrfQYQwWzKVP1qGFxbXefLkza7Rw09d+eWB0NjZTMnoY8OaUUoLnhHP
        SmB3m+s+YcoZnWSnpQOr7mecwUXFYu5iuwQr+SsFGIgA7mkO9sIdp+rybHWjnIoL+YXa18
        fQy2t4RSS5cY9B2/U9Gl9jq5ZNXRC/qH77VNxwVeD0ZY9HOYvCMUlrAbk2gnYs1554D+PF
        zHW/+RxT4GZ1NCmEzvheSLkn7Bs0W7KbUSpQwlvL9fc1Q6R131pD1Jc/5x1PS+FInX92xP
        ek+JKeU+uOkDYLmHDJYmBOzLiZId9MASshpLhtUSfWD1b+vlsa44pSNCRfE2pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fb9+gjwENfRPWJUTHHuvHRxj5wYQesZR3Xa4pqv6mps=;
        b=IeQroH/OMF/0E+Wm8HTTvk9YBDGF3D+UJowvByV7otrOqLzIAdZHMJ6zR8N35hHDn0Wkya
        38FK6FOojlH04uCw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] elf: Expose ELF header in compat_start_thread()
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-6-krisman@collabora.com>
References: <20201004032536.1229030-6-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675542.397.5183477135451020077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bc3d7bf61a9eaecccc84dc2ecc2a9a3fa4f5ec47
Gitweb:        https://git.kernel.org/tip/bc3d7bf61a9eaecccc84dc2ecc2a9a3fa4f5ec47
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:31 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

elf: Expose ELF header in compat_start_thread()

Like it is done for SET_PERSONALITY with x86, which requires the ELF header
to select correct personality parameters, x86 requires the headers on
compat_start_thread() to choose starting CS for ELF32 binaries, instead of
relying on the going-away TIF_IA32/X32 flags.

Add an indirection macro to ELF invocations of START_THREAD, that x86 can
reimplement to receive the extra parameter just for ELF files.  This
requires no changes to other architectures who don't need the header
information, they can continue to use the original start_thread for ELF and
non-ELF binaries, and it prevents affecting non-ELF code paths for x86.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-6-krisman@collabora.com

---
 fs/binfmt_elf.c        |  2 +-
 fs/compat_binfmt_elf.c |  9 +++++++--
 include/linux/elf.h    |  5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b6b3d05..b23f755 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1307,7 +1307,7 @@ out_free_interp:
 #endif
 
 	finalize_exec(bprm);
-	start_thread(regs, elf_entry, bprm->p);
+	START_THREAD(elf_ex, regs, elf_entry, bprm->p);
 	retval = 0;
 out:
 	return retval;
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 2d24c76..12b9913 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -106,8 +106,13 @@
 #endif
 
 #ifdef	compat_start_thread
-#undef	start_thread
-#define	start_thread		compat_start_thread
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp)
+#endif
+
+#ifdef	COMPAT_START_THREAD
+#undef	START_THREAD
+#define START_THREAD		COMPAT_START_THREAD
 #endif
 
 #ifdef	compat_arch_setup_additional_pages
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5d5b032..6dbcfe7 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -22,6 +22,11 @@
 	SET_PERSONALITY(ex)
 #endif
 
+#ifndef START_THREAD
+#define START_THREAD(elf_ex, regs, elf_entry, start_stack)	\
+	start_thread(regs, elf_entry, start_stack)
+#endif
+
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 

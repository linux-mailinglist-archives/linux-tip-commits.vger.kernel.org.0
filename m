Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AB298D47
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773232AbgJZMxR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:53:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775645AbgJZMwh (ORCPT
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
        bh=+ucx2XDwRjlh5JkD6w0gCnJGAUjalx/nAoD9UnfnH5o=;
        b=iTcmv8iOmJv/pKl7anjx/+sAHh4v1aUCvIV+9jEkmc+iGv3ogWWOFADU1sIOwIilLZvkPr
        YygOE9tS46+NmYBpRQ/dyLeQA5Qrb9lmJlkvf62cWl5u+3XySxjc/ewaEx6a/bUu//ad6i
        ds3fDfpMIDd3KOI9AvajnEHog7+tgVKgfboBIcHBL0/oZzSY5xb+GTY0kneK3d4rmy9FbD
        N0C1oRhaEbMin5NIr92iW8xD/3vRUkvie+oqKl4slB61maFz+umSU5fhWSiaYCz4sO3Qby
        yjXLEMlWuIUCOCqQ2+sD54LZ/SqUgWFMCIluwhe397P1IHfLUSBX+fcbUvGYkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ucx2XDwRjlh5JkD6w0gCnJGAUjalx/nAoD9UnfnH5o=;
        b=PlqUJJfiWLN6GubJqiCZ2dOZhBxsUzYtzrXptvAu0uJlYAtllULkwNZ1kACeeQBnBOSKlw
        Uisb+F+sVk70XnDA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] elf: Expose ELF header on arch_setup_additional_pages()
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-8-krisman@collabora.com>
References: <20201004032536.1229030-8-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675422.397.2436396266153701102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     9a29a671902c2be05d636045a4dd365219ca716c
Gitweb:        https://git.kernel.org/tip/9a29a671902c2be05d636045a4dd365219ca716c
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:33 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:47 +01:00

elf: Expose ELF header on arch_setup_additional_pages()

Like it is done for SET_PERSONALITY with ARM, which requires the ELF
header to select correct personality parameters, x86 requires the
headers when selecting which VDSO to load, instead of relying on the
going-away TIF_IA32/X32 flags.

Add an indirection macro to arch_setup_additional_pages(), that x86 can
reimplement to receive the extra parameter just for ELF files.  This
requires no changes to other architectures, who can continue to use the
original arch_setup_additional_pages for ELF and non-ELF binaries.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-8-krisman@collabora.com

---
 fs/binfmt_elf.c        |  2 +-
 fs/compat_binfmt_elf.c | 11 ++++++++---
 include/linux/elf.h    |  5 +++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b23f755..aabc11f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1246,7 +1246,7 @@ out_free_interp:
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, !!interpreter);
+	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 12b9913..2c55722 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -115,11 +115,16 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef	compat_arch_setup_additional_pages
+#ifdef compat_arch_setup_additional_pages
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	compat_arch_setup_additional_pages(bprm, interpreter)
+#endif
+
+#ifdef	COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-#undef	arch_setup_additional_pages
-#define	arch_setup_additional_pages compat_arch_setup_additional_pages
+#undef	ARCH_SETUP_ADDITIONAL_PAGES
+#define	ARCH_SETUP_ADDITIONAL_PAGES COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #endif
 
 #ifdef	compat_elf_read_implies_exec
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 6dbcfe7..c9a46c4 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -27,6 +27,11 @@
 	start_thread(regs, elf_entry, start_stack)
 #endif
 
+#if defined(ARCH_HAS_SETUP_ADDITIONAL_PAGES) && !defined(ARCH_SETUP_ADDITIONAL_PAGES)
+#define ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	arch_setup_additional_pages(bprm, interpreter)
+#endif
+
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD782298D4C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775763AbgJZMx1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:53:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775644AbgJZMwh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:37 -0400
Date:   Mon, 26 Oct 2020 12:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWja56kiyleHUM5SBKQ0/ST78s6JhvG0FAk3yFd43Q0=;
        b=1mHkQ6wsDG/VsYhtCjQXOkzh8alb4qGrZ+UE8zKM/14hbWedPwoVZdoKIc/q/hZkh+tOrw
        vm88HOwVIv96Zxw9tvALsCzhhQLzdyqlqtdnVKXGiiE/3D1iRjdsUdErRHwXlBHydal36V
        RShMuL7+b5CjgqzLJA9O/mirPWAMp+SauXMnY0+Wv/wfjodAeNgfg3q/rK+c6gC2nopbHj
        vibufq7gf5+htE10OZIqHvYGpQw6qFh6Z5k9IOazzbkNm5wlZf35vK8wwvQjT+zT63JrxH
        /e9HG50te50BAOCLOFsKcHvfqqVULCFTRCvVxhpfn17r5oV6z7YcLbxwXKHGoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWja56kiyleHUM5SBKQ0/ST78s6JhvG0FAk3yFd43Q0=;
        b=8UdOZwM3GxM7IFbCbM8m19D5OKN9pV2+8JNBUmujVmJ9PD3CgxWmWpPgR0RySc9n1k9PwB
        RBJwRar7aPN0vlDA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/elf: Use e_machine to check for x32/ia32 in
 setup_additional_pages()
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-9-krisman@collabora.com>
References: <20201004032536.1229030-9-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675357.397.304357916170024051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3316ec8ccd34e19690a12e65801d605d25155031
Gitweb:        https://git.kernel.org/tip/3316ec8ccd34e19690a12e65801d605d25155031
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:34 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:47 +01:00

x86/elf: Use e_machine to check for x32/ia32 in setup_additional_pages()

Since TIF_X32 is going away, avoid using it to find the ELF type when
choosing which additional pages to set up.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when executing
setup_additional_pages() in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-9-krisman@collabora.com


---
 arch/x86/entry/vdso/vma.c  | 4 ++--
 arch/x86/include/asm/elf.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1..50e5d3a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -413,10 +413,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
+				       int uses_interp, bool x32)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (test_thread_flag(TIF_X32)) {
+	if (x32) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 109697a..44a9b99 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -383,8 +383,10 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
+					      int uses_interp, bool x32);
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter)	\
+	compat_arch_setup_additional_pages(bprm, interpreter,		\
+					   (ex->e_machine == EM_X86_64))
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {

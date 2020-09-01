Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4A259159
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgIAOtv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 10:49:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgIALs1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agpKXEn4IiVG0idalDrSysa9oc+oy3SJpMth1in+B6A=;
        b=u7zu40ZA/e6dXI/wSYWJzFGW1T4yvb9cBm+oFRIA8GyNVVGCL5SX7YzsIjAu5ATQse++o4
        i+cLn9gliA0uVcXbCVeI4U+qeRC+u9a6x/H95C7Dk9KYOefQ/6M5tJPKXuLWNck+bWQ+PX
        H+kS1sdgQ+KW+pnzZFcLAAadh5ylRq2WieUxYFDz7snPy7dxl6NObLgpCNbgybcPj/WMov
        9KfotLKknteM+GddCWACmNIw5lcAfDEBirNdUtPv7Npvl1vcasaSQj799cY6ooGydzSLHF
        OkH+rvMtLNCoA+FhaVjCDjS40FiwAI0nhczFVGSHK3xSt21ruQ43eUh31UuHYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agpKXEn4IiVG0idalDrSysa9oc+oy3SJpMth1in+B6A=;
        b=InbigVtayoX2HWBQhqXki/dlnb2XS1q7Ld8luRmPJLEL8ZKR3uMCoL6tbgEP15pmJQzg6u
        muv4I2RaWzJM1xBg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm64/build: Remove .eh_frame* sections due to
 unwind tables
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-11-keescook@chromium.org>
References: <20200821194310.3089815-11-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087788.20229.17729780848112883247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     6e0a66d10c5b629369afa47b753d0ec46fa812dd
Gitweb:        https://git.kernel.org/tip/6e0a66d10c5b629369afa47b753d0ec46fa812dd
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

arm64/build: Remove .eh_frame* sections due to unwind tables

Avoid .eh_frame* section generation by making sure both CFLAGS and AFLAGS
contain -fno-asychronous-unwind-tables and -fno-unwind-tables.

With all sources of .eh_frame now removed from the build, drop this
DISCARD so we can be alerted in the future if it returns unexpectedly
once orphan section warnings have been enabled.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-11-keescook@chromium.org
---
 arch/arm64/Makefile             | 5 ++++-
 arch/arm64/kernel/vmlinux.lds.S | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 55bc854..6de7f55 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -47,13 +47,16 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+# Avoid generating .eh_frame* sections.
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 13fc2ec..c2b8426 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,6 @@ SECTIONS
 		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;

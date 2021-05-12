Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121637EDE9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhELU4L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:56:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbhELUDM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 16:03:12 -0400
Date:   Wed, 12 May 2021 20:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620849718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/V9aEsB43cbF4t2F9zaMqNCddYN4IhNJZgI8qZxTeg=;
        b=asswfMdNdSVS+9bYR9QIQ+bofHXcC8ETU5yUnL8dr7yBiQSGLsjnkOkMU/8kmMQgUVC0NK
        WDi6Zghh4EGKBOiSFHGVFCAcvyJ7YqZTy+yZQJa7h/QJXHcHvB8RPaq/wKFIxl90OEszC6
        vwY+B+pM15o0AH2KQCO+3Y12b6jvkQA+Knoz3TH3z01shPuHww6LHCuX1MZ0aK/dNpyNlN
        cxBEn14AKLsRpsP31b8lf3MYD8T5jagyRbNjgr3CEW7+vhjIxbFg9ozB5bo2fKR923SHh+
        8QA11a5aomz6xo0x+H9IuHeUBHgmJDy0JduodV4mSuQbUDI1+dDKmrpfFoXK/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620849718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/V9aEsB43cbF4t2F9zaMqNCddYN4IhNJZgI8qZxTeg=;
        b=Mgqn3p5i1WSgEqeR1d6eoxFqLWdUOuFv+xWab/KBbv6vZ+Sw8N0ixA+JzsxUs0QAFdq59m
        P/WqdjzGrvwzYoBw==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/compressed: Enable -Wundef
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422190450.3903999-1-ndesaulniers@google.com>
References: <20210422190450.3903999-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <162084971815.29796.8567480635740299918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a554e740b66a83c7560b30e6b50bece37555ced3
Gitweb:        https://git.kernel.org/tip/a554e740b66a83c7560b30e6b50bece37555ced3
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Thu, 22 Apr 2021 12:04:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 21:39:56 +02:00

x86/boot/compressed: Enable -Wundef

A discussion around -Wundef showed that there were still a few boolean
Kconfigs where #if was used rather than #ifdef to guard different code.
Kconfig doesn't define boolean configs, which can result in -Wundef
warnings.

arch/x86/boot/compressed/Makefile resets the CFLAGS used for this
directory, and doesn't re-enable -Wundef as the top level Makefile does.
If re-added, with RANDOMIZE_BASE and X86_NEED_RELOCS disabled, the
following warnings are visible.

  arch/x86/boot/compressed/misc.h:82:5: warning: 'CONFIG_RANDOMIZE_BASE'
  is not defined, evaluates to 0 [-Wundef]
      ^
  arch/x86/boot/compressed/misc.c:175:5: warning: 'CONFIG_X86_NEED_RELOCS'
  is not defined, evaluates to 0 [-Wundef]
      ^

Simply fix these and re-enable this warning for this directory.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20210422190450.3903999-1-ndesaulniers@google.com
---
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/boot/compressed/misc.c   | 2 +-
 arch/x86/boot/compressed/misc.h   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 2a29752..431bf7f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -30,6 +30,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 
 KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
+KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index dde042f..743f13e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -172,7 +172,7 @@ void __puthex(unsigned long value)
 	}
 }
 
-#if CONFIG_X86_NEED_RELOCS
+#ifdef CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
 {
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index e5612f0..3113925 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -79,7 +79,7 @@ struct mem_vector {
 	u64 size;
 };
 
-#if CONFIG_RANDOMIZE_BASE
+#ifdef CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
 void choose_random_location(unsigned long input,
 			    unsigned long input_size,

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC2CA885
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLAQoX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLAQoX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 11:44:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A1C0613D6;
        Tue,  1 Dec 2020 08:43:42 -0800 (PST)
Date:   Tue, 01 Dec 2020 16:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606841020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btGQfODE28DUIErTFVGy4pmvPQAjXfts3GLmmIUzGq0=;
        b=PlyeYe3uRqRGqZ0ZX6PrTrmeNhcvjyrsIvUqo0An6kwIGtPRQ44qU5MOTNHdlH27OU2Z8p
        /ux4fScCtC+Z8aW3B0W4k3DuRtxVQjttgch/xktpO8pnrKh1rh85UxPffecaP+RgnGbouk
        BddHiOg4JK30XcUv+6/+nom3AVCMPvIC4I8JhMb831mmKPY5S02PoaCT7AVrMk5pYWeVHi
        AhgSTj+NbQUWpKZ4ECnUWWICCWrjOF1pfGyXcq8UMcFQfIth+WEkNV1yvu+hz9GjdahR+M
        4KS7zMWvgi88dlGKBjV4J7VV71JegApqdAnEZxUpM1WjRgyDg4d8mlrPXQb1DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606841020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btGQfODE28DUIErTFVGy4pmvPQAjXfts3GLmmIUzGq0=;
        b=cUfEDpYuubBUEqRLeIblDCKZkFZsDvBvdyntEOxCgQz3LZjsqeXm98d8SgiowTM8fbPv8S
        5JbzpMsKGqXM3rBQ==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove -m16 workaround for unsupported
 versions of GCC
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201011307.3676986-1-ndesaulniers@google.com>
References: <20201201011307.3676986-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <160684101976.3364.7563855323822414041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     2838307b019dfec0c309c4e8e589658736cff4c9
Gitweb:        https://git.kernel.org/tip/2838307b019dfec0c309c4e8e589658736cff4c9
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Mon, 30 Nov 2020 17:13:06 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 17:17:18 +01:00

x86/build: Remove -m16 workaround for unsupported versions of GCC

Revert the following two commits:

  de3accdaec88 ("x86, build: Build 16-bit code with -m16 where possible")
  a9cfccee6604 ("x86, build: Change code16gcc.h from a C header to an assembly header")

Since

  0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")

the minimum supported version of GCC is gcc-4.9. It's now safe to remove
this code.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20201201011307.3676986-1-ndesaulniers@google.com
---
 arch/x86/Makefile         |  9 +--------
 arch/x86/boot/code16gcc.h | 12 ------------
 2 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 arch/x86/boot/code16gcc.h

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 154259f..b891066 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,14 +24,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-#
-# The -m16 option is supported by GCC >= 4.9 and clang >= 3.5. For
-# older versions of GCC, include an *assembly* header to make sure that
-# gcc doesn't play any games behind our back.
-CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
-M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
-
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
diff --git a/arch/x86/boot/code16gcc.h b/arch/x86/boot/code16gcc.h
deleted file mode 100644
index e19fd75..0000000
--- a/arch/x86/boot/code16gcc.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#
-# code16gcc.h
-#
-# This file is added to the assembler via -Wa when compiling 16-bit C code.
-# This is done this way instead via asm() to make sure gcc does not reorder
-# things around us.
-#
-# gcc 4.9+ has a real -m16 option so we can drop this hack long term.
-#
-
-	.code16gcc

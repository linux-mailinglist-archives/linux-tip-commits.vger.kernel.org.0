Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB07244BF4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Aug 2020 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHNPXr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 Aug 2020 11:23:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgHNPXm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:42 -0400
Date:   Fri, 14 Aug 2020 15:23:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vLJ7TelhyywHQuMOIEtO5DZQcPxefGeRPZ74uJTr4E=;
        b=oI/Ymv4bGnustLAd5Ig/xh/42I7jnrNRCSJ58XG5DYXWbs50nk7uEv7CiL0nIGnhy27VL7
        JxDPWtSKVftQ7BhNO7KcUB/pEorhAfkfISU5yPBDb0F5DsUnz/Ix0nfe2o6lTwGzRlszZS
        WEySxo57POXohNlQaO36j/zVi3ZDkPXCCZV8J/ekIG+EGQa8C5MVab0N8JqLMT58L3YgkP
        e4lxRsDXCXnLoddfEs0lTom4QRhR/jtRWr4D5Orlz6me9xIVNwv+3Gj+gW7tEn5NNGeLUm
        YpMPx0u6EJLxn+JBdr3G2zB4XvX4M3qDOp/JaxGp8suDZ1aHjmTpnVj2GmRD8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vLJ7TelhyywHQuMOIEtO5DZQcPxefGeRPZ74uJTr4E=;
        b=93BZZ0MHd8xu4PKP/zQUHvM84Citagq0GjGubeY7B21PIIe0RuiNvMMQHpTeXwdB2s6m8M
        R1SfY3DTCbUPtbCg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add .text.* to setup.ld
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200731230820.1742553-5-keescook@chromium.org>
References: <20200731230820.1742553-5-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159741861953.3192.3137984902389145756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2e7a858ba843d2e6ceab1ba996805411de51b340
Gitweb:        https://git.kernel.org/tip/2e7a858ba843d2e6ceab1ba996805411de51b340
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 31 Jul 2020 16:07:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:52:35 +02:00

x86/boot: Add .text.* to setup.ld

GCC puts the main function into .text.startup when compiled with -Os (or
-O2). This results in arch/x86/boot/main.c having a .text.startup
section which is currently not included explicitly in the linker script
setup.ld in the same directory.

The BFD linker places this orphan section immediately after .text, so
this still works. However, LLD git, since [1], is choosing to place it
immediately after the .bstext section instead (this is the first code
section). This plays havoc with the section layout that setup.elf
requires to create the setup header, for eg on 64-bit:

    LD      arch/x86/boot/setup.elf
  ld.lld: error: section .text.startup file range overlaps with .header
  >>> .text.startup range is [0x200040, 0x2001FE]
  >>> .header range is [0x2001EF, 0x20026B]

  ld.lld: error: section .header file range overlaps with .bsdata
  >>> .header range is [0x2001EF, 0x20026B]
  >>> .bsdata range is [0x2001FF, 0x200398]

  ld.lld: error: section .bsdata file range overlaps with .entrytext
  >>> .bsdata range is [0x2001FF, 0x200398]
  >>> .entrytext range is [0x20026C, 0x2002D3]

  ld.lld: error: section .text.startup virtual address range overlaps
  with .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header virtual address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata virtual address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

  ld.lld: error: section .text.startup load address range overlaps with
  .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header load address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata load address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

Add .text.* to the .text output section to fix this, and also prevent
any future surprises if the compiler decides to create other such
sections.

[1] https://reviews.llvm.org/D75225

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Link: https://lore.kernel.org/r/20200731230820.1742553-5-keescook@chromium.org
---
 arch/x86/boot/setup.ld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 24c9552..49546c2 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -20,7 +20,7 @@ SECTIONS
 	.initdata	: { *(.initdata) }
 	__end_init = .;
 
-	.text		: { *(.text) }
+	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
 	. = ALIGN(16);

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83434A7DD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Mar 2021 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCZNOE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Mar 2021 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhCZNNf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Mar 2021 09:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3172C0613B2;
        Fri, 26 Mar 2021 06:13:34 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616764410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63YzANuQRTf+cDDDZMxLNebYrOE9ADL/goF+NOFEpls=;
        b=KCf9EyNBzuUYA9vgQYLKNbUAsspR+a6seajAWfBPi01dyURxqIf/v5hYCgOHJJ1j0r7GRn
        H5HlLG03JRHjI4FVT3SMvR2Eoh02lbqyG0hOGvY4fmJ6EJWxHeZt7yM0324NaAnlij90NV
        6wFMY4j1NagdKQVtU+9oGR5TgmYbNHARIrm7g6w/gpWBsGcmoeO4hB7+2T9WriKxtuiQr9
        QSVMJ0T6ckaQRu9fMUYIfWbkZfsokif6uUJ9ZkqkZ+//AH2E44vFW3r7/C2SxKUJPoClr0
        nCcAaY3MqJSfefEMDs6OzQP3RFsXhtbYcQOCjJo4K4Iyu/P6NPBtf7UK5iqj0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616764410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63YzANuQRTf+cDDDZMxLNebYrOE9ADL/goF+NOFEpls=;
        b=R23EtaFjrj8H4IQG/Tx3QFmQ9kN5AF8tW7z2YRvA3zwDMxCVLMAuf8f7JWTTWkqwBKR1FK
        iC0zGNXsDWjY/xBg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] efi/libstub: Add $(CLANG_FLAGS) to x86 flags
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326000435.4785-4-nathan@kernel.org>
References: <20210326000435.4785-4-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <161676441002.398.18130314069263758283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     58d746c119dfa28e72fc35aacaf3d2a3ac625cd0
Gitweb:        https://git.kernel.org/tip/58d746c119dfa28e72fc35aacaf3d2a3ac625cd0
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 25 Mar 2021 17:04:35 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Mar 2021 11:34:58 +01:00

efi/libstub: Add $(CLANG_FLAGS) to x86 flags

When cross compiling x86 on an ARM machine with clang, there are several
errors along the lines of:

  arch/x86/include/asm/page_64.h:52:7: error: invalid output constraint '=D' in asm

This happens because the x86 flags in the EFI stub are not derived from
KBUILD_CFLAGS like the other architectures are and the clang flags that
set the target architecture ('--target=') and the path to the GNU cross
tools ('--prefix=') are not present, meaning that the host architecture
is targeted.

These flags are available as $(CLANG_FLAGS) from the main Makefile so
add them to the cflags for x86 so that cross compiling works as expected.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20210326000435.4785-4-nathan@kernel.org
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c23466e..d053757 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
-				   -fno-asynchronous-unwind-tables
+				   -fno-asynchronous-unwind-tables \
+				   $(CLANG_FLAGS)
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin

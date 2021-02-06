Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC71311D43
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Feb 2021 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBFM50 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Feb 2021 07:57:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBFM5M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Feb 2021 07:57:12 -0500
Date:   Sat, 06 Feb 2021 12:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612616182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2di6FPuLkHz2k4bwi3Z9U6bVN1xW/5AYBB4VCGepUI=;
        b=ZP0O57l8rOaA/nxSbO3pbTJcomx40aR4XNqGBzeEuqxEuXVe6/fFRmvOux1xaONJuc1Ogs
        4Tc/2g7/AvrEuAIjTdXP5AxZLVVqA6QqVGnf3IokvuAwQ2HroWYhr081NZxnvVbf+5dZ07
        y82rfKUy5N7JOxl0IbJdmlDEBMM+StUBVAzbbUusSpnKtFzmb2BiMNUs2sSVMLNNLkWJe9
        FEbw2Zh2UArcGLSumEmBf+OldBOYwLHj1Bjp+n0ES78/69A38cotJD761DQhRmL3+InSD/
        ntSnwm7imPYL9LwmhcF16Y/W0g46jOMEjJpjy2ZFcDkwWfKnxVILd88c8J3p6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612616182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2di6FPuLkHz2k4bwi3Z9U6bVN1xW/5AYBB4VCGepUI=;
        b=PzEQG1m1m+ZycG3wSQ/IHizjeVXdQfMfTsf8CtqASp9QHomoa8O0O5iIprOVmRap9UgOOu
        QLtSa2K1lxy98yDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/efi: Remove EFI PGD build time checks
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210107223424.4135538-1-arnd@kernel.org>
References: <20210107223424.4135538-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161261618116.23325.7532441736961791743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     816ef8d7a2c4182e19bc06ab65751cb9e3951e94
Gitweb:        https://git.kernel.org/tip/816ef8d7a2c4182e19bc06ab65751cb9e3951e94
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 05 Feb 2021 11:31:31 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Feb 2021 13:54:14 +01:00

x86/efi: Remove EFI PGD build time checks

With CONFIG_X86_5LEVEL, CONFIG_UBSAN and CONFIG_UBSAN_UNSIGNED_OVERFLOW
enabled, clang fails the build with

  x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
  efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'

which happens due to -fsanitize=unsigned-integer-overflow being enabled:

  -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
  the result of an unsigned integer computation cannot be represented
  in its type. Unlike signed integer overflow, this is not undefined
  behavior, but it is often unintentional. This sanitizer does not check
  for lossy implicit conversions performed before such a computation
  (see -fsanitize=implicit-conversion).

and that fires when the (intentional) EFI_VA_START/END defines overflow
an unsigned long, leading to the assertion expressions not getting
optimized away (on GCC they do)...

However, those checks are superfluous: the runtime services mapping
code already makes sure the ranges don't overshoot EFI_VA_END as the
EFI mapping range is hardcoded. On each runtime services call, it is
switched to the EFI-specific PGD and even if mappings manage to escape
that last PGD, this won't remain unnoticed for long.

So rip them out.

See https://github.com/ClangBuiltLinux/linux/issues/256 for more info.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: http://lkml.kernel.org/r/20210107223424.4135538-1-arnd@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e1e8d4e..8efd003 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -115,31 +115,12 @@ void efi_sync_low_kernel_mappings(void)
 	pud_t *pud_k, *pud_efi;
 	pgd_t *efi_pgd = efi_mm.pgd;
 
-	/*
-	 * We can share all PGD entries apart from the one entry that
-	 * covers the EFI runtime mapping space.
-	 *
-	 * Make sure the EFI runtime region mappings are guaranteed to
-	 * only span a single PGD entry and that the entry also maps
-	 * other important kernel regions.
-	 */
-	MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
-	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
-			(EFI_VA_END & PGDIR_MASK));
-
 	pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
 	pgd_k = pgd_offset_k(PAGE_OFFSET);
 
 	num_entries = pgd_index(EFI_VA_END) - pgd_index(PAGE_OFFSET);
 	memcpy(pgd_efi, pgd_k, sizeof(pgd_t) * num_entries);
 
-	/*
-	 * As with PGDs, we share all P4D entries apart from the one entry
-	 * that covers the EFI runtime mapping space.
-	 */
-	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
-	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
-
 	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
 	pgd_k = pgd_offset_k(EFI_VA_END);
 	p4d_efi = p4d_offset(pgd_efi, 0);

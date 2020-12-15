Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE32DABEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Dec 2020 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgLOLRw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Dec 2020 06:17:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgLOLRo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Dec 2020 06:17:44 -0500
Date:   Tue, 15 Dec 2020 11:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MpyIXaK+b1rJpecWsrCC9CPpp+ydTqJB20Ntb2Sirk=;
        b=qQbC+8hjCgNJWCO07kBhWH+mebw2a8wNus1R0x4RFJrE1djjUeQsD3tdcrMVcRqN6R1Afl
        nd4IMQbMf/v4JCMzEz3mqfy8pfCdpnHvHg0pTXWEu5zzrUurp/7f2SjIUVFtvnazzh0ooR
        V5N+oEHhuerxaII76MTCK5yWQxBlUGOYslgkfXc9IXOt9ulGKTjVMWjROmm4UHk5GF2g8A
        i6SGMEiX1t5sb/0JNNWc2flYSSR8FEUr1fXeZsC1mA7WgfH3VklzS+M8E5T2JH++ewwW5X
        0OcUGMb++vSYLVr/3L+kfNB72lCzHN5rRomnZQLU/swSwSq/HlVgZuoJb9qbeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MpyIXaK+b1rJpecWsrCC9CPpp+ydTqJB20Ntb2Sirk=;
        b=0tIYLFKRpRVjhLcYLCaY7NiHmLjhWzcf6TMm4qpCc7jE2wwpsApr5ir4XpMrG/MVPFhn9F
        MPR4b4a9h+CcaODQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: arm: force use of unsigned type for EFI_PHYS_ALIGN
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201213151306.73558-1-ardb@kernel.org>
References: <20201213151306.73558-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <160803102131.3364.9294561344291532942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     d72c8b0e1cacc39495cd413433d260e8ae59374a
Gitweb:        https://git.kernel.org/tip/d72c8b0e1cacc39495cd413433d260e8ae59374a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 13 Dec 2020 16:07:03 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 14 Dec 2020 16:25:06 +01:00

efi: arm: force use of unsigned type for EFI_PHYS_ALIGN

Ensure that EFI_PHYS_ALIGN is an unsigned type, to prevent spurious
warnings from the type checks in the definition of the max() macro.

Link: https://lore.kernel.org/linux-efi/20201213151306.73558-1-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index abae071..9de7ab2 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -71,7 +71,7 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
  * here throws off the memory allocation logic, so let's use the lowest power
  * of two greater than 2 MiB and greater than TEXT_OFFSET.
  */
-#define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
+#define EFI_PHYS_ALIGN		max(UL(SZ_2M), roundup_pow_of_two(TEXT_OFFSET))
 
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)

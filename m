Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DF223EAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGQOvP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGQOvL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61216C0619D4;
        Fri, 17 Jul 2020 07:51:11 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJS0tirZMesZ2bSGiVgCu7JNP/r2oeUOXBLx71mvJ5w=;
        b=f7Ghbwz2fQ+OoBf939/MnNi5VLlwjs8TUC0uX1mAsIz9du/IFnWxTj34UunYXWLN2q1RP4
        vDupZOk1YMZHerKFdrPyl/6u8abYhOsw15Lct5xotbBRf0GAingkPOcuJvvHrREaCqo/iC
        qV0nCNpnywGXNxYv4Tg3rCL4voJpy+XxRcBsxz/lQmHRFx4RIoWhgzntZPhHkbspnDBXeS
        j5J4TKcL89bXyJCvDs5hUw6Q0AD/JWoOETdG4jc9Kqt4KlOibDbbgGgt+LT/aRH12et1JY
        jrJYY4vZFXBUkcx6gslUagkOuJfYZB4vcG+6nLi+ryJ/TYXAQHb7MEhz9KrcHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJS0tirZMesZ2bSGiVgCu7JNP/r2oeUOXBLx71mvJ5w=;
        b=L6ZOzxw3ZdjhRzK7VPp1DPdBt8VnRv7OaM2sfDU9vxhPpiBtrTRapsbxjXGh3XEm3LkO1L
        63nk2/UJavJckwCQ==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove efi=old_map command line option
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.552098718@hpe.com>
References: <20200713212955.552098718@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746888.4006.8703134748223983979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     3dad716240f95c3e6114965b8ea95018ef1b04c9
Gitweb:        https://git.kernel.org/tip/3dad716240f95c3e6114965b8ea95018ef1b04c9
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:03 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:46 +02:00

x86/platform/uv: Remove efi=old_map command line option

As a part of UV1 platform removal, delete the efi=old_map option,
which is not longer needed.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200713212955.552098718@hpe.com

---
 arch/x86/platform/uv/bios_uv.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4494589..cd2a6e2 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -356,17 +356,3 @@ void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
 
 	return (void __iomem *)__va(phys_addr);
 }
-
-static int __init arch_parse_efi_cmdline(char *str)
-{
-	if (!str) {
-		pr_warn("need at least one option\n");
-		return -EINVAL;
-	}
-
-	if (!efi_is_mixed() && parse_option_str(str, "old_map"))
-		set_bit(EFI_UV1_MEMMAP, &efi.flags);
-
-	return 0;
-}
-early_param("efi", arch_parse_efi_cmdline);

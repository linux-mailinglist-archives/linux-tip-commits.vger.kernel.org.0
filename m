Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363412B6C84
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgKQSDN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgKQSDM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:12 -0500
Date:   Tue, 17 Nov 2020 18:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVfmVveJyj12/kGyk3umfMmntJGc6PIIBrZEyzy4UMo=;
        b=cvAFLwZ95h/WSGoIsOV/nrg0IiLK7SElgNW0ungYXt9igmrDhWaFTERdEWM1+5H3WJzIoo
        yOBaOpJXIsIamCj91lqFCma2kR7KebW9KAIeEOduO7T3rr7bE7qKeb1TIrD70F+DbRaM5r
        IH9EeobpHdlaKG/DUw9Ii4C/d5nuW3bIw2DSXi/YytY0yiaDL37/r9o/I/BJLfj05jAHB/
        OCLI+zD52KfdFbFnADbushT+sGv+0RdDzcigmkN2eIzEwjzmDKZOiDNbtSb2xfAkIvqNyD
        eVYQpYCob48mzgwaI1MovQ8Zux4JNWvZJp79yblY0MSK4zzyPOa+Yko2vGf0ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVfmVveJyj12/kGyk3umfMmntJGc6PIIBrZEyzy4UMo=;
        b=u21xZ763dTvvF6+LsszrkLxjF+/41SIVVsSOu+pIuYWMR5lijEQz5mGBUf0LC1OfQ9WOPd
        eX2c0c9cxeE6NDBg==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 should not default to yes
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201028153402.1736103-1-geert+renesas@glider.be>
References: <20201028153402.1736103-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160563618958.11244.17271289662483151013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
Gitweb:        https://git.kernel.org/tip/6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 28 Oct 2020 16:34:02 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 29 Oct 2020 00:36:13 +01:00

efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes

EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is deprecated, so it should not
be enabled by default.

In light of commit 4da0b2b7e67524cc ("efi/libstub: Re-enable command
line initrd loading for x86"), keep the default for X86.

Fixes: cf6b83664895a5c7 ("efi/libstub: Make initrd file loader configurable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20201028153402.1736103-1-geert+renesas@glider.be
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 36ec1f7..b452cfa 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -122,7 +122,7 @@ config EFI_ARMSTUB_DTB_LOADER
 config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
-	default y
+	default y if X86
 	depends on !RISCV
 	help
 	  Select this config option to add support for the initrd= command

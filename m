Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C801B2C6A21
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Nov 2020 17:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgK0Qt2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Nov 2020 11:49:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgK0Qt2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Nov 2020 11:49:28 -0500
Date:   Fri, 27 Nov 2020 16:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrkI4x5C/Hae6xcRNnGqX0c6rqAemOfJKcMU6M4RMy0=;
        b=tgM5F3ZlACDmRoUg3g7oZGwUKPBT/+eqyAbwy12dNNEO0WCADmOUYfBfLdhJSX3DGDRJ1/
        a2B8tEo4NuLdss/X7esvqgEc/RP6t9Q5B7i+MeW9qC8KljkP2ARnPaODtp4hagg5CzCy45
        yYmWK0yrenrErgbB00gt9fTNZrA/5h5LAs8lsa+511M/+OXExrAbdoVYeI8NNBjrJv/F9b
        pQBlubwCGjXR16NIvRScFbDjhwG/4XGGeDpjcQ/XXdO/0Ovs7dhtJI/zdBJCwYhfjmM+EK
        RGZ+OKdV1Nmb7IOwqMbZIl2/c10p5hOn4ou3AtIWKpuCjliAxsayYSs9EmcCUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrkI4x5C/Hae6xcRNnGqX0c6rqAemOfJKcMU6M4RMy0=;
        b=lXvCU7a9cZ6mqWztBHqJsrha7FNvshRqJZneB7/mh/1Nn/vYtHEudd1NS9Zu+HTdJn8XXY
        0TVkZ5zYrKSorrCg==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: EFI_EARLYCON should depend on EFI
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201124191646.3559757-1-geert@linux-m68k.org>
References: <20201124191646.3559757-1-geert@linux-m68k.org>
MIME-Version: 1.0
Message-ID: <160649576568.3364.3866512802383653495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     36a237526cd81ff4b6829e6ebd60921c6f976e3b
Gitweb:        https://git.kernel.org/tip/36a237526cd81ff4b6829e6ebd60921c6f976e3b
Author:        Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate:    Tue, 24 Nov 2020 20:16:46 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 25 Nov 2020 16:55:02 +01:00

efi: EFI_EARLYCON should depend on EFI

CONFIG_EFI_EARLYCON defaults to yes, and thus is enabled on systems that
do not support EFI, or do not have EFI support enabled, but do satisfy
the symbol's other dependencies.

While drivers/firmware/efi/ won't be entered during the build phase if
CONFIG_EFI=n, and drivers/firmware/efi/earlycon.c itself thus won't be
built, enabling EFI_EARLYCON does force-enable CONFIG_FONT_SUPPORT and
CONFIG_ARCH_USE_MEMREMAP_PROT, and CONFIG_FONT_8x16, which is
undesirable.

Fix this by making CONFIG_EFI_EARLYCON depend on CONFIG_EFI.

This reduces kernel size on headless systems by more than 4 KiB.

Fixes: 69c1f396f25b805a ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20201124191646.3559757-1-geert@linux-m68k.org
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 36ec1f7..d989549 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -270,7 +270,7 @@ config EFI_DEV_PATH_PARSER
 
 config EFI_EARLYCON
 	def_bool y
-	depends on SERIAL_EARLYCON && !ARM && !IA64
+	depends on EFI && SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
 

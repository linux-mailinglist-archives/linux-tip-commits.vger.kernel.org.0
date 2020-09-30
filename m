Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CAA27E022
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI3FWW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3FWW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:22 -0400
Date:   Wed, 30 Sep 2020 05:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q6g5yoTZEJ8bnXxeMUcZjrmOIMDFVjr1lbPEndi7pO8=;
        b=xXPnY0TgFLnOdhxaabBFBXZ6qF7c/xkxAfWlwryccMJ+RdiSz+ff4+Lgs8c6N5pZlRJ5Lg
        5Paxo2kaqqzFitzHL32hscyAQmmoZ4OOyu00fgVzES4ZSR9uahvLIe2dYg+Vlw1FDbl2oT
        O7egsaMxx4B66DGt/3MFyOYpGT3zGEGdmRECfkT0ZvRjXDJq09K75c2A5ZJU3oXIMzEScs
        QJ0f3dtDOIUy6NjlEBWOUTxr3No3wYEJawahQOFR4SE0ObeekJVDzOIzEugQb3ZDW0kZMz
        zz4O8pDTrrs6XmX0MSvpShWj5U0GR1urRGGWYnLGdYRjFJ2+NGT5jPIkcZ9afA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q6g5yoTZEJ8bnXxeMUcZjrmOIMDFVjr1lbPEndi7pO8=;
        b=dil/K5eadhc5Wils+Tus8V0ixC7ASABu+xysHGuAFrqjbURdnXs2+43YIXNP2Mxnx5O0dd
        V0BoOVQg5VLqgQCQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: remove some false dependencies on CONFIG_EFI_VARS
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144333979.7002.16594982317668338232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     5ee70cd60652e85e4e8ced99f58f2fcbab405110
Gitweb:        https://git.kernel.org/tip/5ee70cd60652e85e4e8ced99f58f2fcbab405110
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 10:27:36 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: remove some false dependencies on CONFIG_EFI_VARS

Remove some false dependencies on CONFIG_EFI_VARS, which only controls
the creation of the sysfs entries, whereas the underlying functionality
that these modules rely on is enabled unconditionally when CONFIG_EFI
is set.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index dd8d108..80f5c67 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -137,7 +137,6 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
-	depends on EFI_VARS
 	default n
 	help
 	  This module installs a reboot hook, such that if reboot() is
@@ -281,7 +280,7 @@ config EFI_EARLYCON
 
 config EFI_CUSTOM_SSDT_OVERLAYS
 	bool "Load custom ACPI SSDT overlay from an EFI variable"
-	depends on EFI_VARS && ACPI
+	depends on EFI && ACPI
 	default ACPI_TABLE_UPGRADE
 	help
 	  Allow loading of an ACPI SSDT overlay from an EFI variable specified

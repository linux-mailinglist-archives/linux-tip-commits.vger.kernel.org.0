Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8227E026
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgI3FW1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3FWW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:22 -0400
Date:   Wed, 30 Sep 2020 05:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=obVoNHU3UZZp3B75TvjkMBf0KbKUXkpQ/j0DHA4V64M=;
        b=KV0dQLkiKFMQrVyDJUZWfS4qgPC67JqjTOylU8AYnUvHZDNvzpmwl2Hizl/5at96stm/gb
        w7g/Fe1qNlB9TEv3yks3H1i1tTeLK2SP3/M3ZcWupVAiBwk7KXhJ25poZUV622W2WkpyWj
        ywDqYqM2XQvnZlhm5VLpAEDC2ggAFyp+IMwVbOUvcsvKyNTLyx0HdPa/F4S2XPqJBdjPEM
        jHNdjUFnjfBH/h+P0h03l5yUByaKJv1fcilmRE95J7djHySkdz0pM9isK8nzHSk8BaYWOY
        kVaib8kJdSQ9Ga2C6Jz8rkCWxW5QytAtkhLr5ZXX4EvhSE78nmtR8UVqceOZYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=obVoNHU3UZZp3B75TvjkMBf0KbKUXkpQ/j0DHA4V64M=;
        b=m6tUonM5Q5X3pXDHC3IPn2wBnsg2GbGGTmkqovsddIU7aiKgFba44W//q5Nq1QiiYy5xPT
        Nyt5TE7pwLoXCTAQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: efivars: limit availability to X86 builds
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144333917.7002.9382870354458127638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     963fabf37f6a94214a823df0a785e653cb8ad6ea
Gitweb:        https://git.kernel.org/tip/963fabf37f6a94214a823df0a785e653cb8ad6ea
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 10:20:10 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: efivars: limit availability to X86 builds

CONFIG_EFI_VARS controls the code that exposes EFI variables via
sysfs entries, which was deprecated before support for non-Intel
architectures was added to EFI. So let's limit its availability
to Intel architectures for the time being, and hopefully remove
it entirely in the not too distant future.

While at it, let's remove the module alias so that the module is
no longer loaded automatically.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arm/uefi.rst     |  2 +-
 drivers/firmware/efi/Kconfig   | 13 ++++---------
 drivers/firmware/efi/efivars.c |  1 -
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index f868330..f732f95 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -23,7 +23,7 @@ makes it possible for the kernel to support additional features:
 For actually enabling [U]EFI support, enable:
 
 - CONFIG_EFI=y
-- CONFIG_EFI_VARS=y or m
+- CONFIG_EFIVAR_FS=y or m
 
 The implementation depends on receiving information about the UEFI environment
 in a Flattened Device Tree (FDT) - so is only available with CONFIG_OF.
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 80f5c67..da1887f 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -4,20 +4,15 @@ menu "EFI (Extensible Firmware Interface) Support"
 
 config EFI_VARS
 	tristate "EFI Variable Support via sysfs"
-	depends on EFI
+	depends on EFI && (X86 || IA64)
 	default n
 	help
 	  If you say Y here, you are able to get EFI (Extensible Firmware
 	  Interface) variable information via sysfs.  You may read,
 	  write, create, and destroy EFI variables through this interface.
-
-	  Note that using this driver in concert with efibootmgr requires
-	  at least test release version 0.5.0-test3 or later, which is
-	  available from:
-	  <http://linux.dell.com/efibootmgr/testing/efibootmgr-0.5.0-test3.tar.gz>
-
-	  Subsequent efibootmgr releases may be found at:
-	  <http://github.com/vathpela/efibootmgr>
+	  Note that this driver is only retained for compatibility with
+	  legacy users: new users should use the efivarfs filesystem
+	  instead.
 
 config EFI_ESRT
 	bool
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index a76f50e..e6b16b3 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -22,7 +22,6 @@ MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to EFI Variables");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(EFIVARS_VERSION);
-MODULE_ALIAS("platform:efivars");
 
 static LIST_HEAD(efivar_sysfs_list);
 

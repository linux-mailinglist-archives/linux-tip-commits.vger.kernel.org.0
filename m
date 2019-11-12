Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF09EF8CCF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfKLK1U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 05:27:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLK1K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 05:27:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTO5-0007nQ-QS; Tue, 12 Nov 2019 11:27:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6AA6B1C0357;
        Tue, 12 Nov 2019 11:27:05 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:27:05 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] MAINTAINERS: update Ard's email address to @kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157355442512.29376.7360006642460081280.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     8b5c712f27044dc7812ceea5964eb2ea8952da78
Gitweb:        https://git.kernel.org/tip/8b5c712f27044dc7812ceea5964eb2ea8952da78
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 06 Nov 2019 15:41:32 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 07 Nov 2019 10:18:45 +01:00

MAINTAINERS: update Ard's email address to @kernel.org

Cc: Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 83d7e75..5d3b741 100644
--- a/.mailmap
+++ b/.mailmap
@@ -32,6 +32,7 @@ Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
 Archit Taneja <archit@ti.com>
+Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
 Axel Dyks <xl@xlsigned.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095..cc9f02a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6003,14 +6003,14 @@ F:	sound/usb/misc/ua101.c
 EFI TEST DRIVER
 L:	linux-efi@vger.kernel.org
 M:	Ivan Hu <ivan.hu@canonical.com>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 S:	Maintained
 F:	drivers/firmware/efi/test/
 
 EFI VARIABLE FILESYSTEM
 M:	Matthew Garrett <matthew.garrett@nebula.com>
 M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 L:	linux-efi@vger.kernel.org
 S:	Maintained
@@ -6189,7 +6189,7 @@ S:	Supported
 F:	security/integrity/evm/
 
 EXTENSIBLE FIRMWARE INTERFACE (EFI)
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-efi@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 S:	Maintained
@@ -15006,7 +15006,7 @@ F:	include/media/soc_camera.h
 F:	drivers/staging/media/soc_camera/
 
 SOCIONEXT SYNQUACER I2C DRIVER
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-synquacer.c

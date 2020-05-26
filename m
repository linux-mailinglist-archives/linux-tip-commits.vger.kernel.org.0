Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051AD1A75C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Apr 2020 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436558AbgDNIWJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Apr 2020 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407133AbgDNIU4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F57C00860E;
        Tue, 14 Apr 2020 01:20:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoO-0006Ik-6C; Tue, 14 Apr 2020 10:20:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF2E91C0450;
        Tue, 14 Apr 2020 10:20:51 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:51 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Move efi stub globals from .bss to .data
Cc:     Sergey Shatunov <me@prok.pw>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
References: <20200406180614.429454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158685245141.28353.8610622208195845083.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     105cb9544b161819b7be23a8a8419353a3218807
Gitweb:        https://git.kernel.org/tip/105cb9544b161819b7be23a8a8419353a3218807
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 09 Apr 2020 15:04:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:13 +02:00

efi/x86: Move efi stub globals from .bss to .data

Commit

  3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")

removed the .bss section from the bzImage.

However, while a PE loader is required to zero-initialize the .bss
section before calling the PE entry point, the EFI handover protocol
does not currently document any requirement that .bss be initialized by
the bootloader prior to calling the handover entry.

When systemd-boot is used to boot a unified kernel image [1], the image
is constructed by embedding the bzImage as a .linux section in a PE
executable that contains a small stub loader from systemd together with
additional sections and potentially an initrd. As the .bss section
within the bzImage is no longer explicitly present as part of the file,
it is not initialized before calling the EFI handover entry.
Furthermore, as the size of the embedded .linux section is only the size
of the bzImage file itself, the .bss section's memory may not even have
been allocated.

In particular, this can result in efi_disable_pci_dma being true even
when it was not specified via the command line or configuration option,
which in turn causes crashes while booting on some systems.

To avoid issues, place all EFI stub global variables into the .data
section instead of .bss. As of this writing, only boolean flags for a
few command line arguments and the sys_table pointer were in .bss and
will now move into the .data section.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
Reported-by: Sergey Shatunov <me@prok.pw>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200406180614.429454-1-nivedita@alum.mit.edu
Link: https://lore.kernel.org/r/20200409130434.6736-4-ardb@kernel.org
---
 drivers/firmware/efi/libstub/efistub.h  | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cc90a74..67d2694 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_X86)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e02ea51..867a57e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,7 +20,7 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+static efi_system_table_t *sys_table __efistub_global;
 extern const bool efi_is64;
 extern u32 image_offset;
 

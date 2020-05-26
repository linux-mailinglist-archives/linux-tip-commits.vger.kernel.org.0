Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626991A75DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Apr 2020 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436534AbgDNIVn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Apr 2020 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407124AbgDNIUw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C46C008748;
        Tue, 14 Apr 2020 01:20:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoL-0006Go-Fi; Tue, 14 Apr 2020 10:20:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 170051C0450;
        Tue, 14 Apr 2020 10:20:49 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:48 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Don't remap text<->rodata gap read-only
 for mixed mode
Cc:     Jiri Slaby <jslaby@suse.cz>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200409130434.6736-10-ardb@kernel.org>
References: <20200409130434.6736-10-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158685244872.28353.1602051956513496508.tip-bot2@tip-bot2>
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

Commit-ID:     f6103162008dfd37567f240b50e5e1ea7cf2e00c
Gitweb:        https://git.kernel.org/tip/f6103162008dfd37567f240b50e5e1ea7cf2e00c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 15:04:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:17 +02:00

efi/x86: Don't remap text<->rodata gap read-only for mixed mode

Commit

  d9e3d2c4f10320 ("efi/x86: Don't map the entire kernel text RW for mixed mode")

updated the code that creates the 1:1 memory mapping to use read-only
attributes for the 1:1 alias of the kernel's text and rodata sections, to
protect it from inadvertent modification. However, it failed to take into
account that the unused gap between text and rodata is given to the page
allocator for general use.

If the vmap'ed stack happens to be allocated from this region, any by-ref
output arguments passed to EFI runtime services that are allocated on the
stack (such as the 'datasize' argument taken by GetVariable() when invoked
from efivar_entry_size()) will be referenced via a read-only mapping,
resulting in a page fault if the EFI code tries to write to it:

  BUG: unable to handle page fault for address: 00000000386aae88
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  PGD fd61063 P4D fd61063 PUD fd62063 PMD 386000e1
  Oops: 0003 [#1] SMP PTI
  CPU: 2 PID: 255 Comm: systemd-sysv-ge Not tainted 5.6.0-rc4-default+ #22
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0008:0x3eaeed95
  Code: ...  <89> 03 be 05 00 00 80 a1 74 63 b1 3e 83 c0 48 e8 44 d2 ff ff eb 05
  RSP: 0018:000000000fd73fa0 EFLAGS: 00010002
  RAX: 0000000000000001 RBX: 00000000386aae88 RCX: 000000003e9f1120
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
  RBP: 000000000fd73fd8 R08: 00000000386aae88 R09: 0000000000000000
  R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
  R13: ffffc0f040220000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f21160ac940(0000) GS:ffff9cf23d500000(0000) knlGS:0000000000000000
  CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
  CR2: 00000000386aae88 CR3: 000000000fd6c004 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
  Modules linked in:
  CR2: 00000000386aae88
  ---[ end trace a8bfbd202e712834 ]---

Let's fix this by remapping text and rodata individually, and leave the
gaps mapped read-write.

Fixes: d9e3d2c4f10320 ("efi/x86: Don't map the entire kernel text RW for mixed mode")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200409130434.6736-10-ardb@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e0e2e81..c5e393f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -202,7 +202,7 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 
 int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 {
-	unsigned long pfn, text, pf;
+	unsigned long pfn, text, pf, rodata;
 	struct page *page;
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
@@ -256,7 +256,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 
 	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
 
-	npages = (__end_rodata_aligned - _text) >> PAGE_SHIFT;
+	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
 	pfn = text >> PAGE_SHIFT;
 
@@ -266,6 +266,14 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 1;
 	}
 
+	npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
+	rodata = __pa(__start_rodata);
+	pfn = rodata >> PAGE_SHIFT;
+	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
+		pr_err("Failed to map kernel rodata 1:1\n");
+		return 1;
+	}
+
 	return 0;
 }
 

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48B81A75C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Apr 2020 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436551AbgDNIV7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Apr 2020 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407127AbgDNIUx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFBC008769;
        Tue, 14 Apr 2020 01:20:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoL-0006Gs-VE; Tue, 14 Apr 2020 10:20:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7EE851C0086;
        Tue, 14 Apr 2020 10:20:49 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:49 -0000
From:   "tip-bot2 for Gary Lin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Fix the deletion of variables in mixed mode
Cc:     Gary Lin <glin@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408081606.1504-1-glin@suse.com>
References: <20200408081606.1504-1-glin@suse.com>
MIME-Version: 1.0
Message-ID: <158685244915.28353.17265902086997954787.tip-bot2@tip-bot2>
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

Commit-ID:     a4b81ccfd4caba017d2b84720b6de4edd16911a0
Gitweb:        https://git.kernel.org/tip/a4b81ccfd4caba017d2b84720b6de4edd16911a0
Author:        Gary Lin <glin@suse.com>
AuthorDate:    Thu, 09 Apr 2020 15:04:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:16 +02:00

efi/x86: Fix the deletion of variables in mixed mode

efi_thunk_set_variable() treated the NULL "data" pointer as an invalid
parameter, and this broke the deletion of variables in mixed mode.
This commit fixes the check of data so that the userspace program can
delete a variable in mixed mode.

Fixes: 8319e9d5ad98ffcc ("efi/x86: Handle by-ref arguments covering multiple pages in mixed mode")
Signed-off-by: Gary Lin <glin@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200408081606.1504-1-glin@suse.com
Link: https://lore.kernel.org/r/20200409130434.6736-9-ardb@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 211bb93..e0e2e81 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -638,7 +638,7 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
@@ -669,7 +669,7 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,

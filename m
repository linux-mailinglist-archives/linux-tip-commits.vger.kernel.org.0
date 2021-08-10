Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4703E5539
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhHJIbX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 04:31:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhHJIbW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 04:31:22 -0400
Date:   Tue, 10 Aug 2021 08:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628584258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oNl7eWZe7ZZkTu5Crat8AiOaBi+06ltf6nw8OkRSJ4k=;
        b=Ah/C+UcpDmRcuxOW89Zv9Yqszj9I8oWI7IjOm2pp5nMqZOfiFWsO2Ks1gt+4EFXaBR/lvM
        NsBM1542CVC8QXyguROJDw2vxYm+3K9RjGZaqS5RUF4QPf/OUloNX7f8HAamUiWuzpDqiN
        OZCBC4gt/P8gkNDx9OxxeqhDLvFq4NqplkcEjlmeN2AFhWmzHrgEVi7tBdG9jtMfovroAG
        k7x+S8WDLFoTrCAt6Yyy+/mDmnuu8fywyxIRx32bFaQQ5mXBUfQXlhw4bWk4geVPPtiC3F
        R7AGf2pGSk5/Q+Ib636C/MhCynBGktwggxFNIfWvkBOWhHuKv1J5egCt4CShiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628584258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oNl7eWZe7ZZkTu5Crat8AiOaBi+06ltf6nw8OkRSJ4k=;
        b=PbAZtrAXTxfDUxhu4MubOcDNQ6Ey/fDMxwmrHUIHWvkBrMx48NvEEWDcxFOJ9jH3yCw6Is
        hrCAW7R85+ZbcRDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: arm64: Warn when efi_random_alloc() fails
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162858425754.395.14041637152244083416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     ff80ef5bf5bd59e5eab82d1d846acc613ebbf6c4
Gitweb:        https://git.kernel.org/tip/ff80ef5bf5bd59e5eab82d1d846acc613ebbf6c4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 16:24:01 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 03 Aug 2021 07:43:07 +02:00

efi/libstub: arm64: Warn when efi_random_alloc() fails

Randomization of the physical load address of the kernel image relies on
efi_random_alloc() returning successfully, and currently, we ignore any
failures and just carry on, using the ordinary, non-randomized page
allocator routine. This means we never find out if a failure occurs,
which could harm security, so let's at least warn about this condition.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 6f214c9..010564f 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -130,6 +130,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed);
+		if (status != EFI_SUCCESS)
+			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
 	}

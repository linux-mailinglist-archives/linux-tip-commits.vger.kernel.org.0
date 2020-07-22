Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4385622A2A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbgGVWso (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbgGVWsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C67C0619DC;
        Wed, 22 Jul 2020 15:48:43 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xpMZpBxbBet0ZoY7blrq6C94naUdx3GQ0fWXWmo1sc=;
        b=q7I/QwncAMTUPU+KfuWWLcKSVOLHghqphvan08h/dgTigsj0yIBtN1GVvjzjkCfjTgVugj
        gG8cGfwSKWW/5k477E2DY+WNVkMrCdbIWSQMf5DIORnTTm9bUFOytHHQqXvY8pd8/6hgiI
        4chn7mVQym4Ws2XQJ+Ti1j4RWs3HHIl5DkMniuvdbKGfvGo3lj6LNqhQwRSMJWzs5M55Rk
        oWbUzwzcI7ILJJs5ecmm7Dd+AxyziYaR8yMjs5IV7YgN7Oqe4Y1dmjXt5AHG/hyuyd6t36
        KSNCKm9g2FvZPlk4PuTu4s+4PpRV1Bx3Dx567OkJ23WLub0F3gPNu9SjgPA+lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xpMZpBxbBet0ZoY7blrq6C94naUdx3GQ0fWXWmo1sc=;
        b=zCIz3n0weRPscq4MlnN3HwBH5YhPYFLws0Jhs4bv4ZuaQk8OT4ZzrpLlQ1UZ0GKcSIiVrO
        U5KikGK2Cq57HmDQ==
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Move the function prototypes to header file
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200706172609.25965-2-atish.patra@wdc.com>
References: <20200706172609.25965-2-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <159545812026.4006.13783475782559608479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     3230d95cea0515a6acf3f5ff360663de4c40fd07
Gitweb:        https://git.kernel.org/tip/3230d95cea0515a6acf3f5ff360663de4c40fd07
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Mon, 06 Jul 2020 10:25:59 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 09 Jul 2020 09:45:09 +03:00

efi/libstub: Move the function prototypes to header file

The prototype of the functions handle_kernel_image & efi_enter_kernel
are defined in efi-stub.c which may result in a compiler warnings if
-Wmissing-prototypes is set in gcc compiler.

Move the prototype to efistub.h to make the compiler happy.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20200706172609.25965-2-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 17 -----------------
 drivers/firmware/efi/libstub/efistub.h  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 3318ec3..a5a405d 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -122,23 +122,6 @@ static unsigned long get_dram_base(void)
 }
 
 /*
- * This function handles the architcture specific differences between arm and
- * arm64 regarding where the kernel image must be loaded and any memory that
- * must be reserved. On failure it is required to free all
- * all allocations it has made.
- */
-efi_status_t handle_kernel_image(unsigned long *image_addr,
-				 unsigned long *image_size,
-				 unsigned long *reserve_addr,
-				 unsigned long *reserve_size,
-				 unsigned long dram_base,
-				 efi_loaded_image_t *image);
-
-asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
-
-/*
  * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
  * that is described in the PE/COFF header.  Most of the code is the same
  * for both archictectures, with the arch-specific code provided in the
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2c9d422..85050f5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -776,6 +776,22 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_size,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
+/*
+ * This function handles the architcture specific differences between arm and
+ * arm64 regarding where the kernel image must be loaded and any memory that
+ * must be reserved. On failure it is required to free all
+ * all allocations it has made.
+ */
+efi_status_t handle_kernel_image(unsigned long *image_addr,
+				 unsigned long *image_size,
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 unsigned long dram_base,
+				 efi_loaded_image_t *image);
+
+asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
+					    unsigned long fdt_addr,
+					    unsigned long fdt_size);
 
 void efi_handle_post_ebs_state(void);
 

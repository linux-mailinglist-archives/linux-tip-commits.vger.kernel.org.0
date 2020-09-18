Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058A26F83B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIRIbM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIRIa7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A70C06174A;
        Fri, 18 Sep 2020 01:30:59 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=j2nWu+vB4XgwcNBTq+nx4LaLJeMFiFmIsNES5e0cozM=;
        b=YopD6v7giF5kRogXJawiHY8WCeNduAf+0K2/uR2TU956kjtzgIneJ3oQ+ki5y1XQldK6VA
        mUFqaCeMBCOAE6eC32YIEgEAt+eoOmTkYgpfHrEgnj9Vaa3DjLIB1zHzLjMgiWCzKxrLpV
        CdmEP0IM88kfaObiMOGkb4ObPms9KDIKIQnvJgPabyb/OT0//eyQ3LfGM48LC7SNTgX3QV
        86XCOBuu9KRulHPXdRHUusjqVD/BZ6AxO2rHspXc5mwcI2w7uHK5xViwuMnGl7b5oiOJoh
        d78kdNqgDjZ09gfDiiikg9mkk9eOVIoWKdDHQgmgiUXHbGjiAJ2fTBHowzd9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=j2nWu+vB4XgwcNBTq+nx4LaLJeMFiFmIsNES5e0cozM=;
        b=g8u1CCJXdK9yy0tPFfQyG5cQ2GpgD5D9SAwbD+4ocqgzov9xSyZTVnn8VYcv0xsZ8fCD5g
        AYj6yFPKJTF1g4Aw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: Export efi_low_alloc_above() to other units
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160041785714.15536.14303158158800922242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     1a895dbf4b66456bfb7da646cc9b1be3e24f4a1d
Gitweb:        https://git.kernel.org/tip/1a895dbf4b66456bfb7da646cc9b1be3e24f4a1d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 09 Sep 2020 16:16:20 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:54:59 +03:00

efi/libstub: Export efi_low_alloc_above() to other units

Permit arm32-stub.c to access efi_low_alloc_above() in a subsequent
patch by giving it external linkage and declaring it in efistub.h.

Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Tested-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 3 +++
 drivers/firmware/efi/libstub/relocate.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 85050f5..158f86f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -740,6 +740,9 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 					unsigned long max, unsigned long align);
 
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min);
+
 efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 9b1aaf8..8ee9eb2 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -20,8 +20,8 @@
  *
  * Return:	status code
  */
-static efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
-					unsigned long *addr, unsigned long min)
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;

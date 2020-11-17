Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D82B6C81
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgKQSDN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgKQSDM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5DC0613CF;
        Tue, 17 Nov 2020 10:03:12 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAHx4DHRFurIUrMe8bCxbHG6Ve3Q49+Z2tzbXkLwJWE=;
        b=h4huvNS9m5nHaBifM1WvFN1OdW1od7EozpZS6cnjAzDeyD/17qnK94uCmO/EAOsuTUHpbs
        f6Ek0UfCU5iYCj40HJgjr9thy9Y1rHwV0mEf/OY3SzuwJSJ0Hw7Tiv/+gDnEUYr9spElLq
        Uw7c0US7ROVHNHo4DOQEplq7GXguYfYzGCf+bZuTIBVn4X/SeGnxxtUN3XLpTaVVPVUp3M
        a3vUZc5IvAiAJMulTe3xVkpPtQ6VyegazSEPS1tPPeKygn+Zys9/dBvhLZodvvp9LNchtD
        vaaUymhUrSszFXh6w65TetvSzYWBML9C2BFCVy93g2VaOnMZyz9M1s230RFK3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAHx4DHRFurIUrMe8bCxbHG6Ve3Q49+Z2tzbXkLwJWE=;
        b=xNQkdwkO6EmYUoP98eeDDr3aKRKqfR9wCzjZYc/BwvefEImC/7lU/w6IwAmQ6lcKtzpaH1
        LeOi0l/lYrLFxqAw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/x86: Only copy the compressed kernel image in
 efi_relocate_kernel()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201011142012.96493-1-nivedita@alum.mit.edu>
References: <20201011142012.96493-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160563619021.11244.4162091685668996130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     688eb28211abdf82a3f51e8997f1c8137947227d
Gitweb:        https://git.kernel.org/tip/688eb28211abdf82a3f51e8997f1c8137947227d
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Sun, 11 Oct 2020 10:20:12 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 26 Oct 2020 08:06:36 +01:00

efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()

The image_size argument to efi_relocate_kernel() is currently specified
as init_size, but this is unnecessarily large. The compressed kernel is
much smaller, in fact, its image only extends up to the start of _bss,
since at this point, the .bss section is still uninitialized.

Depending on compression level, this can reduce the amount of data
copied by 4-5x.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20201011142012.96493-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3672539..f14c4ff 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
 	    (image_offset == 0)) {
+		extern char _bss[];
+
 		status = efi_relocate_kernel(&bzimage_addr,
-					     hdr->init_size, hdr->init_size,
+					     (unsigned long)_bss - bzimage_addr,
+					     hdr->init_size,
 					     hdr->pref_address,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);

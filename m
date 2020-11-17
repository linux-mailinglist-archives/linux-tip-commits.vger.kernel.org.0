Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E853B2B6C21
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgKQRrR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 12:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgKQRrN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 12:47:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C30AC0613CF;
        Tue, 17 Nov 2020 09:47:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 17:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605635231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KguMoOgsQhKc602WlhYsE+kgcjU7TeMYiybaJDeuyWk=;
        b=xcw1jeyNQIEwQkg0sAmeUPVOA6vlBPL/e/Q0iRJcIkqNxsdG0DUZB8tmcTnP6vsxGVJbha
        ydXhYoCnu5i0UX7N4a77cBjSWYMgueyjBJB63v4eJ8hvZHUBxH23wZZd5/VmBOogonnHnL
        3pac1AJXS5X5KRvC1HTz0bVLpFitXeXnRyA1tL0TFVK7lCooKw3ALHjPeiqGSa5DGg1NP8
        yq/i2ylJasBUrzQy8e0Zu+12jlztBErt37g19hC/uWyLGvdd/UJFF9gqClqTlP/D9eOoqI
        MVaXy6AINd8nWQXM2xQvA+kih3LoRZP+m9lX6nABArrhuh+kVPTFnEA/GdYmZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605635231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KguMoOgsQhKc602WlhYsE+kgcjU7TeMYiybaJDeuyWk=;
        b=kBbfhwX22/FCxpHKIoWfGpKbajuT/5eBHzoF2jQtPfbUyPsfSq07mibFs7Z90X/emhzg+F
        IRD5uDZOkPkHWrCQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/arm: set HSCTLR Thumb2 bit correctly for HVC
 calls from HYP
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160563523094.11244.17039859225367140126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     fbc81ec5b85d43a4b22e49ec0e643fa7dec2ea40
Gitweb:        https://git.kernel.org/tip/fbc81ec5b85d43a4b22e49ec0e643fa7dec2ea40
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sat, 03 Oct 2020 17:28:27 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 26 Oct 2020 08:02:11 +01:00

efi/arm: set HSCTLR Thumb2 bit correctly for HVC calls from HYP

Commit

  db227c19e68db353 ("ARM: 8985/1: efi/decompressor: deal with HYP mode boot gracefully")

updated the EFI entry code to permit firmware to invoke the EFI stub
loader in HYP mode, with the MMU either enabled or disabled, neither
of which is permitted by the EFI spec, but which does happen in the
field.

In the MMU on case, we remain in HYP mode as configured by the firmware,
and rely on the fact that any HVC instruction issued in this mode will
be dispatched via the SVC slot in the HYP vector table. However, this
slot will point to a Thumb2 symbol if the kernel is built in Thumb2
mode, and so we have to configure HSCTLR to ensure that the exception
handlers are invoked in Thumb2 mode as well.

Fixes: db227c19e68db353 ("ARM: 8985/1: efi/decompressor: deal with HYP mode boot gracefully")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 2e04ec5..caa2732 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1472,6 +1472,9 @@ ENTRY(efi_enter_kernel)
 		@ issued from HYP mode take us to the correct handler code. We
 		@ will disable the MMU before jumping to the kernel proper.
 		@
+ ARM(		bic	r1, r1, #(1 << 30)	) @ clear HSCTLR.TE
+ THUMB(		orr	r1, r1, #(1 << 30)	) @ set HSCTLR.TE
+		mcr	p15, 4, r1, c1, c0, 0
 		adr	r0, __hyp_reentry_vectors
 		mcr	p15, 4, r0, c12, c0, 0	@ set HYP vector base (HVBAR)
 		isb

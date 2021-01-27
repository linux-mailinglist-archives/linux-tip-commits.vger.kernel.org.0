Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA65306412
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhA0Tb5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:31:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhA0Tbx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:53 -0500
Date:   Wed, 27 Jan 2021 19:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQUJUBMTo2oqqJf/tmLygDW54mgSKpoT7Ov00dk667A=;
        b=IOD+tCsJYm7fojlw0ZBsr6G5x/FUX2DhiotQmk/U7p1LIqu0bsUPQgDg5O3K9FUB4TUHtA
        h83LD91XPDxCi64r70BE1idaj4bowk3pVBhlV6Sli9VbXop+g05w0uGUbO3Z3kbTM8f08v
        cFhRA5gOlDY9plBYQOqlGIqzZ/QSATWKq1GiF25RNAuCxiWCpKD+rGm6AEUC+X9P+YbRDv
        APTaMla1lSV1yFujgqRL/82QeaiDPM4fhtuRp8HKLBn4rHymJeUudzHJ9LFzxh+wp3Re5V
        7y3yzkvVO/wmE9upxNTh7d+SM4xHatFHIaOFWzshxTveJLOwsBuAI7eu23bzlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQUJUBMTo2oqqJf/tmLygDW54mgSKpoT7Ov00dk667A=;
        b=g5zG1qZqhN1SE0vtDF9eFeMd1oXtEFeteyvwYv7WxCKqkWEjZ/zmuk4KjJI93Ul5NWsKw/
        2B3FiHTEKXw3N3Dw==
From:   "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/arm64: Update debug prints to reflect other
 entropy sources
Cc:     Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210120163810.14973-1-broonie@kernel.org>
References: <20210120163810.14973-1-broonie@kernel.org>
MIME-Version: 1.0
Message-ID: <161177586990.23325.5752801051222862535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     1c761ee9da1ac6ba7e40d14457fac94c87eaff35
Gitweb:        https://git.kernel.org/tip/1c761ee9da1ac6ba7e40d14457fac94c87eaff35
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Wed, 20 Jan 2021 16:38:10 
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:54:08 +01:00

efi/arm64: Update debug prints to reflect other entropy sources

Currently the EFI stub prints a diagnostic on boot saying that KASLR will
be disabled if it is unable to use the EFI RNG protocol to obtain a seed
for KASLR.  With the addition of support for v8.5-RNG and the SMCCC RNG
protocol it is now possible for KASLR to obtain entropy even if the EFI
RNG protocol is unsupported in the system, and the main kernel now
explicitly says if KASLR is active itself.  This can result in a boot
log where the stub says KASLR has been disabled and the main kernel says
that it is enabled which is confusing for users.

Remove the explicit reference to KASLR from the diagnostics, the warnings
are still useful as EFI is the only source of entropy the stub uses when
randomizing the physical address of the kernel and the other sources may
not be available.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20210120163810.14973-1-broonie@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 22ece1a..b69d631 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -61,10 +61,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
+				efi_info("EFI_RNG_PROTOCOL unavailable\n");
 				efi_nokaslr = true;
 			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
+				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
 					status);
 				efi_nokaslr = true;
 			}

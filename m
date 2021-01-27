Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB77C306414
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhA0TcB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhA0Tb4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EFC0613D6;
        Wed, 27 Jan 2021 11:31:16 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q80sBPUnpMjXHuu72vhgmuaWBVKx9yUWoxfzd2vDp6Q=;
        b=Uxf5CAEc281HKRpy9N6W72jRC90m760Kn8sfQ1X1iTdu6WYvmLEErUMdCjHKWn63m7EOzC
        M0pqNCwW4TDLlG6CCCMwixQkzcbrtdhaJDM3Qn4gTwJ3yEqh6Tc1iOKmD2aScEJoIfzuzS
        oV4USp4eNCvcdmnGVrykd/dnye657X3pnL+FOfSyyJMXRt79dqfn6xy1S7pwfPa6qYjUSb
        W6JRXgMEGlvvYp6bUUTX7VNCXe/OtiBGuVzASu6clOtdwYTPQVJmWnshq3juj4X6eOVs7o
        +j3QkrEyTw+3otHB8J5slBZE1+QwH+S+zCxfyn8q7yIAwQvWzdrYoEhyb3FPqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q80sBPUnpMjXHuu72vhgmuaWBVKx9yUWoxfzd2vDp6Q=;
        b=ZsamIQQ5MPfAwDfaPVYfAGgdURIkhxnHDNQZ+whctc4zKiAbGv/klZR8kC74uWDkoX4mfo
        avmUtFT0mW386rBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: whitespace cleanup
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587114.23325.5536319848351218207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     2f196059864fb0fe8f60c14a2cb214055b283e08
Gitweb:        https://git.kernel.org/tip/2f196059864fb0fe8f60c14a2cb214055b283e08
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 17:11:49 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 19 Jan 2021 17:57:15 +01:00

efi/libstub: whitespace cleanup

Trivial whitespace cleanup.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 0c31af3..2537a24 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -29,10 +29,10 @@
 #include <asm/page.h>
 
 #define EFI_SUCCESS		0
-#define EFI_LOAD_ERROR          ( 1 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_UNSUPPORTED		( 3 | (1UL << (BITS_PER_LONG-1)))
-#define EFI_BAD_BUFFER_SIZE     ( 4 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_BAD_BUFFER_SIZE	( 4 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_BUFFER_TOO_SMALL	( 5 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_READY		( 6 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_DEVICE_ERROR	( 7 | (1UL << (BITS_PER_LONG-1)))

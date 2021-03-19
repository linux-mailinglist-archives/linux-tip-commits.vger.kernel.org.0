Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2F341E2F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSN3i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCSN3S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 09:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A32C06174A;
        Fri, 19 Mar 2021 06:29:10 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:29:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616160549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zEie8E1D8lotiW5GlM6ldy8bcHu9nJkR2e7P30O39Yk=;
        b=QyLn5rGDskmSAKHyztXxRxKWJ3r3ucOs4/qiK1e/Hqt2EdnkihyORWmH2HxuTg/syul95J
        E19yp1MekEF09E9yvH0bC3tu4MU9U/WqcDbMH5a984ind4quz8nz61itKh4UfyGUNJnZdT
        PrkdqSb7Z9ngoRZ4YccppUbEj/CqqPgd+R1IVPwG72jPmJOX8CuqfiBejTLanYZ/YrT0Sy
        Bppxm99shsBXjN7aPjZINFDB69uC2ItrDMFJTH1F3bwhqfCLpmXhWl7lMxFOvo1a1dt2LC
        //dTC+rC8IbBC7LWd5smsX8dAYCRCpw9BwtNioq9wVBjODdtcO2RWSFam90qNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616160549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zEie8E1D8lotiW5GlM6ldy8bcHu9nJkR2e7P30O39Yk=;
        b=nslEvXEVma3mm4PuIp5S9dGb7fVUFw5jnvfd74JAVf7fvNuCLHs3rYJGFwBXIQ2mxwhgVE
        LFFzyXXt2VQr8KAQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: use 32-bit alignment for efi_guid_t literals
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161616054876.398.14673289210383661828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     fb98cc0b3af2ba4d87301dff2b381b12eee35d7d
Gitweb:        https://git.kernel.org/tip/fb98cc0b3af2ba4d87301dff2b381b12eee35d7d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 10 Mar 2021 08:33:19 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 19 Mar 2021 07:44:28 +01:00

efi: use 32-bit alignment for efi_guid_t literals

Commit 494c704f9af0 ("efi: Use 32-bit alignment for efi_guid_t") updated
the type definition of efi_guid_t to ensure that it always appears
sufficiently aligned (the UEFI spec is ambiguous about this, but given
the fact that its EFI_GUID type is defined in terms of a struct carrying
a uint32_t, the natural alignment is definitely >= 32 bits).

However, we missed the EFI_GUID() macro which is used to instantiate
efi_guid_t literals: that macro is still based on the guid_t type,
which does not have a minimum alignment at all. This results in warnings
such as

  In file included from drivers/firmware/efi/mokvar-table.c:35:
  include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to
      4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
      access [-Walign-mismatch]
          status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
                                          ^
  include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to
      4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
      access [-Walign-mismatch]
          get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);

The distinction only matters on CPUs that do not support misaligned loads
fully, but 32-bit ARM's load-multiple instructions fall into that category,
and these are likely to be emitted by the compiler that built the firmware
for loading word-aligned 128-bit GUIDs from memory

So re-implement the initializer in terms of our own efi_guid_t type, so that
the alignment becomes a property of the literal's type.

Fixes: 494c704f9af0 ("efi: Use 32-bit alignment for efi_guid_t")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1327
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8710f57..6b5d36b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -72,8 +72,10 @@ typedef void *efi_handle_t;
  */
 typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
-#define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
+#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {					\
+	(a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,	\
+	(b) & 0xff, ((b) >> 8) & 0xff,						\
+	(c) & 0xff, ((c) >> 8) & 0xff, d } }
 
 /*
  * Generic EFI table header

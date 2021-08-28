Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFA3FA506
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhH1Kig (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 06:38:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhH1Kif (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 06:38:35 -0400
Date:   Sat, 28 Aug 2021 10:37:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o//Sx678HqHRjLVgK26pOqEuNZvH9oIBQu3a3keP+hU=;
        b=SAA+ufKsFmy6jTpV9S9iqBkQPdTBWJpkW8RBO3HBkTSdP22bhmOpgHkrCDBOy7SGwnNsW6
        9SHm430gjesOi2Zv5yrNzSJO5KLhAsNaibieEgprQR4++fFHcW3P6StxpM2xTTKnCQCAvB
        wOTy2pGtWK4Bq42yjK6BGnTP6GY86PITIt3Lh4/3tyBrx5TRnxxiEcbytRfjcmcug80Ywe
        1cQoMje6J5gEc9F8ievkl3jLYzgK4mdf22qOLU47B4iSF6cyn+nBbj+Oem3BH3yzND9Z1i
        xh9spbv9I7Cp/zQLjKeBuXLid2mdwBJuYZY7eFHyz3pxVV8blDqfhA6aolplHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o//Sx678HqHRjLVgK26pOqEuNZvH9oIBQu3a3keP+hU=;
        b=L9FGgqSa9bEsxsLtxnap+zpK4drlELirojP09h13leQtAK7/6csC5Z6hh6tgZnOIeVNMX8
        GnX62NpOk03U8IDw==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: Don't use knowledge about efi_guid_t internals
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Hallyn <serge@hallyn.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163014706334.25758.4704036796708995380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     b31eea2e04c1002e5cb864eefdc718b70d2cb08c
Gitweb:        https://git.kernel.org/tip/b31eea2e04c1002e5cb864eefdc718b70d2cb08c
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 09 Feb 2021 18:45:06 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 27 Aug 2021 16:01:27 +02:00

efi: Don't use knowledge about efi_guid_t internals

When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
its internal members.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 security/integrity/platform_certs/efi_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/efi_parser.c b/security/integrity/platform_certs/efi_parser.c
index 18f01f3..d98260f 100644
--- a/security/integrity/platform_certs/efi_parser.c
+++ b/security/integrity/platform_certs/efi_parser.c
@@ -55,7 +55,7 @@ int __init parse_efi_signature_list(
 		memcpy(&list, data, sizeof(list));
 		pr_devel("LIST[%04x] guid=%pUl ls=%x hs=%x ss=%x\n",
 			 offs,
-			 list.signature_type.b, list.signature_list_size,
+			 &list.signature_type, list.signature_list_size,
 			 list.signature_header_size, list.signature_size);
 
 		lsize = list.signature_list_size;

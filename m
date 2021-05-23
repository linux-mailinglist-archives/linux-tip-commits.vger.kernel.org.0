Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5459838DACF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEWKGP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhEWKGP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 06:06:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32189C061574;
        Sun, 23 May 2021 03:04:49 -0700 (PDT)
Date:   Sun, 23 May 2021 10:04:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621764287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5W8D+7/wjpOiCIVH7rU73m1fRoEyqSiT2kiG/P9u3ZA=;
        b=pzpmxSgeDJbBQ7ZZ4vXFxMPHksSEG72NSlJ5bkLKqyJF4zX/wPWbgU23KeeX1J0EAmallB
        qR/p8tl0AjuhLuR/jpMYvsq0QZGVu7BHVcR4DsHI6HD80DXTHzoOE5iW9GFpf+Q9YmUYkI
        9BK3iiRzBTDdcRq5RW5fvNlk5z0dv9MKpDTo2z3I9HsPSkKsUtKd8P0SE/rsrfAl5wxxnY
        momF4grBRPzDK5YJZcfFSGBYJOqgv4AlzgUl7W415UACdxRkE/RyuenlZnLGCFYk8FMWys
        aavidjMusGc4bPLk+u8I7f3QBD/DpeKTKcRucQpsoHrdKGmRyspLAvguGT2f4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621764287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5W8D+7/wjpOiCIVH7rU73m1fRoEyqSiT2kiG/P9u3ZA=;
        b=BSsC3dUXb11W0wsg0opghVw/9PB6ltGs6zkNeo8i2VO8DdWqKemjuqh9q54qDLZKof01Tj
        eTdG4WT7iWWOYaBw==
From:   "tip-bot2 for Paul Menzel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] x86/efi: Log 32/64-bit mismatch with kernel as an error
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176428679.29796.2511069274477726490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     bb11580f61b6c4ba5c35706abd927c8ac8c32852
Gitweb:        https://git.kernel.org/tip/bb11580f61b6c4ba5c35706abd927c8ac8c=
32852
Author:        Paul Menzel <pmenzel@molgen.mpg.de>
AuthorDate:    Sat, 15 May 2021 10:14:04 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:09:07 +02:00

x86/efi: Log 32/64-bit mismatch with kernel as an error

Log the message

    No EFI runtime due to 32/64-bit mismatch with kernel

as an error condition, as several things like efivarfs won=E2=80=99t work
without the EFI runtime.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e70..147c30a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -468,7 +468,7 @@ void __init efi_init(void)
 	 */
=20
 	if (!efi_runtime_supported())
-		pr_info("No EFI runtime due to 32/64-bit mismatch with kernel\n");
+		pr_err("No EFI runtime due to 32/64-bit mismatch with kernel\n");
=20
 	if (!efi_runtime_supported() || efi_runtime_disabled()) {
 		efi_memmap_unmap();

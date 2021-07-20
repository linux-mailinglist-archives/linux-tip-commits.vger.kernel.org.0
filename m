Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D993CF8EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jul 2021 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhGTK5A (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Jul 2021 06:57:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhGTK4w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Jul 2021 06:56:52 -0400
Date:   Tue, 20 Jul 2021 11:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626781038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SEs905FVaJUOquqXZnPAKzf/bnsD4aaJswaVjsYrTX0=;
        b=A/51H0N8f0qRCaZkbI/fSJOxFiNXbkrMvZDr3NxkpNpDKvX0FhhhFtwjZIwQE8XLy4Hsr3
        VmecH9a4ivENWJB6ipo/j8/Qs5In3Rh64viiJfAmxzTE0hYT7fJ25YRPq6KIswodnPb45y
        R3VEi1KmO9ypLMpYXI+/zJpNdNsNkh+ZfLDu3i9h0XjZWVIhuTa3XX09YAa15R/S7KZx+J
        JoMIhfXHqw02SN9XFoUkgGf0heRdJHhP/rQQ0+HegK/O+p9fh1ElTug1mtTWbVtdy6EU81
        3HrAO0hJI6GpXEBtC+tjHpUF6HigwDy2h0wb84CbJwKi60UaIY8hciEX3KN/1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626781038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SEs905FVaJUOquqXZnPAKzf/bnsD4aaJswaVjsYrTX0=;
        b=P6NLRMGoEKRYsRSBWHvbPVHPabbH8Dde7QofT6zfk9STMz/KWlWQCDhrzXiiJr3eFlCT8I
        io4H1uKxTlbA17CA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/mokvar: Reserve the table only if it is in boot
 services data
Cc:     Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162678103783.395.12611335259127508121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     47e1e233e9d822dfda068383fb9a616451bda703
Gitweb:        https://git.kernel.org/tip/47e1e233e9d822dfda068383fb9a616451bda703
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 20 Jul 2021 09:28:09 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 20 Jul 2021 09:28:09 +02:00

efi/mokvar: Reserve the table only if it is in boot services data

One of the SUSE QA tests triggered:

  localhost kernel: efi: Failed to lookup EFI memory descriptor for 0x000000003dcf8000

which comes from x86's version of efi_arch_mem_reserve() trying to
reserve a memory region. Usually, that function expects
EFI_BOOT_SERVICES_DATA memory descriptors but the above case is for the
MOKvar table which is allocated in the EFI shim as runtime services.

That lead to a fix changing the allocation of that table to boot services.

However, that fix broke booting SEV guests with that shim leading to
this kernel fix

  8d651ee9c71b ("x86/ioremap: Map EFI-reserved memory as encrypted for SEV")

which extended the ioremap hint to map reserved EFI boot services as
decrypted too.

However, all that wasn't needed, IMO, because that error message in
efi_arch_mem_reserve() was innocuous in this case - if the MOKvar table
is not in boot services, then it doesn't need to be reserved in the
first place because it is, well, in runtime services which *should* be
reserved anyway.

So do that reservation for the MOKvar table only if it is allocated
in boot services data. I couldn't find any requirement about where
that table should be allocated in, unlike the ESRT which allocation is
mandated to be done in boot services data by the UEFI spec.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/mokvar-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index d8bc013..38722d2 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -180,7 +180,10 @@ void __init efi_mokvar_table_init(void)
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;
 	}
-	efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
+	if (md.type == EFI_BOOT_SERVICES_DATA)
+		efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
 	efi_mokvar_table_size = map_size_needed;
 }
 

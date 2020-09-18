Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5B26F81F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgIRIZT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:25:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRIZT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:25:19 -0400
Date:   Fri, 18 Sep 2020 08:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cxeE9nj6jiMEYBAV4jpKNZRYbtK+gozwPjxpUu8t6CU=;
        b=LaGzN+xZkbZtYH/Wn37dznlH+5ZoGVPnI29B+fdpMbBaRSRRMne/nmTK3cWghcNr6zUPxn
        xSL/L+JwvVNrhYOmVFDLef+ZOfRczpLKkIiMVq4vJvlK/qe3Nbq3fF6opW8tWNgDQlUjXl
        55E5hIMgH1ojQTEkNT3UFVdngj4btdcpR/gm0I9RvZCKa7PZiIAT0IpNyu7XT2eG9yP8I0
        WP6zSo2fq5OURytx/sQyJKIKZOL2BLpMm1HKvSyoT5Et51xnLvts2O/a8GY94txiPIB1Zu
        wL4zfJSAaXimbss6VAU2+/0M0Mg3lAyWtV729jHkxLeSQnzYhbP8lgEIzLJiAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cxeE9nj6jiMEYBAV4jpKNZRYbtK+gozwPjxpUu8t6CU=;
        b=KpZfGrTA12SxwVc8B8G6QN+3UbV1k4oArpYJ8en6CqoXJVhgQzRsSjZ2BVkD7RWU0kzfUP
        Mh+JpQrtQnVitgCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: efibc: check for efivars write capability
Cc:     Branden Sherrell <sherrellbc@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160041751676.15536.3076413657111561677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     46908326c6b801201f1e46f5ed0db6e85bef74ae
Gitweb:        https://git.kernel.org/tip/46908326c6b801201f1e46f5ed0db6e85bef74ae
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 15 Sep 2020 18:12:09 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 15 Sep 2020 18:22:47 +03:00

efi: efibc: check for efivars write capability

Branden reports that commit

  f88814cc2578c1 ("efi/efivars: Expose RT service availability via efivars abstraction")

regresses UEFI platforms that implement GetVariable but not SetVariable
when booting kernels that have EFIBC (bootloader control) enabled.

The reason is that EFIBC is a user of the efivars abstraction, which was
updated to permit users that rely only on the read capability, but not on
the write capability. EFIBC is in the latter category, so it has to check
explicitly whether efivars supports writes.

Fixes: f88814cc2578c1 ("efi/efivars: Expose RT service availability via efivars abstraction")
Tested-by: Branden Sherrell <sherrellbc@gmail.com>
Link: https://lore.kernel.org/linux-efi/AE217103-C96F-4AFC-8417-83EC11962004@gmail.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efibc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 35dccc8..15a4753 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -84,7 +84,7 @@ static int __init efibc_init(void)
 {
 	int ret;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efivars_kobject() || !efivar_supports_writes())
 		return -ENODEV;
 
 	ret = register_reboot_notifier(&efibc_reboot_notifier);

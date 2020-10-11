Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB128A5DB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgJKGI5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 02:08:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKGI5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 02:08:57 -0400
Date:   Sun, 11 Oct 2020 06:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602396535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NFDWvJrrqrrvlMJ5O9iZKUufRiraLZ8NQC5ILvCEisg=;
        b=Y2uRPlaRXioURdH8ME9LD63HCQvqSOFmgjK8+gewtdxDnOu48SV+wID4YHtReMuiLbTaFe
        mLgRfwRXOQHcYjda8lBdrsUwzzJX6F/1ynPeYvrialJ2y339KSWskatPJ1WlYe1B8s4Cae
        L+g0FIX/ZLHteN0dVhFtPuGQwx4ns/b6CYO2Sa+zOv5b2izTQq1v1NngYKG1gERUk8LWK3
        StgQf0wmB/UPuS9nshDKEzyqsLnLyYa5aDAh1BIe4Y/csamt6dLk23cliF1FboKAzMD3cO
        GULgTDZzZJNdX9leX5mrrNDS0aNn7pbHHOA1/ope3SX7mLIeJdOeNWMacyONxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602396535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NFDWvJrrqrrvlMJ5O9iZKUufRiraLZ8NQC5ILvCEisg=;
        b=ZpEBZSAV38SRQwYehOOO3Z//tb1+MD6f59EZo65Ls+9IykuqzOkTIQZ8CJ2jAdYOC8+5dE
        HDwvAoN9fRqAE1CA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: mokvar: add missing include of asm/early_ioremap.h
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160239653434.7002.15806482622522996212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     cc383a9e245c527d3175e2cf4cced9dbbedbbac6
Gitweb:        https://git.kernel.org/tip/cc383a9e245c527d3175e2cf4cced9dbbedbbac6
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 02 Oct 2020 10:01:23 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 02 Oct 2020 10:08:29 +02:00

efi: mokvar: add missing include of asm/early_ioremap.h

Nathan reports that building the new mokvar table code for 32-bit
ARM fails with errors such as

  error: implicit declaration of function 'early_memunmap'
  error: implicit declaration of function 'early_memremap'

This is caused by the lack of an explicit #include of the appropriate
header, and ARM apparently does not inherit that inclusion via another
header file. So add the #include.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/mokvar-table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 72a9e17..d8bc013 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -40,6 +40,8 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include <asm/early_ioremap.h>
+
 /*
  * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table is a packed
  * sequence of struct efi_mokvar_table_entry, one for each named

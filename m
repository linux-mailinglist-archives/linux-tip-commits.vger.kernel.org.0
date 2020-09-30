Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6627E04A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgI3F1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3F1x (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:27:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75AC061755;
        Tue, 29 Sep 2020 22:27:53 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d59O0bYDBDN6t2pqKeOkbwjWDwXTzbFxGX0I9PhSmPM=;
        b=nWLT+zGD6ZJ5eHbvhjXzvoXYHT6Lk+7JbwX3ZcktSANogAcOK8QCAwlYpAKiCeFBgemVOz
        i+FGXDuWS3j0ZnrHepXJtEqTvDgLu8hWFET3GI2He1k4EqXYsQ/d5+Wpv3gJEifLhHMCAN
        r9rQKY4kvSODkZ6Iccp0fHqx5QjfM/w+jKQAqjyIuH0qHuNewnJYKWi6bxvQrBA9K/WQkX
        hwQjJ0dnxMvLLOgVJifFhFsijpyLE0B+AGzfeFllZkeMyU+1gsff6mDBXUOEWF8htprbPF
        1LFqkX0Dc/Aa3AzNCxPBay1GJvW2HUOeeB65629Lsz5Bj994kDPlSnW0Z3XG5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d59O0bYDBDN6t2pqKeOkbwjWDwXTzbFxGX0I9PhSmPM=;
        b=UIwBL7heO//KY/v0qVjjyhMBsLGxIaWo6VQsQpikTamdnpcb1bb8qKjJEml1TK5DxyzBPM
        d4R02FPDT0eeEJBA==
From:   "tip-bot2 for Michael Schaller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efivarfs: Replace invalid slashes with exclamation
 marks in dentries.
Cc:     Michael Schaller <misch@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200925074502.150448-1-misch@google.com>
References: <20200925074502.150448-1-misch@google.com>
MIME-Version: 1.0
Message-ID: <160144367153.7002.16023024212082263311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     336af6a4686d885a067ecea8c3c3dd129ba4fc75
Gitweb:        https://git.kernel.org/tip/336af6a4686d885a067ecea8c3c3dd129ba4fc75
Author:        Michael Schaller <misch@google.com>
AuthorDate:    Fri, 25 Sep 2020 09:45:02 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 25 Sep 2020 23:29:04 +02:00

efivarfs: Replace invalid slashes with exclamation marks in dentries.

Without this patch efivarfs_alloc_dentry creates dentries with slashes in
their name if the respective EFI variable has slashes in its name. This in
turn causes EIO on getdents64, which prevents a complete directory listing
of /sys/firmware/efi/efivars/.

This patch replaces the invalid shlashes with exclamation marks like
kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.

Signed-off-by: Michael Schaller <misch@google.com>
Link: https://lore.kernel.org/r/20200925074502.150448-1-misch@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 28bb568..15880a6 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
 
+	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
+	strreplace(name, '/', '!');
+
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
 	if (!inode)

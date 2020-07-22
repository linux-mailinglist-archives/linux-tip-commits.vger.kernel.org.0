Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C622A2A7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGVWsv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 18:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733129AbgGVWsq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E80C0619DC;
        Wed, 22 Jul 2020 15:48:45 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:48:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rEWtpIG0GFsMGJyXo0Fmnf4lA8zDWudf30raZ9vVtoQ=;
        b=qylHd8+iGanxJd4aV93ZgV2QdtLeby4fhG5+C9h6Hc86jdCUDyCdQooRooWbJzW/z9N7T2
        K8HL8Habaod9fd7+Cno2CSClpjezotMsO68eFX8l6gd8KU/oRCGhnRDHdFZryrBe0RoIgY
        1KkRmC+Ke0quxKVacahO0Q+xGnzurQVhTMpTyytR4JNOhVftv04vUUBqV9WOg1TqjIMrvd
        o47fMZCQYdVgqre51bWGZDHvo4lPmtljHM2XbI3pcXAkB7hrrQfNwgDA5NAT1eDZFqffI7
        ujBz5nCnjdISNizxD6Sgo3divFPcD4jfS0H8IYOtchhWXQ/UaXEKRCUoHgdxbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rEWtpIG0GFsMGJyXo0Fmnf4lA8zDWudf30raZ9vVtoQ=;
        b=mFBhzqiiF49H9fp8U02HvvpndJtDOuYwCHyoquS3JmHfbokmw/PHZ45ffdiOBQ5J3YF5xq
        J+Un2U9SsEOTZQAA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Remove unused variables
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159545812358.4006.7758768888819544346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     0bda49f30ca48998102eb0a0b53970c3a3558be0
Gitweb:        https://git.kernel.org/tip/0bda49f30ca48998102eb0a0b53970c3a3558be0
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 18 Jun 2020 15:10:59 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 25 Jun 2020 18:06:10 +02:00

efi/x86: Remove unused variables

Commit

  987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")

made the ramdisk_addr/ramdisk_size variables in efi_pe_entry unused, but
neglected to delete them.

Delete these unused variables.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5a48d99..37e82bf 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -361,8 +361,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	unsigned long ramdisk_addr;
-	unsigned long ramdisk_size;
 
 	efi_system_table = sys_table_arg;
 

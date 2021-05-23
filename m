Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4038DABD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEWJsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhEWJsb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 05:48:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14698C06138A;
        Sun, 23 May 2021 02:47:04 -0700 (PDT)
Date:   Sun, 23 May 2021 09:46:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5l6DHTvNEG2WQ1DrD3q2BnubrCyPAWGfUQegH/DVx4k=;
        b=xNHO/qhtO5lSEAn77/JoRSimrFsDIXmgEqAGrVxM8w6+3SkvlQ/FNqOUSmvX9NodAK3oLP
        +LZyc1AUZ1V6u3OTbxeRqbCE1N5Z8+7bfRlmWkuCEgUZhtvfg2DRWo7LXwtdgPxBIUjh4Z
        laLTy6K4JXxvxgOMCfnuVTrElQmlg0dvTa4AZIt7qDjwnnxe0N3aODanSXaACLuNtZWd0T
        LTkTEJo93VUVJoOYqzujZdsp4e9MGnQVWqonlJsVB4uTZB1WqEVjspMJFfrHAnGH6XLyop
        Fe40CU8JPejOJci0gnmVV0gWEexoPmL40cISd4+SXYB40hHuSX4+XzkKpKUAaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5l6DHTvNEG2WQ1DrD3q2BnubrCyPAWGfUQegH/DVx4k=;
        b=Fa5OpEWWqRvUq3264s6sFikgiiwIHYZTaCrbmQ3WrqRhH+eboUlc69bDScAnMykRD9+Zy2
        8539ntHDDLNAX3Cg==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: prevent read overflow in find_file_option()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176321972.29796.1850532373551038912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     c4039b29fe9637e1135912813f830994af4c867f
Gitweb:        https://git.kernel.org/tip/c4039b29fe9637e1135912813f830994af4c867f
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Fri, 23 Apr 2021 14:48:31 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:05:32 +02:00

efi/libstub: prevent read overflow in find_file_option()

If the buffer has slashes up to the end then this will read past the end
of the array.  I don't anticipate that this is an issue for many people
in real life, but it's the right thing to do and it makes static
checkers happy.

Fixes: 7a88a6227dc7 ("efi/libstub: Fix path separator regression")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 4e81c60..dd95f33 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -103,7 +103,7 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 		return 0;
 
 	/* Skip any leading slashes */
-	while (cmdline[i] == L'/' || cmdline[i] == L'\\')
+	while (i < cmdline_len && (cmdline[i] == L'/' || cmdline[i] == L'\\'))
 		i++;
 
 	while (--result_len > 0 && i < cmdline_len) {

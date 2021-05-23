Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6341238DABF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhEWJse (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhEWJsb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 05:48:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F59C06138C;
        Sun, 23 May 2021 02:47:04 -0700 (PDT)
Date:   Sun, 23 May 2021 09:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621763221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bure5Qg1NJmOySkFDDQUoAasHVVdJwha0wlu56c/Cg=;
        b=u7fZVB7fUyO0Q0F/awpvldBWwzGm81/qN9FSlNH1qE2rxCooEdv8k+rdv3fw1LAsYqoZWb
        mGiBnPy2dtR3uoxxfknkEfjNKeaNzaFBKe5XS4opi0Q35Prk080I6dAYEyBDz10iscSRjh
        XGmya3dmHRxAuTX8g70L6uvujEbHnlP2vciFMw521Wu9OZSdu57XM0ihaYWSU445yzk4ht
        hMOkIKkRWfjjkGDC1HzrG/0t0u/NR7uc7l8HmD9pdBqxXkUszmGWHWLDMZhm7Ber/RKwxU
        bSG0fmc1IzlFSwHTyVUzx4ROid9cblAZ39BKwHHbY4pQjdPCAcKoN8qY9k/fXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621763221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bure5Qg1NJmOySkFDDQUoAasHVVdJwha0wlu56c/Cg=;
        b=EKI7WdZkQwNIdw4altL9MASrIbSIN5QOjL9N9HjDkSEn1+w5Tgykgq6cp4MasLCHqbROoM
        iBfclPYLJKDErRCQ==
From:   "tip-bot2 for Changbin Du" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/fdt: fix panic when no valid fdt found
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176322081.29796.16823399891747450104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     668a84c1bfb2b3fd5a10847825a854d63fac7baa
Gitweb:        https://git.kernel.org/tip/668a84c1bfb2b3fd5a10847825a854d63fac7baa
Author:        Changbin Du <changbin.du@gmail.com>
AuthorDate:    Wed, 24 Mar 2021 22:54:35 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:03:42 +02:00

efi/fdt: fix panic when no valid fdt found

setup_arch() would invoke efi_init()->efi_get_fdt_params(). If no
valid fdt found then initial_boot_params will be null. So we
should stop further fdt processing here. I encountered this
issue on risc-v.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Fixes: b91540d52a08b ("RISC-V: Add EFI runtime services")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/fdtparams.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index bb042ab..e901f85 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -98,6 +98,9 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(name));
 	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(dt_params[0].params));
 
+	if (!fdt)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
 		node = fdt_path_offset(fdt, dt_params[i].path);
 		if (node < 0)

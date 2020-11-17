Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C522B6C80
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgKQSDN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgKQSDN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28164C0613CF;
        Tue, 17 Nov 2020 10:03:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/dJMwqo7xhCBqTBeXGaMj6Ru9Srug3/W1FhWiQG36o=;
        b=YiYtxCZKotXhalnfzkaUnfGrGQTP1/7QtprNPEukiKQUz1caSxJ6q5jYf3cu2jGxY0WZCt
        /S06w+F/VH6UwmbiO/RlhY33mDXulK18vxvvP9u4SYtgH+12rn5A4I6RVe2rbU+2nq4w6O
        4uWT949sIUOAkS3kFFWfPIQwLMlEi+bvLIYcdfUrASqVmpb4MMw7z1xAv/aRiunaIhUJOs
        dsBg0W5BvoUNjcfQQZFhXeJ5wNYF8j6p2RthspiBbn7RpmMVHgEA651mWSn7ROjTjxkoUW
        Cly00ySVAcV2fKZBcjQ7VYWKoz7sc0PlSimk9B0M1P1oFXdeuP7rnsE0OptLew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/dJMwqo7xhCBqTBeXGaMj6Ru9Srug3/W1FhWiQG36o=;
        b=uiTgXwCRdjSgqU4WWuOidcN9cRFoYLlEsjNSu5jtga660KV6ejle5/vVk/AqCLbtu0O49g
        VSss8Ly9eyhWCiBw==
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub/x86: simplify efi_is_native()
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201003060356.4913-1-xypron.glpk@gmx.de>
References: <20201003060356.4913-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Message-ID: <160563619080.11244.12370946188022666812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     bc13809f1c47245cd584f4ad31ad06a5c5f40e54
Gitweb:        https://git.kernel.org/tip/bc13809f1c47245cd584f4ad31ad06a5c5f40e54
Author:        Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate:    Sat, 03 Oct 2020 08:03:56 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 26 Oct 2020 08:06:36 +01:00

efi/libstub/x86: simplify efi_is_native()

CONFIG_EFI_MIXED depends on CONFIG_X86_64=y.
There is no need to check CONFIG_X86_64 again.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Link: https://lore.kernel.org/r/20201003060356.4913-1-xypron.glpk@gmx.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758e..7673dc8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -213,8 +213,6 @@ static inline bool efi_is_64bit(void)
 
 static inline bool efi_is_native(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_64))
-		return true;
 	return efi_is_64bit();
 }
 

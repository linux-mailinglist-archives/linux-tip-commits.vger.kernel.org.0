Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5192E7F83
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Dec 2020 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLaK4m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Dec 2020 05:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgLaK4m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Dec 2020 05:56:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E85C061573;
        Thu, 31 Dec 2020 02:56:01 -0800 (PST)
Date:   Thu, 31 Dec 2020 10:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609412158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9l4NYNkHeIwYhfUb6xf0Hr2J+phvqyh0MkfowZtrlM=;
        b=X7ZtAoKKCRWzMfqcyCBxUJJRuuJ0j7061xKvN63/glerlKRkPu1J4oGhHQ21Y8lewiGwlr
        7XdeE54rG0IjdExfBZMIWc2acbyoCsP58M0xbh327N1QsKnk35HDgfYo60/S/TIHIJEBkI
        XeMlbQrjsmz+LK3uKTLsRJFkxEg2GVTuLt44dcHB8a/1oUSJZI/znPDMs81yt75hRBfm45
        CeOxNpMcjM0JSmiGTtbIh2YO8X/WCiWfdW+O3CL9UjNb6MQf5RH4x7o/EglLznAlid76GD
        gLSnkCzWTc9V9u2RFm6J3fTNbFgxD9dZuh4H14J82pU30NRY/7ZRJhHVQBDlEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609412158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9l4NYNkHeIwYhfUb6xf0Hr2J+phvqyh0MkfowZtrlM=;
        b=PIKXpRPAhosQKdtTJxffmRMjoNO8vhFjhcepoN3WKKeVYQeYmQClo/PhMVgRnjT6mjcQj2
        m3VibFoxrgtilxAA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Make microcode_init() static
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201230122147.26938-1-bp@alien8.de>
References: <20201230122147.26938-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160941215697.414.16193539333675237267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c769dcd423785703f17ca0a99925a7f9d84b3cbc
Gitweb:        https://git.kernel.org/tip/c769dcd423785703f17ca0a99925a7f9d84b3cbc
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 30 Dec 2020 11:20:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 31 Dec 2020 11:44:00 +01:00

x86/microcode: Make microcode_init() static

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201230122147.26938-1-bp@alien8.de
---
 arch/x86/include/asm/microcode.h     | 2 --
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc53..ab45a22 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -127,14 +127,12 @@ static inline unsigned int x86_cpuid_family(void)
 }
 
 #ifdef CONFIG_MICROCODE
-int __init microcode_init(void);
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
 extern bool get_builtin_firmware(struct cpio_data *cd, const char *name);
 extern bool initrd_gone;
 #else
-static inline int __init microcode_init(void)			{ return 0; };
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ec6f041..b935e1b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -830,7 +830,7 @@ static const struct attribute_group cpu_root_microcode_group = {
 	.attrs = cpu_root_microcode_attrs,
 };
 
-int __init microcode_init(void)
+static int __init microcode_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;

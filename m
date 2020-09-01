Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6252591E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgIAOyw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgIALs0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBADC061244;
        Tue,  1 Sep 2020 04:47:56 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnzrFDElcMIXBmmpWISTaHQffUOMdRcuKTQGE2TGxh4=;
        b=XWfkwZDq+m2Jt+Vn7Leuxr8ybTKozfJkOJt3VdfN4cF9mR+U3miFsBkdW5eyfCiPv9WK83
        Ig4M7P6jBYgO5ZKFfGidAEHLvtdeow5lA/PtKIe5Lfj1mlLSLDnGitGaLen76JrLr0pECn
        aY0p8z+SP8oSK/kOFPC8hEhBhGC5wlzu7RRhfveZJxKhpq91dDbcfpkQPyWOcc5GMolNc1
        OkCrpW8Yb+uP5IL2JI+DiOZgkjqL4elaEICNxWLIUWQqNxQ4IT9VK3w5E8wUCxrLDVdSNl
        U5Fihzo7+76ZKkjEw2QIRRK/ClO4wdrKkXzFK3yr3zlbsaJU1ojYpZgnYEimsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnzrFDElcMIXBmmpWISTaHQffUOMdRcuKTQGE2TGxh4=;
        b=IbiWpHiuW7sCLWhmHGv7GJ+uaKnGKdcCjZnkTbIJwVzPVz1f6CQDZZO/A+GyLcyF4nel70
        59NVgKBfDmg79gDQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/boot/compressed: Reorganize zero-size section asserts
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-27-keescook@chromium.org>
References: <20200821194310.3089815-27-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087310.20229.16110579156173953333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     7cf891a40057f851af74e68bacb01b90bd775b5d
Gitweb:        https://git.kernel.org/tip/7cf891a40057f851af74e68bacb01b90bd775b5d
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:07 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/boot/compressed: Reorganize zero-size section asserts

For readability, move the zero-sized sections to the end after DISCARDS.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-27-keescook@chromium.org
---
 arch/x86/boot/compressed/vmlinux.lds.S | 44 ++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3c2ee9a..ca544a1 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,19 +42,6 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.rel.dyn : {
-		*(.rel.*)
-	}
-	.rela.dyn : {
-		*(.rela.*)
-	}
-	.got : {
-		*(.got)
-	}
-	.got.plt : {
-		*(.got.plt)
-	}
-
 	.data :	{
 		_data = . ;
 		*(.data)
@@ -85,13 +72,34 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
-ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+	.got.plt (INFO) : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0 ||
 #ifdef CONFIG_X86_64
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+	       SIZEOF(.got.plt) == 0x18,
 #else
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
+	       SIZEOF(.got.plt) == 0xc,
 #endif
+	       "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got : {
+		*(.got)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
+	.rel.dyn : {
+		*(.rel.*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
-ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
+	.rela.dyn : {
+		*(.rela.*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+}

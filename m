Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD1264207
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIJJb2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgIJJYe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E9C0617A9;
        Thu, 10 Sep 2020 02:22:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/cHqJGm+j19Hxy0n3R6mobJN3l94JBylmyoaW+FXKU=;
        b=eZ+kiJT+6f0z4Ren1itsFV1svsPRsWMdWxtVhRTPFqT3TEJpRlFR5PqEv49FmnDUewakAY
        CdZXKXbkC+JjpO/x6Hcp7lzCfl/m4MGt9au4PmeRKt3AQxb+BR0XPq62Pymf86IUHtIu+c
        XGA5xH6jAUejG+4d5ZNxqrD0T5YqU2s9gdCNlQ3AN4lZBYFGO9DN4cTUuXokufCzRwOFu4
        9lb1/EKs30Yd3noUL0k3yMxYbFLn+zuO1MOEV9qHPGC4WtqmN1yTplvUWieDf7KyQarYtf
        1O9kIFIb5IRGXNU197aPw7Jrwghd3ik5FOgvVJ34dbd8427fbnUJjKkPXUkPCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/cHqJGm+j19Hxy0n3R6mobJN3l94JBylmyoaW+FXKU=;
        b=MFBtpEhZJ+mj3hgYZGPlK6hZzqECY1IZuakdV1s0mBYxFELAthvBgZ8R4dFXupIMMbMv59
        gt4JJcagOd5UKIBA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Print SEV-ES info into the kernel log
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-38-joro@8bytes.org>
References: <20200907131613.12703-38-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973685.20229.7767006910607714070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     c685eb0c12b4d4816d22ee734e91f4005b152fcd
Gitweb:        https://git.kernel.org/tip/c685eb0c12b4d4816d22ee734e91f4005b152fcd
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Sep 2020 00:38:01 +02:00

x86/sev-es: Print SEV-ES info into the kernel log

Refactor the message printed to the kernel log which indicates whether
SEV or SME, etc is active. This will scale better in the future when
more memory encryption features might be added. Also add SEV-ES to the
list of features.

 [ bp: Massage. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-38-joro@8bytes.org
---
 arch/x86/mm/mem_encrypt.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index a38f556..ebb7edc 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -407,6 +407,31 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
 
+static void print_mem_encrypt_feature_info(void)
+{
+	pr_info("AMD Memory Encryption Features active:");
+
+	/* Secure Memory Encryption */
+	if (sme_active()) {
+		/*
+		 * SME is mutually exclusive with any of the SEV
+		 * features below.
+		 */
+		pr_cont(" SME\n");
+		return;
+	}
+
+	/* Secure Encrypted Virtualization */
+	if (sev_active())
+		pr_cont(" SEV");
+
+	/* Encrypted Register State */
+	if (sev_es_active())
+		pr_cont(" SEV-ES");
+
+	pr_cont("\n");
+}
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void)
 {
@@ -422,8 +447,6 @@ void __init mem_encrypt_init(void)
 	if (sev_active())
 		static_branch_enable(&sev_enable_key);
 
-	pr_info("AMD %s active\n",
-		sev_active() ? "Secure Encrypted Virtualization (SEV)"
-			     : "Secure Memory Encryption (SME)");
+	print_mem_encrypt_feature_info();
 }
 

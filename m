Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7B340E4E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhCRTer (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhCRTeg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:36 -0400
Date:   Thu, 18 Mar 2021 19:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e31gjRno2hn4mq6TfBWcy767Vl4WgSoJf957HRxfQ4A=;
        b=T9qHpG8qQwTwpE3qQEMAQN/t1KA5EQkG5C/s0Ka7FgcwmNwgDPvtiK8p+YaS8qReYMbRRy
        pxGofiH30nsLn6wrQvZrYKed6MJn/NhvrQi9ThHtI61PlYyxiI7e8mNvZG1iseySBEyO+A
        PYx/n30ptUMhyKop5mhGZJTDDu2YiY6PgSI2UP91ImOAmurFabBQBf1vQr4CLVzvKeiYQp
        dnsZOkELCDd8dA/ewMxHxDnMsJ25maoBnIik99cG9/PZt6Lc6bINcndbsu3BmyyY4npC21
        ivV5fawgjk4nVoJKi/e08o/6ooMBsrP1YiQZS+eiGxK2SXrgmwq9Q4e5g3b7WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e31gjRno2hn4mq6TfBWcy767Vl4WgSoJf957HRxfQ4A=;
        b=7wgs0So1BqepqwP2NTtvgrXSZVHg4zakPNL2i6opzzyvQCDQCil0ustfH9xw6NT/vpo9Sb
        kJ3uhcAul5DJsrDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Reload CS in startup_32
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-4-joro@8bytes.org>
References: <20210312123824.306-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607491.398.1040399144606674357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     0c289ff81c24033777fab23019039f11e1449ba4
Gitweb:        https://git.kernel.org/tip/0c289ff81c24033777fab23019039f11e1449ba4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 10 Mar 2021 09:43:20 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:43 +01:00

x86/boot/compressed/64: Reload CS in startup_32

Exception handling in the startup_32 boot path requires the CS
selector to be correctly set up. Reload it from the current GDT.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-4-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f..c59c80c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -107,9 +107,16 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %gs
 	movl	%eax, %ss
 
-/* setup a stack and make sure cpu supports long mode. */
+	/* Setup a stack and load CS from current GDT */
 	leal	rva(boot_stack_end)(%ebp), %esp
 
+	pushl	$__KERNEL32_CS
+	leal	rva(1f)(%ebp), %eax
+	pushl	%eax
+	lretl
+1:
+
+	/* Make sure cpu supports long mode. */
 	call	verify_cpu
 	testl	%eax, %eax
 	jnz	.Lno_longmode

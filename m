Return-Path: <linux-tip-commits+bounces-25-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520EB811238
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 14:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083D31F2143C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A222C1B9;
	Wed, 13 Dec 2023 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLSslS5I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycDsrcYy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C046FE;
	Wed, 13 Dec 2023 05:00:04 -0800 (PST)
Date: Wed, 13 Dec 2023 13:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702472402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+IhSpyWTQ/axW+CWLsdfkEGbDn1Jz0prTjI1ZqS1To=;
	b=NLSslS5ICLrIG0BxDdoCbbqWBzKURefiIdkAqp6AELB3x5kzY4lWsUyRN7BicbAdIU3P5r
	aeFGCVmK3Md/cgpu/PO2HltA7v6oi0PU5hWwao0rvj18HBA6yctmmpeKjIq4A3XJ6vXde0
	DEQuAKfPyKuwUMBsM34WdojmVhTp5X/8WjsrODHpRJEkkJfOypVwGuYYhMuacU857nR5tT
	K+LP6/YxDFTHdAGvXLTTm4F2N/amBoBlnmQDGq//NofKk+oSgmU4Hh8kzKw42WXyeeQLAC
	aiRIq3LUSFICZrBAFqisMau5uGVjs6BDccWjQhDcG3w72hQb+7qR9ngoDjjK7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702472402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+IhSpyWTQ/axW+CWLsdfkEGbDn1Jz0prTjI1ZqS1To=;
	b=ycDsrcYyqZcAmxl5g3k2nWUHrcDtAlf3ykcleR3oWS7Olx3enzWBCxQmyj8+7/DezZ37So
	uPg3HAvwqWdZQCDA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/head_64: Use TESTB instead of TESTL in
 secondary_startup_64_no_verify()
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231109201032.4439-1-ubizjak@gmail.com>
References: <20231109201032.4439-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170247240126.398.13145604902928035582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7d28365a06af74cee015a448d32ab6e98cd05cfb
Gitweb:        https://git.kernel.org/tip/7d28365a06af74cee015a448d32ab6e98cd05cfb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 09 Nov 2023 21:09:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 13 Dec 2023 13:35:38 +01:00

x86/head_64: Use TESTB instead of TESTL in secondary_startup_64_no_verify()

There is no need to use TESTL when checking the least-significant bit
with a TEST instruction. Use TESTB, which is three bytes shorter:

   f6 05 00 00 00 00 01    testb  $0x1,0x0(%rip)

vs:

   f7 05 00 00 00 00 01    testl  $0x1,0x0(%rip)
   00 00 00

for the same effect.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231109201032.4439-1-ubizjak@gmail.com
---
 arch/x86/kernel/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3..1f79d80 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -182,7 +182,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Enable PAE mode, PSE, PGE and LA57 */
 	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
-	testl	$1, __pgtable_l5_enabled(%rip)
+	testb	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
 	orl	$X86_CR4_LA57, %ecx
 1:


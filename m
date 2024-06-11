Return-Path: <linux-tip-commits+bounces-1364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9919041DF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416C61F2611B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335547F4A;
	Tue, 11 Jun 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9VSpfXm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbjelpBo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBA47F53;
	Tue, 11 Jun 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124836; cv=none; b=RbU8HuqcMcQwwYZM0rkqEiFvBEYyEK6+3LFCY8muCdbbi74CVg+ySVtEq6LXMT/Y+ujekbMZ1Psk2hPkaIAsnh5ilkT53yqtOamtpUw5dyXvTjSjOyex+TVXu+oeldDLySGfIlKXJNTdhv1OarkxxOI0MnjeWpTizexE/xb0ScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124836; c=relaxed/simple;
	bh=+NPcMB/845R3obyO5M7tbuqRotnBSF6jqQtQ8LzI0DA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KrjNDBT/mv+9Jve5ivyvbb3zGFKyZJcnmc5SbRe2VYicepLFW/16EjsUy6oX3NptgpeL9b2M5+RS0WBmFhwdJ3Wx5HJLd82V4qeq6lMhjgSe66PwLQJT/465vb+briSBM3TXwdGZsUUse3uUW20pFY8ov3AUGjL24m5H5UxEWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9VSpfXm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbjelpBo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWVck0F7jHjPkm+0mt2ZMDowoyS7SozV0qca6O2MP/c=;
	b=Y9VSpfXmOGUL1HnG/tkGLX+eUlppbWTjwZ6MZsRxhsIZGZy75M5lYRTBbggXob8InGwnSK
	DT2kZfbdITa16ahKujU1d12jgVwl30ITxMHFx/CsmhvCaV4Hh8yvQru5lQoXF2ZeaLNxIZ
	Y7CFdEH8Y8C1om2NSq7agxSWzuUSw7pQKrxDmKsKJfM127Cg7PTl4Dt00MTlHrxbv/5d7k
	vre4n44km+cMp2S2nJNhd6aHd2HwwaRfnO88oTcS8l7K9pyofAhR7d5SyLTeDqqj/bixhK
	V2JBJniPZbSeQe1piBMFAINubTKO8fsKpoEHyr/3KKUfsY0mwiCKSxcesZL1tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWVck0F7jHjPkm+0mt2ZMDowoyS7SozV0qca6O2MP/c=;
	b=zbjelpBojg4UQlADY9PIOtYzO7MoEhoue4F3wjMl2MfeC/Kh7OAKuaQUfdv9GnXdSryMaq
	ezwKp0pLu4yo8bDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert the asm
 ALTERNATIVE_2() macro
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-13-bp@kernel.org>
References: <20240607111701.8366-13-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482736.10875.10703597859783829646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     08a621fcf4a4a4d765315ffe6a28f5d31e8237b2
Gitweb:        https://git.kernel.org/tip/08a621fcf4a4a4d765315ffe6a28f5d31e8237b2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:27:14 +02:00

x86/alternative: Convert the asm ALTERNATIVE_2() macro

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-13-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 31b9a47..28e07a0 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -461,28 +461,6 @@ void nop_func(void);
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
-.endm
-
-.macro N_ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
 	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
 		      \newinstr2, \ft_flags2)
 .endm


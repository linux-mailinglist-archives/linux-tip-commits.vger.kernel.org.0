Return-Path: <linux-tip-commits+bounces-7988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E7D1E325
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6283430BD0E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E9393DE3;
	Wed, 14 Jan 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZdnXLFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvRt/Jad"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CB393DFC;
	Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387217; cv=none; b=H698mR436J5q9l2kU5rbsj3xb3XV5Qg5ua5H67rFfPWAI/wzEnzDJ8ru4FzmQxW8Nzx+bXKMJO2ICcDKnbDJUt4Ycz/xTGcVsGoL7djewGTYIqhuNWdTDvBRMsM9f9h+8DWxWivQtTpxH1Coq0TRHeYQKO7sxXni/Ljh0QgCySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387217; c=relaxed/simple;
	bh=FYdtCA53gSdwpbsJrWXt62enwTab/icCRwY+g4Kie3s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kR6BdoitJXOpO1dkh4b2wwdVxs77B9cL/cVg5q+IhMuoRyxV6HiEb50KdPEiQjhBRCYAuPNTbZti4Wo8FjOYi/po/93RY1CKg/SD5dEGYCfzTiYlo6gVKMBC3Djmu7yIxbihkR/Ko6pWbBy76zJLNADUh1KBjL+5DgjMOPmNUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZdnXLFl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvRt/Jad; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+nG9Y/FNJjkPj5eLZ3BSYG7fM01y4c08tWL4GgkVnA=;
	b=LZdnXLFlq7+sfm9QmksZHSvCOMCBeeTMpKyKd2Zf0m0nHdNHIYZnWft131Dfex9/mHme2x
	ae2hG3sBz9K6DrLPnES/BjB4Q+JiZnkENPlkhD6mqAUR8rjSwbomovKe7GLl+lssW7AgEC
	JNajp2p+Y2QC4iVMm6faoqwljxz2saLQ4aHg6mbkSlvb5wit+f3RWKeVHgDf+LkrtVjS5S
	Z0/f4+1y+UVIeL8I25O+Mc4PSJyGT2TPJCWmIbRdOGHj35L3DD/DBv9g1BTBksysvcTPcN
	o1aJrZC4u3TihggT8c06EpTZNNxynTMX0YSnG4SvioPOotsvQvv/L5+7SnSYaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+nG9Y/FNJjkPj5eLZ3BSYG7fM01y4c08tWL4GgkVnA=;
	b=ZvRt/JadpM5+jlsP8lbDbHnW6MDN9RSfdcboZxWNTU9hahUzDUefyxuQ6KQcmxKeqoqzND
	cn3u7UESvVtTlhBw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] x86/paravirt: Move pv_native_*() prototypes to paravirt.c
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-15-jgross@suse.com>
References: <20260105110520.21356-15-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720847.510.17757661066646857592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     574b3eb843dea1ad99162e115abdb610b6780cbd
Gitweb:        https://git.kernel.org/tip/574b3eb843dea1ad99162e115abdb610b67=
80cbd
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:13 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 19:14:06 +01:00

x86/paravirt: Move pv_native_*() prototypes to paravirt.c

The only reason the pv_native_*() prototypes are needed is the complete
definition of those functions via an asm() statement, which makes it
impossible to have those functions as static ones.

Move the prototypes from paravirt_types.h into paravirt.c, which is the
only source referencing the functions.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105110520.21356-15-jgross@suse.com
---
 arch/x86/include/asm/paravirt_types.h | 7 -------
 arch/x86/kernel/paravirt.c            | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index d7c38e5..0d8ea13 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -480,13 +480,6 @@ extern struct paravirt_patch_template pv_ops;
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
=20
-#ifdef CONFIG_PARAVIRT_XXL
-unsigned long pv_native_save_fl(void);
-void pv_native_irq_disable(void);
-void pv_native_irq_enable(void);
-unsigned long pv_native_read_cr2(void);
-#endif
-
 #endif	/* __ASSEMBLER__ */
=20
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4e37db8..5dfbd3f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -45,6 +45,11 @@ void __init default_banner(void)
 }
=20
 #ifdef CONFIG_PARAVIRT_XXL
+unsigned long pv_native_save_fl(void);
+void pv_native_irq_disable(void);
+void pv_native_irq_enable(void);
+unsigned long pv_native_read_cr2(void);
+
 DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
 DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_irq_disable, "cli", .noinstr.text);


Return-Path: <linux-tip-commits+bounces-1439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19890C850
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA23128C7EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11533200064;
	Tue, 18 Jun 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pD15Vubf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zB0LqEQq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DD21C183;
	Tue, 18 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703909; cv=none; b=cqLyh6jbJZ08ihfeVFt10EVcAjzt7CkBJ4ERVwfiMKDU9OlawVfG2ka5ToB1G+H/F0u4iFvP16MYYLcYWOfjUkAmHY8U0h+WMw04EQrGf+BaEmBAtUtV+fLSGVER49f8M57YP/MKSvmVL9ENb9kME/Wa9636SLZZkSEjW40MZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703909; c=relaxed/simple;
	bh=7vxvTcGfaBiVrHvJ/7N01XRBlK+N5QP6C1o5YZa5uvo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q+0TS8YEd1se5eL0ygW0LvbYqTtxIIGiDY1N/FDJGU+2htSYZTynVzjbdiqEukDXwla+8EHMAJ5osbnNV0MDcllTvuIP4dshS3bmhJbmqv4oABWqRTvqwvHwGp1koTEiF1cSzQKGRI6UXIqO+0Z+6YCAO70POwnzpKzQ08aNamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pD15Vubf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zB0LqEQq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:45:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li/ZTr2w607cWg1zaNZqovofTEt+6NiuZE7G3KtZgzQ=;
	b=pD15VubfdZw9TgQnvyIhx7/ej0L0HrJGpC+O4lwzkNNpPAB9RyKvSnLGG2lsWi370rsYK5
	zTOnn54CW/gYOnWhaV1Q29hpAK8Rv6AEDFdxAroSPkt4bRX9/00BJxrA9WxTTLBnHTNMrC
	2p/cpR/aKn7HFK+RLS/yiGiUk9TDtjGfTl3Vv8qzCC7irs3n724aUOLOXhqp+ESSKs5tIy
	D4llYPgwBPhD7O64ZNKhAqppRzss7HXAwoMONy9NgD+XnhCY0zsJijg9OOAM42VLKlFGNu
	BW6wp0vWXdfm+k0mAchnqukA/pqtjtN7Kgn1rJrjj2oiRVdG5ssFbgKIisbH5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li/ZTr2w607cWg1zaNZqovofTEt+6NiuZE7G3KtZgzQ=;
	b=zB0LqEQqRQIAYOvhrtJU/7godpNYAH0FtQF2CboEh5aFLIHVctis0mKhHvSELHjVdFN8Uc
	YReGl5r/c6SMj3AA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/irqflags: Provide native versions of the
 local_irq_save()/restore()
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc4c33c0d07200164a3dd8cfd6da0344f57732648=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cc4c33c0d07200164a3dd8cfd6da0344f57732648=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870390131.10875.13747462976569501585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     b547fc2c9927a95808ef93d7fbd5dd70679fb501
Gitweb:        https://git.kernel.org/tip/b547fc2c9927a95808ef93d7fbd5dd70679fb501
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:44 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 07:22:46 +02:00

x86/irqflags: Provide native versions of the local_irq_save()/restore()

Functions that need to disable IRQs, but are common to both early boot and
post-boot execution, are unable to deal with paravirt support associated
with local_irq_save() and local_irq_restore().

Create native versions of these for use in these situations.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/c4c33c0d07200164a3dd8cfd6da0344f57732648.1717600736.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/irqflags.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c5ae64..cf7fc2b 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -54,6 +54,26 @@ static __always_inline void native_halt(void)
 	asm volatile("hlt": : :"memory");
 }
 
+static __always_inline int native_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & X86_EFLAGS_IF);
+}
+
+static __always_inline unsigned long native_local_irq_save(void)
+{
+	unsigned long flags = native_save_fl();
+
+	native_irq_disable();
+
+	return flags;
+}
+
+static __always_inline void native_local_irq_restore(unsigned long flags)
+{
+	if (!native_irqs_disabled_flags(flags))
+		native_irq_enable();
+}
+
 #endif
 
 #ifdef CONFIG_PARAVIRT_XXL


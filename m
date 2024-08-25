Return-Path: <linux-tip-commits+bounces-2111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1595E3C5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D37F2819D6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149613D890;
	Sun, 25 Aug 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMMReQ51";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oq4hHHwl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FA2AD15;
	Sun, 25 Aug 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595128; cv=none; b=GZzhkNGpmWCRc3a0JIo9dW24aslhPdkONtjPWgXvmkmF0WhAZ4z9yCDigVKiNMpCv+EDhZyfqMfAPpag5crNShlsOUcfwo/IZ2gZSPV5WKpNksf+5Ev8w+jMV0XT2gg4DKufmxBCcdWeWqz/9pIDNKUmARr513JekfVOtxpbPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595128; c=relaxed/simple;
	bh=nlut8vKsFc0JMCDfvCdexmiw+J6OA4qbqKaIUuC4yCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eNcehh5+3AF8j/H3ZBnW6SYEbJPV/D/sOovcbbC8oXPtshe05Uwn5gmBrpuCw6RobTVh4BTozwo7hen0SjoXCnQehY7aZp62v7HjTsPvoKNgC0q1qt1+NBKlpNam5tZCbYkqtXOH34eA/5/R/4A8DwKe+sJmwZJJCJ2Vnoh3Izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMMReQ51; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oq4hHHwl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724595122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqI4IVHyfwu8vsK9CD4QaMudH7OwCD6VmsWdr91d7Zk=;
	b=YMMReQ518k2HYowMcq3b9qnHt4t+Jv2d5Ct5BVfzWqyzU/ncAmSJQF0CdYnlRscT5HrxyL
	jhe0EO163y8NROy9lEjs1FEMPnAENype7Gu1mPWEwNyTAh5/wtQq1k+w1psiW/egIACvT7
	+6CYn94GiSY8MeEhDSxRRnrqH32KfeuRG0wjdpk8iNCa77nK6AzBnhiCOknn6FwFrASilj
	ul8CnEUWTFf8x7JYuk6t5HFes69blolqSk5qrt6y75nbzTuPH7DX0MswJa4y8c11f5ky2i
	2ku9oPTY779Ui8Zic2miIEfdQ49YBl8Ilb2TFjW9vsZGLtBrNQrwS4dI9l8fmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724595122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqI4IVHyfwu8vsK9CD4QaMudH7OwCD6VmsWdr91d7Zk=;
	b=Oq4hHHwlvdq/oK8Uw5L50t4nHm+vzncq92UeeJHQcG3eWDuJZ8KgpyR69eyXBZ2ScDRv4k
	oOt/xEOFjSwtzwCg==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/extable: Remove unused declaration fixup_bug()
Cc: Yue Haibing <yuehaibing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240816102219.883297-1-yuehaibing@huawei.com>
References: <20240816102219.883297-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172459512215.2215.10248995476587682569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cc5e03f3be3154f860c9d08b2ac8c139863e1515
Gitweb:        https://git.kernel.org/tip/cc5e03f3be3154f860c9d08b2ac8c139863e1515
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Fri, 16 Aug 2024 18:22:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 16:07:51 +02:00

x86/extable: Remove unused declaration fixup_bug()

Commit 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
removed the implementation but left the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240816102219.883297-1-yuehaibing@huawei.com

---
 arch/x86/include/asm/extable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index eeed395..a0e0c6b 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -37,7 +37,6 @@ struct pt_regs;
 
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
-extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 


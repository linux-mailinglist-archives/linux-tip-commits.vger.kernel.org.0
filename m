Return-Path: <linux-tip-commits+bounces-282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52ED8449B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E101C2339F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093483BB50;
	Wed, 31 Jan 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2iCzgw6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NixLpVIQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BF3B1A0;
	Wed, 31 Jan 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735692; cv=none; b=ryyPSgntSPgdM0UUpJ4l8AgB9viqRxTr9HjjYgFwzIsAM0xGx4i4uHNojZtfhgD38Dd1emqTIeAREbnwnjg9ReKLLA5srrvjTW2JktZz9K0t0RlmThSvJFYNBhC+w7TpOS2f4nJtCQ22ThdxtYucLEKRkqW78cVI742GwXboWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735692; c=relaxed/simple;
	bh=T2J7RmZjxcIanokRfrdWhAhrG0OvSXw5EcXG4Zo30NM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eulxixVYxwzfuXc+0PNH3HF+j13fsI8R3WIti9V3VtjfU5yjbAk3oJERVcXO47tv11dVewuLRnM9Ql3TMeT4T0lC1SB0cpE/kk1ZBc6PG1O1WvL3EBFkEAZP1oTAyl2Vpu8DPKKLPxQ39rXn04ib5M7tBnHZ9efLorxz6C6Y9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2iCzgw6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NixLpVIQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rwFPhRWusT+2qo5r55A9Fiq7u2ixEyco1fGG8zRSbQ=;
	b=P2iCzgw6qeFYvdvn2uRHEdcwMQbuui0hB/Fzc6Oq5wnHPK/aF4A48n5IBh4xDufE5kfYGC
	pfPXmHsEM0660IaGLSW+FYzKS+JlvmuPJqgBtoijgB59e1FjzW5NOBfWhPf59CtBDmGL2T
	GW1SLNvW8ciF1JJDP9YkSbxbs8k76wzJSTeYUUh4v6TDhz6Wb6GTcAcowtqyiOYTwzGV1v
	nZ7TK8peGk+MJR+QATqIpxFXzkdXxRKWSR3H6oXof8knou3TsKJOevKXaz1FVPvjas3L/w
	g1+XrzWtE4mCgzqzc+m8p17BJxBxvgG993BmNHWGNFO1tI4wGcolWLxY7LpOAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rwFPhRWusT+2qo5r55A9Fiq7u2ixEyco1fGG8zRSbQ=;
	b=NixLpVIQcyKBfgmjYcAyfqnAGMmpfjgkRYVegkbZGQLXIE5XCKVWSDWehVODrrIKE+NQcU
	o8nFl5Fv/BOjcnCA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: No ESPFIX needed when FRED is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-20-xin3.li@intel.com>
References: <20231205105030.8698-20-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568870.398.7853288615116409390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     df8838737b3612eea024fce5ffce0b23dafe5058
Gitweb:        https://git.kernel.org/tip/df8838737b3612eea024fce5ffce0b23dafe5058
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:08 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:01:51 +01:00

x86/fred: No ESPFIX needed when FRED is enabled

Because FRED always restores the full value of %rsp, ESPFIX is
no longer needed when it's enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-20-xin3.li@intel.com
---
 arch/x86/kernel/espfix_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 16f9814..6726e04 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -106,6 +106,10 @@ void __init init_espfix_bsp(void)
 	pgd_t *pgd;
 	p4d_t *p4d;
 
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* Install the espfix pud into the kernel page directory */
 	pgd = &init_top_pgt[pgd_index(ESPFIX_BASE_ADDR)];
 	p4d = p4d_alloc(&init_mm, pgd, ESPFIX_BASE_ADDR);
@@ -129,6 +133,10 @@ void init_espfix_ap(int cpu)
 	void *stack_page;
 	pteval_t ptemask;
 
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* We only have to do this once... */
 	if (likely(per_cpu(espfix_stack, cpu)))
 		return;		/* Already initialized */


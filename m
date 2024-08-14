Return-Path: <linux-tip-commits+bounces-2049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28256951985
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 12:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE046B22979
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297A13D524;
	Wed, 14 Aug 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVhbgg6U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxQpfr9q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EFAD5A;
	Wed, 14 Aug 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633166; cv=none; b=pwM6Rfe1ibjLXALJu8U2gQaE8SBf2bBL9RDrSl7g9Ri2dm9bJwW/3V/RgAEsXJ7O8vJuSxf/dg2Mc4oSOmpcoY8nNDMFb3JbO2mO26QHThmAbDRHSyxaa5LNiqybyakNHoEp7BLRxOv+03EZY2lN8j80yr8Yz7egTXyFFapGaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633166; c=relaxed/simple;
	bh=0IZQ1fQIihhxg9831hBdaDdg64hb2jHVuHxJTPdbot8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PtGKlxJr3qKog1fGJsEigcyZ163Q7QZ9pL5v21eGeADajBSKDI6IHKSlpzyk95d3ID7lsj+t6WwFPmy5goZn3PNexd+5VYUIfbWzNCqAKhBqwpxwKMvEBYzazfVl//bLAFKbSG1xa6pnIrx1PJuxMJWdrltpvbbjbPFxLcQHWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVhbgg6U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxQpfr9q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 10:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723633163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS6NJnBpwH9ALMSVfzB9VXJbAYfoDUWFwvSDqX3wb5M=;
	b=NVhbgg6UXOxdKBOG7k86nMtHmTQ3jrPeQm08Jq/ZcQkbFsyN3MxQijmTdle1oMHwQR7Jt5
	yxVz2wPff7WHTxYjKBtUYI4ZHhcsWfbLxS2ZRNzFlfN0GWndPvntnbUm2CX8zvjdAJWP/r
	CMoVsI360gVv/Ri+vW1FI00Kme3VEINvpAZ/I+u3rnWbtBCTRvA6xOSbuNA9yieKbgVnYT
	hDtTrwwhVQuN0rwcfG3oIDJcp4bSrCIi1tWfaqaSjzUXxtZ53HBcqOHsrrgh0z8HUWL8cF
	AZpu+eGgiPnFq77g+dMOgCYN0EvePYdjk3BzLYT1r69m0ipDNBCU4jVLOzqQRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723633163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS6NJnBpwH9ALMSVfzB9VXJbAYfoDUWFwvSDqX3wb5M=;
	b=oxQpfr9qf91eNp2pBXYRR7wY8gIW1W68GE8cEGfEqg4PW2LHXiNpAsOnXrb8bvm7NS8HmW
	nySmTo9+MQh18EAw==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove unused NX related declarations
Cc: Yue Haibing <yuehaibing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240814031922.2333198-1-yuehaibing@huawei.com>
References: <20240814031922.2333198-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172363316258.2215.1864908698109295570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1aa0c92f816b3a136cc3a31ef184206a19fc3c03
Gitweb:        https://git.kernel.org/tip/1aa0c92f816b3a136cc3a31ef184206a19fc3c03
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 14 Aug 2024 11:19:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 12:51:07 +02:00

x86/mm: Remove unused NX related declarations

Since commit 4763ed4d4552 ("x86, mm: Clean up and simplify NX enablement")
these declarations is unused and can be removed.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240814031922.2333198-1-yuehaibing@huawei.com
---
 arch/x86/include/asm/pgtable_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2f32113..6f82e75 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -517,8 +517,6 @@ typedef struct page *pgtable_t;
 
 extern pteval_t __supported_pte_mask;
 extern pteval_t __default_kernel_pte_mask;
-extern void set_nx(void);
-extern int nx_enabled;
 
 #define pgprot_writecombine	pgprot_writecombine
 extern pgprot_t pgprot_writecombine(pgprot_t prot);


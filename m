Return-Path: <linux-tip-commits+bounces-2054-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215F9545FB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Aug 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1BB1C20DF7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Aug 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380815B125;
	Fri, 16 Aug 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WLgtebd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ff5FpV2J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CDE15B113;
	Fri, 16 Aug 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801432; cv=none; b=m/Z+dlq+Cq5EVBCDt3z83RjiONeba3RzGhzBWJ2ntzVDkYe+iRDgHHXsoB7zMr3aXP9LwXRUwowHX9X10B2eKQDNRTQpJWyQokKYBvzIiVjMzj24j81V8Rrg6450y8m6PkK63i3hTBMZKp5pEFJN1NAWVYpbe3O8lkng9BOOhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801432; c=relaxed/simple;
	bh=ngEnFU1tuCQqgX2VqoVA+THQmDNWi+l3KHO5927zEW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N0X/QSsDUDHurbAHtp09JVU8UQjG1ox5NxmsBNVPBJBYIMT/I82g8WdCJXg+i5oBSsI1MyEzszjR83PSv9304MUxdJZUQpKPokDeR8kAlG95dMGvrgKkiXNCNEXA0FSSTk1eRB9kmDv3OUavgoZZZl9uyC5RrKFs6uDoN1utHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WLgtebd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ff5FpV2J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Aug 2024 09:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723801429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yzj458T5jYc0hmWLivay4aqLc5Jd/2q5uWJE9WQFPmE=;
	b=0WLgtebdEGwze+tQFLLrNGZHL9m7+n2ujZirs66LKKV6DdhyT5wnvChimzjIRUf/stfr7b
	asEoDoXaoNnK64XC5LbhTFEPxJJaTisqbKLOu3hU7gptlb35aC8x4ahhInaWeimTyVxWnZ
	66baQLkOUvGnudBl8irUiyJgPAqGLZHaBQ6OPGDqW3BVv4UfxqQP9HTeDsD9wGYXb3V6RT
	4u+WiKAUxWhVB+ChfHmi51OozbjGPv3aXbDKzfrCLo+DwDRNL98jV3msp1UFsGLk3gb5WM
	HxXU8f5xqWNe1vu+mxGruKtb835fMMcgl5KGgoRpTOeA1Vi1FjuhlAzmfikczg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723801429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yzj458T5jYc0hmWLivay4aqLc5Jd/2q5uWJE9WQFPmE=;
	b=ff5FpV2J26rwOj7yPj9zvK9ANlGLA85SU1Cr5y0u7PyEcLm+7PprTmKsI2Lc20kVI83K1K
	WFXHGmZdGtSOPdCA==
From: "tip-bot2 for Max Ramanouski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ioremap: Use is_ioremap_addr() in iounmap()
Cc: Max Ramanouski <max8rr8@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Alistair Popple <apopple@nvidia.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240815205606.16051-2-max8rr8@gmail.com>
References: <20240815205606.16051-2-max8rr8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172380142877.2215.11720831620589167404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7b02ad32d83c16abd4961d79f3154b734d1d5d9c
Gitweb:        https://git.kernel.org/tip/7b02ad32d83c16abd4961d79f3154b734d1d5d9c
Author:        Max Ramanouski <max8rr8@gmail.com>
AuthorDate:    Thu, 15 Aug 2024 23:56:07 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Aug 2024 11:33:33 +02:00

x86/ioremap: Use is_ioremap_addr() in iounmap()

Restrict iounmap() to memory allocated in the ioremap region, by using
is_ioremap_addr(). Similarly to the generic iounmap() implementation.

Additionally, add a warning in case there is an attempt to iounmap()
invalid memory, instead of silently exiting, thus helping to avoid
incorrect usage of iounmap().

Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://lore.kernel.org/all/20240815205606.16051-2-max8rr8@gmail.com
---
 arch/x86/mm/ioremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279..70b02fc 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/ioremap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
@@ -457,7 +458,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
 
-	if ((void __force *)addr <= high_memory)
+	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
 		return;
 
 	/*


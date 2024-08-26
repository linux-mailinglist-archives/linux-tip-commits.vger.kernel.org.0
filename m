Return-Path: <linux-tip-commits+bounces-2123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F3A95F904
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 20:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049981F22D1E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96E823A9;
	Mon, 26 Aug 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSiQOZkX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0oxIZv4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A62C1AC;
	Mon, 26 Aug 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697245; cv=none; b=SsTfMNZ2PRjZDKCDvb7mOa73ivaYtwr9AS4Qyhjt0otsD4MBWILy5j0VLOPMaf2TaK5Yag97tHps+EvU4CTNojmaWMcvb8km43A7Pc/h2bx8tYMqPKCsfQh9d6Rp1JrW1HV0/zOsKdDK6cn0FXgFbO2/8y9TSq31dt4ysdprZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697245; c=relaxed/simple;
	bh=guX2tivSxV7z7lWtu431aYcSdIr8EJX8n4eAlgq26Pw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qYHeIkxQGxomU3RXQwdrktsxD09gDRbRv+ycaywSY63BXhQevReeNSD6F9IVeBfn0ntCVlmO8/X4bvsCEqYw4gtcCL26oOjJk631y7V1xeqDrksvOH/q6pDNw18AmGKD82MzVWMFxgtznZbnjZfAI/3EBlrnD7DYrf4sR8DYRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSiQOZkX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0oxIZv4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 18:34:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724697242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KGRFennBUtNkwAsK8Bg3nFB1JrnOtN7cPgW+iT6uS5Q=;
	b=sSiQOZkXaSBELYyae5uCxhowi9+DboYvHjmSB1AuHV+vvOS4ov1JlIpaZPTUWNnyPT5dmJ
	1T/J4JwSRy/2cbfrrl377X6CG22xKp7G+JuOwq0HMad8Cok0cWzKFhMd8rkyKyfkVmA2F9
	nyYl4fQOzJuMmLZTjyDR+i6MNPC0rFQ4DbgeNUyPyI47QAQQZu/P7erM9rkuejWqtSy32N
	UVgHq7t+8wy/lRuffA4mejIO7uWbFeCvYqLK/dVYFa44HrzX1tjMbbhiX5Ou5e1fcR0+Ps
	gosEQ5HBcjqLfk/Ib+uWr3rIcWlN09TKKg+ECkf+y9J4yWlHi9p+qmGcH4Z0Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724697242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KGRFennBUtNkwAsK8Bg3nFB1JrnOtN7cPgW+iT6uS5Q=;
	b=p0oxIZv4F1DCWsAwxkfY5EWyNWpTinU9uaGhnRYi4hcvGFrceGSro30si5FpIHudKStnDh
	W4vSodDkrwHwIFDQ==
From: "tip-bot2 for Max Ramanouski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/ioremap: Improve iounmap() address range checks
Cc: Max Ramanouski <max8rr8@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172469724139.2215.3812505849962933435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     50c6dbdfd16e312382842198a7919341ad480e05
Gitweb:        https://git.kernel.org/tip/50c6dbdfd16e312382842198a7919341ad480e05
Author:        Max Ramanouski <max8rr8@gmail.com>
AuthorDate:    Sun, 25 Aug 2024 01:01:11 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Aug 2024 10:19:55 -07:00

x86/ioremap: Improve iounmap() address range checks

Allowing iounmap() on memory that was not ioremap()'d in the first
place is obviously a bad idea.  There is currently a feeble attempt to
avoid errant iounmap()s by checking to see if the address is below
"high_memory".  But that's imprecise at best because there are plenty
of high addresses that are also invalid to call iounmap() on.

Thankfully, there is a more precise helper: is_ioremap_addr().  x86
just does not use it in iounmap().

Restrict iounmap() to addresses in the ioremap region, by using
is_ioremap_addr(). This aligns x86 closer to the generic iounmap()
implementation.

Additionally, add a warning in case there is an attempt to iounmap()
invalid memory.  This replaces an existing silent return and will
help alert folks to any incorrect usage of iounmap().

Due to VMALLOC_START on i386 not being present in asm/pgtable.h,
include for asm/vmalloc.h had to be added to include/linux/ioremap.h.

[ dhansen: tweak subject and changelog ]

Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://lore.kernel.org/all/20240824220111.84441-1-max8rr8%40gmail.com
---
 arch/x86/mm/ioremap.c   | 3 ++-
 include/linux/ioremap.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/ioremap.h b/include/linux/ioremap.h
index f0e99fc..2bd1661 100644
--- a/include/linux/ioremap.h
+++ b/include/linux/ioremap.h
@@ -4,6 +4,7 @@
 
 #include <linux/kasan.h>
 #include <asm/pgtable.h>
+#include <asm/vmalloc.h>
 
 #if defined(CONFIG_HAS_IOMEM) || defined(CONFIG_GENERIC_IOREMAP)
 /*


Return-Path: <linux-tip-commits+bounces-5546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4CAB8986
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F117787C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61B1A0711;
	Thu, 15 May 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EAstEY3n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QEormMYw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8E34CF9;
	Thu, 15 May 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319645; cv=none; b=pJjpHuihf7JEtehp0k0dRPjuwOxRIKCMoMGDNXM+KHD1rp3G3kvQTnqP1EQhOc/AuZT6VFb058fxrpVutpl+d4AG43zb022fLMGgYW9eDdDeOzNFYC5Zf84aTYfik4t8/2i5weNjZwxSnQN0iOrHLbmffzDjH3DejwRwRnLlaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319645; c=relaxed/simple;
	bh=hp6heb/+3LzooOsmeQDNwwZhhzYyMV9j3qJgJJ2V3Zw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=smG81fWR5/RvTXHjGTqt1Q4TSKJ4txJViqAV8dCCojw1lTz5UMA14eSBhIy2DOjDcNgz1Jc+8891FQQSgFbOiCuAiUzUXWlX1c3xU4CSspilxUzrDproVcUoZ/BFrp+T1ORocTvpPcwDaMGag2KptIaUYvzIqOFP30TFRY+rHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EAstEY3n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QEormMYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 14:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747319635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qms05hQIOpL1+FqXJPXoWtSJACNQob/yriFKf5Ddr80=;
	b=EAstEY3n109u7mo2d8+LDZQNfvB5XigacfSzP8mAYppPhILvAJDRppex9TxBXVyyhMgIia
	+3PJ4Trj9CqgdeM0UIq40xmRRXpSodLAaayCQu8eZKd+Gxfzab2ZEhl9RZS3PJ3js12Z8B
	b7NNGMv6PvXRL/MvU9fersVTRCXmGeoWs71KNr5DhsWqg4SIMdw10zS6FnBibAyXo4CA5F
	bBxQDNLy4cO2xs1Vp/6yW0YA9A8TvwYUWBYUPIjH2p2KOY5L5Og8YhbbZ54PLEojKO8wae
	bsdzx4Zi+2foGhktt9y7nzSky5U3i9XAnfiRjh+9SuPNlEmD9u48BgAzkODd7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747319635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qms05hQIOpL1+FqXJPXoWtSJACNQob/yriFKf5Ddr80=;
	b=QEormMYw4BE8wK8+DrMK72977HUxgTJJFizt0OlkHptkWjk6GT42+BSBwItqHW4b9guN7X
	+hz0FMjvb/Mzn2BQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Bump the size of the local variable for sprintf()
Cc: kernel test robot <lkp@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250515085516.2913290-1-andriy.shevchenko@linux.intel.com>
References: <20250515085516.2913290-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174731963480.406.8669837030668986806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a4a39c81e1043b153bde3ef5cb3cf94222ffd918
Gitweb:        https://git.kernel.org/tip/a4a39c81e1043b153bde3ef5cb3cf94222ffd918
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 15 May 2025 11:55:16 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 May 2025 16:28:09 +02:00

genirq: Bump the size of the local variable for sprintf()

GCC is not happy about a sprintf() call on a buffer that might be too small
for the given formatting string.

kernel/irq/debugfs.c:233:26: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]

Fix this by bumping the size of the local variable for sprintf().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250515085516.2913290-1-andriy.shevchenko@linux.intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202505151057.xbyXAbEn-lkp@intel.com/
---
 kernel/irq/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 3d6a5b3..3527def 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -225,7 +225,7 @@ void irq_debugfs_copy_devname(int irq, struct device *dev)
 
 void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc)
 {
-	char name [10];
+	char name [12];
 
 	if (!irq_dir || !desc || desc->debugfs_file)
 		return;


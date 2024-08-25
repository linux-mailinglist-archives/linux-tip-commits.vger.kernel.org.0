Return-Path: <linux-tip-commits+bounces-2107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92995E357
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D41F213A9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A9154456;
	Sun, 25 Aug 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OpOkZ4a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdRfd49s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856957CAC;
	Sun, 25 Aug 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589435; cv=none; b=EbeyZKTSv5fDHkAoxIxD9OJAAWdd71xkOw5bmOGU6ZJ4IfbIk6xl176hvRSAipeeIh99rTHGK1cvHh2zHePzwiHKu3UX11BVqqV95SjY6q2l37HUvRlHQTwyvz3RIPgCrsv98m1hj0Izv1wuS40zGIX37sHk87HQGTmddh1qp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589435; c=relaxed/simple;
	bh=A7M74u/qtOWzWm3k7IS5AEYix3dLJCSbGStA/rFQgvM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fkt2fvNjECP7JOYzKGd+vWSicK5ILAvdhbYbdEgcUrZ1g1JFu85e0LKm3QbvBDRkbRgq70BRSrjwT8CGcQNQySId1JABbRwKUmdGfiCWCAcPhagU6Du8pzLhSr2yz2ZDMGDit8Nn/XaDXAurzO/iSgde1MjTs2HgWUTu67vc/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OpOkZ4a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdRfd49s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Wp2g15FlSvHViBiX8SJl5qRsMczbye+IpTAVYIO6s=;
	b=2OpOkZ4asmsAOpvgv7SOPNInIVh1BPZVsYxqoEMgHrRJzr5e5v9eBYIiBfFTuJajgwTOHX
	/guoA1pjBh6UaQwtLoDwknNC4ZsWnRw34WB57vMnFv9I6s4NO/J7fitPI09G3/5e+eOy/h
	Jfi+9x8ajHoyaIetq3Kk5kBbC3AHzDJLlR8FYDHwbAAXk41JGdKE/RBrvMDbzcDnL08vkG
	t2yUZgk6DZz3U6bfnpbpXgyU9i/B/8mYniJGjK5YWchLv8pzkZHmcxGRqzpetF/48UglS9
	AqfcvsPCFO5o9lh1yq4pyh6ydkAraxYfhJBtDBPbXgKnxa/wiaWbCxI+3CKXxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Wp2g15FlSvHViBiX8SJl5qRsMczbye+IpTAVYIO6s=;
	b=rdRfd49smFwB7L5KKeICLE45htNcfsaRwEV1mvyXyFgn86MzJxORX1KWLkHKcr28Czs9av
	Gc9Z2I0ll6MXJiAA==
From: "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/EISA: Use memremap() to probe for the EISA
 BIOS signature
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943207.2215.13577092392152712343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     80a4da05642c384bc6f5b602b865ebd7e3963902
Gitweb:        https://git.kernel.org/tip/80a4da05642c384bc6f5b602b865ebd7e3963902
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sat, 24 Aug 2024 23:17:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:38 +02:00

x86/EISA: Use memremap() to probe for the EISA BIOS signature

The area at the 0x0FFFD9 physical location in the PC memory space is
regular memory, traditionally ROM BIOS and more recently a copy of BIOS
code and data in RAM, write-protected.

Therefore use memremap() to get access to it rather than ioremap(),
avoiding issues in virtualization scenarios and complementing changes such
as commit f7750a795687 ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use
memremap() for RAM mappings") or commit 5997efb96756 ("x86/boot: Use
memremap() to map the MPF and MPC data").

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk
Closes: https://lore.kernel.org/r/20240822095122.736522-1-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/eisa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 53935b4..5a4f99a 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -11,15 +11,15 @@
 
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p;
+	void *p;
 
 	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
-	p = ioremap(0x0FFFD9, 4);
+	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
 	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
-	iounmap(p);
+	memunmap(p);
 	return 0;
 }
 subsys_initcall(eisa_bus_probe);


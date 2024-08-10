Return-Path: <linux-tip-commits+bounces-2031-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B2194DBB2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Aug 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248A3B21BF7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Aug 2024 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AF14B955;
	Sat, 10 Aug 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nm8piopC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ms+OkaPW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC314A4F3;
	Sat, 10 Aug 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723280161; cv=none; b=DkQY81fz7lHJI+tNwXjkvxsvK3I3lOMVo6tMZwn+TTtNtkzOXPIyNa/38dyaQY+KuKVSW9pp4oud3Q64ocdkthe4IgXDaf+OBXw/6Au4gZv6I5Ml3y05AuUjNe8uLM5C92mkQ3a0+LG/joiWfAeVHp6wEyAY08ILiya8FqZdFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723280161; c=relaxed/simple;
	bh=WW/rsg3nO4wNbUb2qthxMm/WbjLiQBl0i1Baye9NGB8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZWgYWbPnd7KdOKgwHWygA+gwbqZNkQZw9vpFMVYk2nqTivhL6v6KAK+oW9sy/8WSooyamd4lrdPzkvL7Pc/npNNJzYyF/glQwr1ZGY3DMRtsu37+FC9xPKcGc9GS8RinSTCbpfqWYsrphMKlxMX6ZGWnOSMFXYN2zdoU/FwInek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nm8piopC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ms+OkaPW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Aug 2024 08:55:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723280158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C/CJv9b3q8bfm7jrx8sYFIqIXuckj4NpaaXWQp7SpY=;
	b=Nm8piopCvOdxxMnvjMlM2UBND0u8HmBLvfegReUzfeEpASRbDL/wAl/xSWBh+mlvpUzh4I
	pISzUpdXKAlzNVTE/gwuLzlTA0xkODTyIqyZOQxWqOCXzKCW748HKVEO8yLsfgJchHUksU
	MTilPr6vlSjyNPiu5Bjc+OWbRE/Jgxf03VM1HTTcemWXSPcTipNkDC+YcWdbUWp++YoeAH
	nWz5wnAidj9u5ZiPe8dj4rE3D8n1ZNRJe1j57lpZhq+CkBT1LEJBbSSIOvkvL6oXDBN/5z
	WkURBnwbiIhzaxmHNpfIlDidjp8tgZZ8LVbzs9CKitDAT0NGu/sU3N5dTsxycQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723280158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C/CJv9b3q8bfm7jrx8sYFIqIXuckj4NpaaXWQp7SpY=;
	b=Ms+OkaPWtDaGVbRKm385NGNWh0Mv/o0/MHdm+qUDXLlhqINKdfPI8EK5edzV2Cazg2Qa0W
	RkG/7V2+UkMSCrCQ==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove unused CR3_HW_ASID_BITS
Cc: Yosry Ahmed <yosryahmed@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240425215951.2310105-1-yosryahmed@google.com>
References: <20240425215951.2310105-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172328015800.2215.10373959561107309075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4276a0bb62598966716e1ee1ac4a64d382cc9ef7
Gitweb:        https://git.kernel.org/tip/4276a0bb62598966716e1ee1ac4a64d382cc9ef7
Author:        Yosry Ahmed <yosryahmed@google.com>
AuthorDate:    Thu, 25 Apr 2024 21:59:51 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Aug 2024 10:47:19 +02:00

x86/mm: Remove unused CR3_HW_ASID_BITS

Commit 6fd166aae78c ("x86/mm: Use/Fix PCID to optimize user/kernel
switches") removed the last usage of CR3_HW_ASID_BITS and opted to use
X86_CR3_PCID_BITS instead. Remove CR3_HW_ASID_BITS.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240425215951.2310105-1-yosryahmed@google.com

---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1fe9ba3..09950fe 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -86,9 +86,6 @@
  *
  */
 
-/* There are 12 bits of space for ASIDS in CR3 */
-#define CR3_HW_ASID_BITS		12
-
 /*
  * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit for
  * user/kernel switches


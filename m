Return-Path: <linux-tip-commits+bounces-4835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA300A858AA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE311706B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B027CCE2;
	Fri, 11 Apr 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0frQemnY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+geXJgn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01B27EC9D;
	Fri, 11 Apr 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365700; cv=none; b=huFnh/otXHs6dTSnzYH9EwoYIDgbcAnoA3ssJdlaGkpSIvUhX2kyifwa9aBPcpI3bUtXWahM+acIdGWTjC6p5FCLpaQMSYzw3e4lAOC4xiOf8G77gLMee+VbGkLtwVx/pSMN5zcmpJBAN8P29XtIf31nzvlP/p+aH3haLu1CgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365700; c=relaxed/simple;
	bh=AFWwU6GMA/FhynWz2a1qsT5hZ1mmzT+E258eTGU783Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bezDgF+2VuRtcebdh1nFLuUAKUQHNyLZ+flFpAn++NVjGTc8LkTy3tV1TeAzCqy4noV8SMNnwFwPKG+78v4aCO99hwS8yfjFbw5OLuCgzTkRlv3LhhRNS1rdFTJCrtBjW+uNQfGmPhzebll6Brdwtv4G8uh06J2H1ee0fzR4CGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0frQemnY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+geXJgn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IskIfgBsXhU9raEgO4D2090Hvm2Ob2DcGjUjeSmVsWI=;
	b=0frQemnYrjssBy5on6YcyEPiyDTvSp6BF/tq07FXSdjWx4AXGgM7PQwPAJeJEcB6MzN+T7
	VPh5xxjf1KJefhSSFK/RbcU9KxuqTB7UTUch5UkkMy7LSZ1COggOMINczYY7ZeWgEpBXcE
	CP6mairehB9144g2BMIyrsKrq4IYP+/j3DK7tteOFdXpbhBDtFSMxl4LeTJbL3x6WU87D5
	o+kDUgK7vN392AEP8jsy645v86uOs7xLkDC3XTe7oDUmMMALA6GVfZPd9W385bZn1x8LQ7
	OUNtAbiwqAgz7zQpKZCyG1YApa728aw4Cw8XAWVtII9AX8pVv3HSkmrmpvFF3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IskIfgBsXhU9raEgO4D2090Hvm2Ob2DcGjUjeSmVsWI=;
	b=v+geXJgnJrPNQZNsJb4FdycHccnip/a1Gl0DpGM0ahDDY8t81sybyxE6TyMKzlrhf89h7D
	1PpQVpw+wQyqupBQ==
From: "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen: Fix __xen_hypercall_setfunc()
Cc: Juergen Gross <jgross@suse.com>, Jason Andryuk <jason.andryuk@amd.com>,
 Ingo Molnar <mingo@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410193106.16353-1-jason.andryuk@amd.com>
References: <20250410193106.16353-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436567811.31282.12400498126986636858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     164a9f712fa53e4c92b2a435bb071a5be0c31dbc
Gitweb:        https://git.kernel.org/tip/164a9f712fa53e4c92b2a435bb071a5be0c31dbc
Author:        Jason Andryuk <jason.andryuk@amd.com>
AuthorDate:    Thu, 10 Apr 2025 15:31:05 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:39:50 +02:00

x86/xen: Fix __xen_hypercall_setfunc()

Hypercall detection is failing with xen_hypercall_intel() chosen even on
an AMD processor.  Looking at the disassembly, the call to
xen_get_vendor() was removed.

The check for boot_cpu_has(X86_FEATURE_CPUID) was used as a proxy for
the x86_vendor having been set.

When CONFIG_X86_REQUIRED_FEATURE_CPUID=y (the default value), DCE eliminates
the call to xen_get_vendor().  An uninitialized value 0 means
X86_VENDOR_INTEL, so the Intel function is always returned.

Remove the if and always call xen_get_vendor() to avoid this issue.

Fixes: 3d37d9396eb3 ("x86/cpufeatures: Add {REQUIRED,DISABLED} feature configs")
Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>
Link: https://lore.kernel.org/r/20250410193106.16353-1-jason.andryuk@amd.com
---
 arch/x86/xen/enlighten.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 1b7710b..53282dc 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -103,10 +103,6 @@ noinstr void *__xen_hypercall_setfunc(void)
 	void (*func)(void);
 
 	/*
-	 * Xen is supported only on CPUs with CPUID, so testing for
-	 * X86_FEATURE_CPUID is a test for early_cpu_init() having been
-	 * run.
-	 *
 	 * Note that __xen_hypercall_setfunc() is noinstr only due to a nasty
 	 * dependency chain: it is being called via the xen_hypercall static
 	 * call when running as a PVH or HVM guest. Hypercalls need to be
@@ -118,8 +114,7 @@ noinstr void *__xen_hypercall_setfunc(void)
 	 */
 	instrumentation_begin();
 
-	if (!boot_cpu_has(X86_FEATURE_CPUID))
-		xen_get_vendor();
+	xen_get_vendor();
 
 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))


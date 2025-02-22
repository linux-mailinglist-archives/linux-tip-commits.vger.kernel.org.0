Return-Path: <linux-tip-commits+bounces-3602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40853A40853
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEDE3B9B63
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37E20AF86;
	Sat, 22 Feb 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFXq5CYL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vnJRvRJq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828B209695;
	Sat, 22 Feb 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227182; cv=none; b=c+Ys+hw+DXj674xYWVW2Sm2OtHXI6a8lg4IJjwZCjhLNlQw9jjebklOhecaJZl8S4mx8lYgHufOIsvO0dYo3l9D4TUTUOOl5sdkTAMoci6fWaZ9I7lc/YzP/+AzimlLeMKaqGZh+39Zf6GkSMUq28DK2yK/zVIY+6Wiw6XkofcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227182; c=relaxed/simple;
	bh=x2KN1wWyffIyMEJ2zI0OinlEcF0podCUFAEcLXFID4A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVaqrRV5chPxpZbci6IuzxEKvKlSawdOt4WliUis/ckGmnyqWWrcxH+R9uqzQvSNCwfAitlKdnRbSmiVpgfgrW8C+wfFTyCBzu6puxAGQfpGRkd07CwchB8C7x3/nbyKWNFUCVmgjXy0aHfFoNCttv+W0xXCMXe7YA/6A3lwqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFXq5CYL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vnJRvRJq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 12:26:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740227178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JW3WU97tQ2Vo5oDnkbb4HHLBsUEakNLFIFQiwVAQ/Y=;
	b=UFXq5CYLx3DVJrFG0QFRZJKpcwkkvEM0oIP2XjRNL2RsGEVHMZiFQBmogSdWXjc4rr5sBV
	OEmwQ2SWaw/jan+9XhRA/MKUHkz5x2ulvHwWDYV1HiEHNjN62BClVIK4GhHQlUOQQ6ZIg9
	hgbu7TiHdsnZKsSt95uQbZi9P6kEQbmNitQLtc846oBqOU8E17HX5QHtCrZAzA96yySjKX
	KegVe3AecKfMhpGfpf0pk/NZHKcsOwjInvlVD+sa4t/Cph4yHLCsrCE9f6GgqSn5pqNv7z
	dNix6mkvtseDbNbzrN/BZd2mMrhIJQ3P4wrY3EMHXDYrSJd/XVxxQJC7Rc2jLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740227178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JW3WU97tQ2Vo5oDnkbb4HHLBsUEakNLFIFQiwVAQ/Y=;
	b=vnJRvRJqSPj+N2DD0uwkXtdBZpjyAUT+dYKIfILuYeFVC8L0ApxS4ntdTWqxkLFcMoX6vG
	pgWXifSkXUxfX6Cg==
From: "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/lam: Move cpu_has_la57() to use cpuinfo flag
Cc: "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexander Potapenko <glider@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8b1ca51b13e6d94b5a42b6930d81b692cbb0bcbb=2E17379?=
 =?utf-8?q?90375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C8b1ca51b13e6d94b5a42b6930d81b692cbb0bcbb=2E173799?=
 =?utf-8?q?0375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022717804.10177.14425767347553583879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ec8f5b4659b4044db55e1f7d947703dd4948626c
Gitweb:        https://git.kernel.org/tip/ec8f5b4659b4044db55e1f7d947703dd4948626c
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Mon, 27 Jan 2025 16:31:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 13:17:07 +01:00

selftests/lam: Move cpu_has_la57() to use cpuinfo flag

In current form cpu_has_la57() reports platform's support for LA57
through reading the output of cpuid. A much more useful information is
whether 5-level paging is actually enabled on the running system.

Check whether 5-level paging is enabled by trying to map a page in the
high linear address space.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/8b1ca51b13e6d94b5a42b6930d81b692cbb0bcbb.1737990375.git.maciej.wieczor-retman@intel.com
---
 tools/testing/selftests/x86/lam.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 4d4a765..60170a3 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -124,14 +124,18 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
-/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
-static inline int cpu_has_la57(void)
+static inline int la57_enabled(void)
 {
-	unsigned int cpuinfo[4];
+	int ret;
+	void *p;
+
+	p = mmap((void *)HIGH_ADDR, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
 
-	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+	ret = p == MAP_FAILED ? 0 : 1;
 
-	return (cpuinfo[2] & (1 << 16));
+	munmap(p, PAGE_SIZE);
+	return ret;
 }
 
 /*
@@ -322,7 +326,7 @@ static int handle_mmap(struct testcases *test)
 		   flags, -1, 0);
 	if (ptr == MAP_FAILED) {
 		if (test->addr == HIGH_ADDR)
-			if (!cpu_has_la57())
+			if (!la57_enabled())
 				return 3; /* unsupport LA57 */
 		return 1;
 	}


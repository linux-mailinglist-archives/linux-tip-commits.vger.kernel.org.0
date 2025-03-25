Return-Path: <linux-tip-commits+bounces-4494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94BA6EC94
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C983AE6EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1345254866;
	Tue, 25 Mar 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knXJgpIl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RY511z86"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F2204686;
	Tue, 25 Mar 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895381; cv=none; b=lP/WLHUX4LwqjGiqYkjzD0yv3hxzrKvrqiJgV+0a0Kbtn+7yBVAXMzdXOOJ9QckGikBIWErgBZBDy1nNLWkrTkC+vs3ieBecs1TxNQjKM+h2+5QsUiUkXg+DW5Le17/aEYNTNltAw4Dq6ImUZSxT+gxsHvOsWWWed1oQkQu2oRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895381; c=relaxed/simple;
	bh=KblI+gxjZe9MRbqfOqf0kTkrI4rJbB5FeIcI/Xc2ln0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lw++YR8nG09DnoRdJBa6cBHJfG5RHY9xyBSGF6evyK1hsb2XBOF2EaKXOQ69u+FVclSfPJQe+iXWw/Y/02hgxQEtqbibDLvrBQtzeyOObZCZPK1nveJqzVD6rlDUOnx+RoWDGUcHX60P0APjVG+3K0EWJb8aaMUdwS9emo4qu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knXJgpIl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RY511z86; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iI/PbFjwpSI9OtzqkZVrtx4Ynv1wagFpT8oNxjhaPW0=;
	b=knXJgpIlkolcns08Z1r1BQravIvp//LNSZq+mA0khyRhZEJyw7OK21QLiqYCqu7XEeEgV9
	3Y4IVtKOVs60UItNBcLN6rd29BacICTIPlca+JV0hSK4ulRwKJTDPIIXZeGX1frvZ6eTul
	U10xALGIShNmXEHwZ6SYcsZGpe5dJCjGDSdj/l74wiqUep+wpYsdSxFj/QLAAwz3fOcq7d
	oKO7sD1WGrgF34bMBFGIVaDac5m3owHQ11niCsyIYz4NxRm0g9zyZOzj/HErwD/dFNOs4S
	MlGbDNlNclJJP6h8XieMjabDrNRntMMTR/fITL9Kf8gRMgvzb3H8q/8GUhGP7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iI/PbFjwpSI9OtzqkZVrtx4Ynv1wagFpT8oNxjhaPW0=;
	b=RY511z86H/7LAPGgRW86QEh4xRZkjcdZyl58/bhNAyMO8++3YRv9F6evLgmlm5QehOTS8X
	ydVsLz2ECUy7uTCg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Extract out cache level topology ID calculation
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-26-darwi@linutronix.de>
References: <20250324133324.23458-26-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537779.14745.5136570352994170049.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fda5f817ae41035db9e36854600525145688b35e
Gitweb:        https://git.kernel.org/tip/fda5f817ae41035db9e36854600525145688b35e
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:21 +01:00

x86/cacheinfo: Extract out cache level topology ID calculation

For Intel CPUID leaf 0x4 parsing, refactor the cache level topology ID
calculation code into its own method instead of repeating the same logic
twice for L2 and L3.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-26-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 72cc32d..7b274da 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -400,6 +400,16 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
+static unsigned int calc_cache_topo_id(struct cpuinfo_x86 *c, const struct _cpuid4_info *id4)
+{
+	unsigned int num_threads_sharing;
+	int index_msb;
+
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	index_msb = get_count_order(num_threads_sharing);
+	return c->topo.apicid & ~((1 << index_msb) - 1);
+}
+
 static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
@@ -420,7 +430,6 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		return false;
 
 	for (int i = 0; i < ci->num_leaves; i++) {
-		unsigned int num_threads_sharing, index_msb;
 		struct _cpuid4_info id4 = {};
 		int ret;
 
@@ -437,15 +446,11 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 			break;
 		case 2:
 			l2 = id4.size / 1024;
-			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-			index_msb = get_count_order(num_threads_sharing);
-			l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			l2_id = calc_cache_topo_id(c, &id4);
 			break;
 		case 3:
 			l3 = id4.size / 1024;
-			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-			index_msb = get_count_order(num_threads_sharing);
-			l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			l3_id = calc_cache_topo_id(c, &id4);
 			break;
 		default:
 			break;


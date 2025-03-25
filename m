Return-Path: <linux-tip-commits+bounces-4514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B57DA6ECBA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C9516FBC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E52594B7;
	Tue, 25 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJwjaWJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uvl40Epa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F226257427;
	Tue, 25 Mar 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895399; cv=none; b=bYuo2vDKjc8OvqQdAcdadAWE7lmQiKrbh25ljOPjzHWipYEHf1QoOemJY8Gdy63e6p1A3ww7wdGkjV6g4+7qMHwynxV+Cwa8N7PnKcc88VKXMRCEHAGcdvo/dD26y/Y6RaPWadjQpUl93Gb9nGaOdizGJ6p8fyoX0ry3EF1EGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895399; c=relaxed/simple;
	bh=S+bF166yQpvaBw+NWHMHfYJw8yvCLG5kdtnQ/3TMesY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GLZVsnmAkxz4cli0at+YyTTsjQVjmFypJnnBetm6F8pgZfMQFs9S2aPwbiZGkbeRlF5XtjR+VBgl7Equr5u1NTuocaGGEVq/TLr2HUq2z44frr9brdE3klI+a7pARBo0O3i/lkd+gEVJvJy+giCuCOhbIeMeOIT+wghj1O3Xzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJwjaWJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uvl40Epa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROaemMnzPT4CwQgSeP7OlVLfa3hbYaItNe2tpeyeT/s=;
	b=UJwjaWJ58vmbZtw2kp9Z2ip50Jb49vQYehkGOhzV5DzbV0HTXUelt06Rcy6V+EcsEh85Uh
	T0Lb6qhU6tybEX0pL8suqNDi0lLvlWFKPvnYLbvnw9eLAAoLbldVlA6EW7OY/uikZX7Y8f
	PeBbwBSBjmbaIt1tdmgxuCbj+va4c72A0Ml/INsN6aZxmE0DN7UbYHaBgGhwTAIaZBfuQQ
	/fUedB11m1ncGvJt+TRIwF1DcakabBc3j65EzzroQr5K9YhqZhXrR37VCx+xkY/h7xWW4M
	alkAPoRy1Po/1nVkgdiItEKS3jrAq39NxEVZoOXbDHrDpYD8w1mxgq/WqWviTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROaemMnzPT4CwQgSeP7OlVLfa3hbYaItNe2tpeyeT/s=;
	b=uvl40EpanaKHVxwiY3Bwb62k4HEtjC88z5OAcxSf77O5jLIzZJ0hJmoA1GIkbXZuz4Atwn
	CNHvCnCQKaJBhQCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Refactor CPUID leaf 0x2 cache descriptor lookup
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-6-darwi@linutronix.de>
References: <20250324133324.23458-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539477.14745.16854264159972359321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ee159792a4db06e359a5e2e231c6f1242ec76c31
Gitweb:        https://git.kernel.org/tip/ee159792a4db06e359a5e2e231c6f1242ec76c31
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:13 +01:00

x86/cacheinfo: Refactor CPUID leaf 0x2 cache descriptor lookup

Extract the cache descriptor lookup logic out of the leaf 0x2 parsing
code and into a dedicated function.  This disentangles such lookup from
the deeply nested leaf 0x2 parsing loop.

Remove the cache table termination entry, as it is no longer needed
after the ARRAY_SIZE()-based lookup.

[ darwi: Move refactoring logic into this separate commit + commit log.
	 Remove the cache table termination entry. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-6-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 44 ++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 6c61080..d0bfdb8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -123,7 +123,6 @@ static const struct _cache_table cache_table[] =
 	{ 0xea, LVL_3,      MB(12) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xeb, LVL_3,      MB(18) },	/* 24-way set assoc, 64 byte line size */
 	{ 0xec, LVL_3,      MB(24) },	/* 24-way set assoc, 64 byte line size */
-	{ 0x00, 0, 0}
 };
 
 
@@ -728,6 +727,16 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
+static const struct _cache_table *cache_table_get(u8 desc)
+{
+	for (int i = 0; i < ARRAY_SIZE(cache_table); i++) {
+		if (cache_table[i].descriptor == desc)
+			return &cache_table[i];
+	}
+
+	return NULL;
+}
+
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -784,34 +793,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
+		const struct _cache_table *entry;
 		union leaf_0x2_regs regs;
 		u8 *desc;
 
 		cpuid_get_leaf_0x2_regs(&regs);
 		for_each_leaf_0x2_desc(regs, desc) {
-			u8 k = 0;
-
-			/* look up this descriptor in the table */
-			while (cache_table[k].descriptor != 0) {
-				if (cache_table[k].descriptor == *desc) {
-					switch (cache_table[k].cache_type) {
-					case LVL_1_INST:
-						l1i += cache_table[k].size;
-						break;
-					case LVL_1_DATA:
-						l1d += cache_table[k].size;
-						break;
-					case LVL_2:
-						l2 += cache_table[k].size;
-						break;
-					case LVL_3:
-						l3 += cache_table[k].size;
-						break;
-					}
-
-					break;
-				}
-				k++;
+			entry = cache_table_get(*desc);
+			if (!entry)
+				continue;
+
+			switch (entry->cache_type) {
+			case LVL_1_INST: l1i += entry->size; break;
+			case LVL_1_DATA: l1d += entry->size; break;
+			case LVL_2:	 l2  += entry->size; break;
+			case LVL_3:	 l3  += entry->size; break;
 			}
 		}
 	}


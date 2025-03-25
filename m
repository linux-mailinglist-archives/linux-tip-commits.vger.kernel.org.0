Return-Path: <linux-tip-commits+bounces-4511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFBA6ECB6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF617167837
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4392586C3;
	Tue, 25 Mar 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1sEh2cB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IsZeyFJJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5571257AE7;
	Tue, 25 Mar 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895396; cv=none; b=Y/Tc4Nn3MGxNZ6tiadVFPsxPkC4bDVgp8dxDx8O0P3fq24hFbNpW0euQgHn34oD0yX+3W99nOpOwxAwfyMJkqr6cRAhW1x4DoGcME3ce5WMa1cKpw+TNPmIWVqU69iZN7pKQCDJ0t2s7uIakKqYLDUTp5wObpkLNNcHsZBpArAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895396; c=relaxed/simple;
	bh=XKwdGc1utKZGzKqsbULWCdffD5CDiGRLcnsG45wAr9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cB/LrGJEz1IXh+rJVJH13gQC9vuABxmSgKOvyKFD6lQFNFSN0ZTePYB1amzVhRcfTfJ/YpF0PZ1iYOyQhF5VrX7PMDAx7Sh/DgSw7BuetcPMBMMhnCRf1v5UkyjHc9G99tWJiP4bTN+SMXTgFWctAvLUmFMK3fxHTBDHw196tO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1sEh2cB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IsZeyFJJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EShZ/gTjFpS8Q+aVdpwDVa6I0ZQ5UJIoWH8WEFDW9m0=;
	b=A1sEh2cBcMdNCpLdrFZhIdToNeS3FXDIzRVG4OWjZnHJdOZzLXsFPGlFMNZjduDQ7uSnjb
	d7um16H0HTJDc0fnrniP8giYxGPx3PHsGZaTcySLAAwyJnPrSXQ1BP9ckqd4I7wy40iBdz
	YF4ydpY57ExxoMgUVxxZox9PAyLpF8GvaYum3hY1jlI3hy7Tlpths6+akUO02Swvfy/hN5
	TwK/ZtfDrgpWjcy3y7bBN5cajsiPuTszt1c45gmiWG59scrfKu0GNctBpY8l7kIsp1alh+
	23VqPrgiPQhwyictb3ck2Sp7xJsReaY8BVedXcaGU+cilqcnJrLiu/iCJTk+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EShZ/gTjFpS8Q+aVdpwDVa6I0ZQ5UJIoWH8WEFDW9m0=;
	b=IsZeyFJJzd/t6C+mQoLA8ZrFnSXMQPO0LZCHQ6krkS+q1wctQ2cH6fvYa0pYS70Ejk189H
	rNiMs+bsOsAma5Dw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Align ci_info_init() assignment expressions
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-10-darwi@linutronix.de>
References: <20250324133324.23458-10-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539246.14745.2388513944980339068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     036a73b5174477b72d881b4c75740d3dbfd7ec49
Gitweb:        https://git.kernel.org/tip/036a73b5174477b72d881b4c75740d3dbfd7ec49
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:26 +01:00

x86/cacheinfo: Align ci_info_init() assignment expressions

The ci_info_init() function initializes 10 members of a 'struct cacheinfo'
instance using passed data from CPUID leaf 0x4.

Such assignment expressions are difficult to read in their current form.
Align them for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-10-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index fc4b49e..b273ecf 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -936,19 +936,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 static void ci_info_init(struct cacheinfo *ci,
 			 const struct _cpuid4_info_regs *base)
 {
-	ci->id = base->id;
-	ci->attributes = CACHE_ID;
-	ci->level = base->eax.split.level;
-	ci->type = cache_type_map[base->eax.split.type];
-	ci->coherency_line_size =
-				base->ebx.split.coherency_line_size + 1;
-	ci->ways_of_associativity =
-				base->ebx.split.ways_of_associativity + 1;
-	ci->size = base->size;
-	ci->number_of_sets = base->ecx.split.number_of_sets + 1;
-	ci->physical_line_partition =
-				base->ebx.split.physical_line_partition + 1;
-	ci->priv = base->nb;
+	ci->id				= base->id;
+	ci->attributes			= CACHE_ID;
+	ci->level			= base->eax.split.level;
+	ci->type			= cache_type_map[base->eax.split.type];
+	ci->coherency_line_size		= base->ebx.split.coherency_line_size + 1;
+	ci->ways_of_associativity	= base->ebx.split.ways_of_associativity + 1;
+	ci->size			= base->size;
+	ci->number_of_sets		= base->ecx.split.number_of_sets + 1;
+	ci->physical_line_partition	= base->ebx.split.physical_line_partition + 1;
+	ci->priv			= base->nb;
 }
 
 int init_cache_level(unsigned int cpu)


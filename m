Return-Path: <linux-tip-commits+bounces-5564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DFAB9838
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A84B4A1A30
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25122E40E;
	Fri, 16 May 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzOqWD9C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2aJNO+I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581F1DDC28;
	Fri, 16 May 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386064; cv=none; b=u89OvNYD8NbWRYToxpC/NmsI5HyhlePMtn2ayDm5eR713bub9o1u8j17aJa+gJPMezSYn4RC0gGTFvhx1z8kfyexe1xW7VRdq21CxO9QmQBUBBA0RLt6aHPV/8Z711twP9rOXcSerVMn2yEsQRfNn3wWTFF5Q51nbjW5+Fbycqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386064; c=relaxed/simple;
	bh=/5LIWe87EYMO8fdTI47/xbmCyH6R1HeKMGf2bnabSa4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T/BeEBxqmjsZ3AtQdbHGbDGWUYi+b4Ag93C6Fza8gV8roEZ3TxX7HyUd4cilRkGbmQ4UmxmAIdlN32ZFcrb25f9V7pSd3PdRjMiS+2eGSRu+pqX1wrly7gTM7QnMpnG+KRMu6iP99wg9FveyWLa2ivA/XsFitt38A/TZr3STKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzOqWD9C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2aJNO+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 09:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747386060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyQkk5Mm2eizx+YkqSZxHb5YPPNxuXbXjYjObyuuOLg=;
	b=AzOqWD9C9x3bFwJjew/4a9+OA4GogAoJVudLeSzGn42lpfzElOTL7jAgX/xcMf1PzCThy6
	e3K6qhXpm9Xh7JxSBmaN4oz8+6OU/gXZkFg7hZy2niWGq/kiiud3GPyu+3DfF59WuZau1U
	SUDki4hDLnKn7Rxplj9Mr4TTKSmoDlwBih+JOTT5wQzQ1fPK7cuae0yFzmF1BurAW2rAeU
	/VK3tpu8ZCNcRdVs8a4LX3pY2e5EI6jCiLY/+dw/i+KjO9Ofv54+pC0D40oXoy90YqT9A4
	ep5njkC4ziCokcfHDDRKYugOnxa8O4xPhmHBRJjdvkCCFOLkW0F2mlbXMc37Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747386060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyQkk5Mm2eizx+YkqSZxHb5YPPNxuXbXjYjObyuuOLg=;
	b=L2aJNO+IujBr3hFERTfWwhZVtM0JvIVj/nSZ1DNYUpXu/rJRih3mmErM6CLuGZclucgUDE
	Hflm3wRe7IObc0AQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cacheinfo: Rename CPUID(0x2) descriptors iterator
 parameter
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-7-darwi@linutronix.de>
References: <20250508150240.172915-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738605980.406.11218657212651964620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4b21e71ad6cc93d39d78176de269a0dc9a318fc6
Gitweb:        https://git.kernel.org/tip/4b21e71ad6cc93d39d78176de269a0dc9a318fc6
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:49:55 +02:00

x86/cacheinfo: Rename CPUID(0x2) descriptors iterator parameter

The CPUID(0x2) descriptors iterator has been renamed from:

    for_each_leaf_0x2_entry()

to:

    for_each_cpuid_0x2_desc()

since it iterates over CPUID(0x2) cache and TLB "descriptors", not
"entries".

In the macro's x86/cacheinfo call-site, rename the parameter denoting the
parsed descriptor at each iteration from 'entry' to 'desc'.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-7-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b6349c1..adfa7e8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -381,7 +381,7 @@ static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
 static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	const struct leaf_0x2_table *entry;
+	const struct leaf_0x2_table *desc;
 	union leaf_0x2_regs regs;
 	u8 *ptr;
 
@@ -389,12 +389,12 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 		return;
 
 	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, entry) {
-		switch (entry->c_type) {
-		case CACHE_L1_INST:	l1i += entry->c_size; break;
-		case CACHE_L1_DATA:	l1d += entry->c_size; break;
-		case CACHE_L2:		l2  += entry->c_size; break;
-		case CACHE_L3:		l3  += entry->c_size; break;
+	for_each_cpuid_0x2_desc(regs, ptr, desc) {
+		switch (desc->c_type) {
+		case CACHE_L1_INST:	l1i += desc->c_size; break;
+		case CACHE_L1_DATA:	l1d += desc->c_size; break;
+		case CACHE_L2:		l2  += desc->c_size; break;
+		case CACHE_L3:		l3  += desc->c_size; break;
 		}
 	}
 


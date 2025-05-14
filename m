Return-Path: <linux-tip-commits+bounces-5533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC05AB6549
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434C1177868
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71421B9E7;
	Wed, 14 May 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocq3dWFR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kh3P5WI+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B521B9F2;
	Wed, 14 May 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210026; cv=none; b=SRSRNaoSPkbnr67R0H/IRqJ1FjQUmoTwC1N5Sz5vFlIWJPkN+d77Bc9LLleEFe+DF+ZPaxFhlSlGTSspXjsx473ZDVyn7AOQIVMFHyFaeF4sl0T5LTtlZuLvEBlNAlpT23c0P9lx3Zg2uVGKA+9n56d8Mg2t5R+hexylb1RojuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210026; c=relaxed/simple;
	bh=le9TmmWe3Ep/fZUXcz1gf7ffKazv9o/OGUlbZDNKG/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GZ2QapwjbMW5IzcC7beLdX/9j1kI2vnuXG6A/5W4bpSGee2y7FaATPQekGsTBtsgIaWMvyL3Q5CzVw4oeIba19iztoNhDek2cJVQfSEx8n9RXIdkYnCYm023qodjtCALy5vuhZWoglY/B5X0Cpazwru3/OV73dhyHUvfHkF13U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocq3dWFR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kh3P5WI+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 08:07:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747210023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/5KONtxvJB1hDJGMEVPoPD+UGgoVOBto1ix3KplgQA=;
	b=ocq3dWFRX4hbycngcCUhc2zpMvvwhE0mcimKAYmu3O/ZwaT0FF7dTyyUqdBH5dUE5X+eMP
	UpCECSuyWBNq3n4fZVMYMmhcosbn3MQLnqd01vvStp5PNYquscapIPmXo1HoP0y70FRS4W
	OcyVHBkD7+aPTJ+59MccjF71b87YR5x9sGEko/lXfwTd4M9YcIR8deoY63JtTjtnMFwlWG
	UPkRvjkMX2u61IFZ+/V2JJntcGaGVzOOuR8RWnDB0hhsiWCIDg6tOiTPenLF5gXlVxcaEp
	+fLbOvZOpWrx3M+3EoJtOM82Xj8wZ9wkR8eOQ6v4gc/9lP628rbv9emf1WUQJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747210023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/5KONtxvJB1hDJGMEVPoPD+UGgoVOBto1ix3KplgQA=;
	b=kh3P5WI+LEEuVlZzo3ld3dMvBRepMYbiysPo0mU7BFJ2VImhrYsFiO4r1UKwv/FqG2v8J/
	D0VTliuN2Svl0iDA==
From: "tip-bot2 for Shivank Garg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm/pat: Fix W=1 build kernel-doc warning
Cc: Shivank Garg <shivankg@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250514062637.3287779-3-shivankg@amd.com>
References: <20250514062637.3287779-3-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174721002225.406.1304432824733939534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bd6afa43eee175ba146f6f9a27d6d24eeaab0a45
Gitweb:        https://git.kernel.org/tip/bd6afa43eee175ba146f6f9a27d6d24eeaab0a45
Author:        Shivank Garg <shivankg@amd.com>
AuthorDate:    Wed, 14 May 2025 06:26:40 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 May 2025 09:58:53 +02:00

x86/mm/pat: Fix W=1 build kernel-doc warning

Building the kernel with W=1 generates the following warning:

  arch/x86/mm/pat/memtype.c:692: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'

Add missing parameter documentation to fix the kernel-doc warning.

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250514062637.3287779-3-shivankg@amd.com
---
 arch/x86/mm/pat/memtype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc..51635ae 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -682,6 +682,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 /**
  * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
  * of @pfn cannot be overridden by UC MTRR memory type.
+ * @pfn: The page frame number to check.
  *
  * Only to be called when PAT is enabled.
  *


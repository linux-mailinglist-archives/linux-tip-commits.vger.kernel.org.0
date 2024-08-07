Return-Path: <linux-tip-commits+bounces-1964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA894A64A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F107D281178
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB541E3CB4;
	Wed,  7 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKgnDCjS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQDwEDqo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E1E288C;
	Wed,  7 Aug 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027906; cv=none; b=BnNPziltDkZf6uedOawYwDSmeJviz/xdai687TEG04KlzY+h+9ORq4rSmoCcdtI51A5koxi/C3CUN6kra6YrUEYfWMZJks3oFn5xa+YzrYAh/mFT3bBCHzVKG7cjZkqRqG43DOsXxhKtOaruiHyZUefivVWyddYX0QVupA3jgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027906; c=relaxed/simple;
	bh=e1ybZhXtbeFzmyceGpwDVjymYXUjPqiQokOJ0uLrsFI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Exc+E4Q6SIU+ZS2e5ehsmfnMOyXH7JoAWAsrRn19VthXMrPoklzFNmG6ZByCFeEWnC+7SiKi3ibYm5IClDhb+5nkKTynIXcvGOf3jJIdTAKyYFUJixBKvcBjxIIreeflLUdFGQ+Cqh6VXDk18NUI6IR3ebF6Tfpr7q2iHzN9bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKgnDCjS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQDwEDqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18xLySgxHV2MKZRpqI1KhMGmf70KsWtqRdQjdJeUGsQ=;
	b=hKgnDCjS0ymd9LNeKSaV1EU43KqKm7fb1pwN2Qooq4FmjyWOgKn+acUOY8KpohM7Ysl5C8
	wYiyD9Dc3qkY0b6CntrJEucr/1472Kxd7ZEHRp6FAL2jsaQhLiGU+X8dDGJdYBC9O2Jw/z
	V0i+IJNnFb/M/LFRIMkd9gyylk0Po6lAFyGAHl6UYnW7a7PafHJsdWOrs5o3TWE5LndboR
	JCJPL8Y82xOzgggNQdplIW98rKYZ969K56XD0bF2MVUiclyp8aSDXR2goCMrbd05nVwFtk
	PNLAQ8IIOuDi5ag6IgtmQVvLrOcgqgGS5bNqF5MVp/Co7Gsh0z0VjOEF949FXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18xLySgxHV2MKZRpqI1KhMGmf70KsWtqRdQjdJeUGsQ=;
	b=wQDwEDqonVfLG/ZV/BOSna03b7MJhrrWuCzj0uiZfG7x8FbauMKMZekItiHm4ZXBHrJwKG
	a3bi+U9O69G8XKBw==
From: "tip-bot2 for Zhenyu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add LNL uncore iMC
 freerunning support
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731141353.759643-4-kan.liang@linux.intel.com>
References: <20240731141353.759643-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789750.2215.18271255295966013340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9ac57c456fcb17f07f8792219479b0c841d75ba7
Gitweb:        https://git.kernel.org/tip/9ac57c456fcb17f07f8792219479b0c841d75ba7
Author:        Zhenyu Wang <zhenyuw@linux.intel.com>
AuthorDate:    Wed, 31 Jul 2024 07:13:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:46 +02:00

perf/x86/intel/uncore: Add LNL uncore iMC freerunning support

LNL uncore imc freerunning counters keep same as previous HW.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240731141353.759643-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 983beed..f7402bd 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1840,6 +1840,7 @@ static struct intel_uncore_type *lnl_mmio_uncores[] = {
 	&adl_uncore_imc,
 	&lnl_uncore_hbo,
 	&lnl_uncore_sncu,
+	&adl_uncore_imc_free_running,
 	NULL
 };
 


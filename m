Return-Path: <linux-tip-commits+bounces-6933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AEBE30AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F247352782
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F43164A8;
	Thu, 16 Oct 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Og9fIw+c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMgiECvq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54967263B;
	Thu, 16 Oct 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613705; cv=none; b=nd0h0/3CZ70kLfEPh10b9RsVnkDBkZxynhvTpkvDjftPk5pLk9Uv2i0kQvRiQF2wjUUqIJhK5fpuQtkOTI1W+42pvOfWSM7PHNhdofPisYKB29hu6qHfUXoAZLDQUkqzGzZXkOX7hiydWWKp2MlNLulybiDuARbKo1mM85Sf8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613705; c=relaxed/simple;
	bh=s3UKeMDFienzdhZ6fEyetCuPEQBFdQYD9GlTbQx8eQQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=orzINbXQEV569dB/3yXt+RshQwAC3Rs7PRR1NIZZFVPxZ8Ce0wZrlKID1InBR0Hj0/jp9uXeLcB3m/OtJFBlL7sT0b17IEBmhrnh9aNqx6C90ztw6NEz6+wTOxgArPpyZYjttWBzqtZZC1XNZGJe563Iyv+KgxoogroZPuyf444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Og9fIw+c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMgiECvq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 11:21:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760613701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AHIexI7oh85pU2rC4PB6zjKSGbbonpIYsq1vd3KvIys=;
	b=Og9fIw+c5CI8WBIkamKSi/XaMNfHPG5lGkdwrMcdoRaLfbwlmoRGHCOsViHvE/ia6IbrJv
	I1LfKCYO2G2oObRXakUihTKoudhoJgnlHP+JDf78PDJIRpdOQdtqSHVSygTEBGRpt2tPkf
	U8injnXR7WrpUm4SzajbzLiGjryo/CJp0kII3+WHiYXkB4M1vY8GG711zWvsLbk43qdsFO
	upCfQ9WmLax/g4ein58enslVaR1uZrqXZ+54yng1dpbjtC1bVLFoqPGPd1SebV4klf5yGU
	zbluwtfaKjscKtqcrTmEommazq5t2bnf0C0z99tQe3TVkCkkcN2IC1m+d9nlDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760613701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AHIexI7oh85pU2rC4PB6zjKSGbbonpIYsq1vd3KvIys=;
	b=FMgiECvq4iNkCgLqCiEudsSGIjPM4mBrsDqFoCKqFydTesGoFQkRDX5a32bYq1lPZl/69u
	w3KaAT9CKw8AJFBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology,x86: Fix build warning
Cc: Borislav Petkov <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176061369966.709179.2557895434975882601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     73cbcfe255f7edca915d978a7d1b0a11f2d62812
Gitweb:        https://git.kernel.org/tip/73cbcfe255f7edca915d978a7d1b0a11f2d=
62812
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 16 Oct 2025 12:58:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 13:01:15 +02:00

sched/topology,x86: Fix build warning

A compile warning slipped through:

   arch/x86/kernel/smpboot.c:548:5: warning: no previous prototype for functi=
on 'arch_sched_node_distance' [-Wmissing-prototypes]

Fixes: 4d6dd05d07d0 ("sched/topology: Fix sched domain build error for GNR, C=
WF in SNC-3 mode")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/topology.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2104189..df94388 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -325,4 +325,6 @@ static inline void freq_invariance_set_perf_ratio(u64 rat=
io, bool turbo_disabled
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
=20
+extern int arch_sched_node_distance(int from, int to);
+
 #endif /* _ASM_X86_TOPOLOGY_H */


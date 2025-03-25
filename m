Return-Path: <linux-tip-commits+bounces-4475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC7A6EC27
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4CA1896A9E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E653254B19;
	Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tx79y07S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEEdr+eQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E114254879;
	Tue, 25 Mar 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893544; cv=none; b=eQY4BePG4rZ6FLzXVXodid96DY4kRqKZ6+IfXi4sv8+4mwCSKg4/qcKotRZkIBffooxjwdJNdD+6CfpC1IrLh3PEbA36qZOqTpNdo4gK8fOn+H8YeYwZD91Zn0glCjA9qA3YAxo9jJ2ENIScet6DtJsdI5ZNPM0qUY6Ekbck4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893544; c=relaxed/simple;
	bh=LXCW158m+FYQKGXEIbQyFgsTriKbBDpYZC455vhmD9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tx8Wun/rR+lNybLXLRM1qBM+0yfKwIYdTjarxHHwsGfb3/v0gLkUNd9dApbS/1GeDTaKPOUnc9moMp5SZbIqBfW3wB0qn3Vd1DdEc/IBRMQ9cwjBlK4HQ27lJ+vmPNfUqLj55kMuwWeagIuV5W+/F7tDqK/lDqbJl9Jg6VF7GeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tx79y07S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEEdr+eQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD6uibNVpenhXRGzcrHNyQyiS7/aZOspJZN9KvhSRR8=;
	b=tx79y07S/L1MvT0QLwAokdOfpnYUGgdTXQ2KtOjD0qrVQhFBdpz1Q16CloXvXVhSud1YWv
	bErEY2cqZfS2SsFnuf0rz5ExBiIBD1Y2yycExyGCNF00f4SaLs3L7JOUGYrsXfS4fW5WSk
	ZXX4OLaCGaWIz7aXTkHaTPPlHs3c99RCxz6vI05L4NBBF9/9gBEmxJ/7IUaySdI470hHea
	rb8g/Jhfol+Yi3qYytdLq4uswUdcu4K1Tv2PukITeJ/w2xkDQuf7Q/GVJKEe+9cR6DY0Ho
	J2BPQB+GyT3+iFOsv7S+n9pJWgVI8eOYkq0GvOr/O2u0HY27+Vbm0vX8W3Apwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD6uibNVpenhXRGzcrHNyQyiS7/aZOspJZN9KvhSRR8=;
	b=WEEdr+eQ7Se2esABxeSSnbjZdKjrR2jtdvEj5UPbR3M0SYqSEflwcc68ZyBq+/mxDUdPpG
	Fj9x5tikpEig3ABQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Define Transmeta and Centaur index ranges
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-16-darwi@linutronix.de>
References: <20250324142042.29010-16-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353908.14745.12953304603563985943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     87669e74d8481a066eb8d319cef7b2ea93d4e24b
Gitweb:        https://git.kernel.org/tip/87669e74d8481a066eb8d319cef7b2ea93d4e24b
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:46 +01:00

tools/x86/kcpuid: Define Transmeta and Centaur index ranges

Explicitly define the CPUID index ranges for Transmeta (0x80860000) and
Centaur/Zhaoxin (0xc0000000).

Without these explicit definitions, their respective CPUID indices would
be skipped during CSV bitfield parsing.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-16-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index fe3d058..7dc6b92 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -69,6 +69,8 @@ struct cpuid_func {
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
+	RANGE_TSM = 0x80860000,		/* Transmeta */
+	RANGE_CTR = 0xc0000000,		/* Centaur/Zhaoxin */
 };
 
 #define CPUID_INDEX_MASK		0xffff0000
@@ -85,6 +87,8 @@ struct cpuid_range {
 static struct cpuid_range ranges[] = {
 	{	.index		= RANGE_STD,	},
 	{	.index		= RANGE_EXT,	},
+	{	.index		= RANGE_TSM,	},
+	{	.index		= RANGE_CTR,	},
 };
 
 static char *range_to_str(struct cpuid_range *range)
@@ -92,6 +96,8 @@ static char *range_to_str(struct cpuid_range *range)
 	switch (range->index) {
 	case RANGE_STD:		return "Standard";
 	case RANGE_EXT:		return "Extended";
+	case RANGE_TSM:		return "Transmeta";
+	case RANGE_CTR:		return "Centaur";
 	default:		return NULL;
 	}
 }


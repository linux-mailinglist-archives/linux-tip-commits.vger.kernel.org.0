Return-Path: <linux-tip-commits+bounces-4496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3147BA6EC96
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B592016E5F0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3B254B0D;
	Tue, 25 Mar 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N74Lvs+I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAXcHw2W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894211A76AE;
	Tue, 25 Mar 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895382; cv=none; b=KPpoiWB+lyCFJTxSZVKol5zDFngA8m2hV07HPcBzXyhkgNtwv2SmRa0qvdiZt87gvIQZwzGie4QJvxS4b0Wi/ebcRELhWvQXqIHIAK9Bs9CJLhVm11mcVQMEngwUorRxLFr8wAFBc3I/hjHHQeSs8DHgJqvM8WlnhEmsuKn+P7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895382; c=relaxed/simple;
	bh=EPAfTEZ5+/lPqSRev1wz3VNJo3d2SxNOVh9uSm+53lA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GaixP0iZQ11OmecFIg4I1KpO21/BF3FL2WTYQglpERvBDwKdoS19TSXN6g4h7PeRUKjRsDlcpZtGgqK7GJVJGrKYhG+/nkBpFl6v3+vn5/zUQsn99fze1IDu7ZStYJU9o/OzUXQeeCLEY5AEuUvJkOmcgn2U171WRE8bdDesHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N74Lvs+I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAXcHw2W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUadW9tralhg/UueX0RyIn7xKmmWCGCA3H0WNPmgwJo=;
	b=N74Lvs+IwbXE5gsvdAbXCY0P2nHmW78gtt/Vsa0TXS4IKWUjYhJA80DKCskAgjVAJ/Jl3E
	IZ6LzUsrRmTGz27Ve7ydHRhyh++HPHUi2Ak8B6ugCJMedTqDuL8+pBvc97fU7T3D/78Kij
	c+4Bn3/Sh50C5+Nh5ImDFD2Zj9KDmmhQkJuhayKs7KEm0z7WRnkCz3qTLic+hp/qkUdAqy
	RkVmZOfAuWCJnGGM+Onu+xR2M8I6cugJMVW4JIApW28RNQaCKO0MI0gfid1NEQAGewCtOr
	esOuXl53gESXRZ9h217ehyZkMuPSS2GvYckRi44edW6gktsw37SWKlVMAruQHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUadW9tralhg/UueX0RyIn7xKmmWCGCA3H0WNPmgwJo=;
	b=RAXcHw2W1XLKRTiq62IDhUN+ji/44HmSXD1fhufT+LTUPahy/OGNVGHr9CXfPU5TAuATv+
	RMthpHhyoh7urnDg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Relocate CPUID leaf 0x4 cache_type mapping
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-28-darwi@linutronix.de>
References: <20250324133324.23458-28-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537607.14745.2935347826470506217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     eeeebc4fc642f492522e4be92dcaf22119123581
Gitweb:        https://git.kernel.org/tip/eeeebc4fc642f492522e4be92dcaf22119123581
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:27 +01:00

x86/cacheinfo: Relocate CPUID leaf 0x4 cache_type mapping

The cache_type_map[] array is used to map Intel leaf 0x4 cache_type
values to their corresponding types at <linux/cacheinfo.h>.

Move that array's definition after the actual CPUID leaf 0x4 structures,
instead of having it in the middle of AMD leaf 0x4 emulation code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-28-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 231470c..e0d531e 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -78,6 +78,14 @@ struct _cpuid4_info {
 	unsigned long size;
 };
 
+/* Map CPUID(4) EAX.cache_type to linux/cacheinfo.h types */
+static const enum cache_type cache_type_map[] = {
+	[CTYPE_NULL]	= CACHE_TYPE_NOCACHE,
+	[CTYPE_DATA]	= CACHE_TYPE_DATA,
+	[CTYPE_INST]	= CACHE_TYPE_INST,
+	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
+};
+
 /*
  * Fallback AMD CPUID(4) emulation
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
@@ -131,13 +139,6 @@ static const unsigned short assocs[] = {
 static const unsigned char levels[] = { 1, 1, 2, 3 };
 static const unsigned char types[] = { 1, 2, 3, 3 };
 
-static const enum cache_type cache_type_map[] = {
-	[CTYPE_NULL] = CACHE_TYPE_NOCACHE,
-	[CTYPE_DATA] = CACHE_TYPE_DATA,
-	[CTYPE_INST] = CACHE_TYPE_INST,
-	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
-};
-
 static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {


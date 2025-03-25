Return-Path: <linux-tip-commits+bounces-4512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6AA6ECB8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA15167631
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6B52586D9;
	Tue, 25 Mar 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7S+uCbK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDQ+/1r6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DD257AF8;
	Tue, 25 Mar 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895397; cv=none; b=cj7DPwE9Qc4uXwPiNFGBWS93LwvwDbplIN5YLCTSQDEGDVGbzQBnqwwMe0y2wsmSTC32R+vBKsNAadPPBx3qstCYMosIlE+xAI6IRkWeDH9R8oRhm/m2vBupbo+lBGl4JDfmfQJ7h2OLr782iJLLsNcx0rpRkQX6HRiaSL3npiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895397; c=relaxed/simple;
	bh=T2B4fTVddv6fOC8oFwDdkvK9ymsvj6GSnqPB0GjJtSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sbSFzvlbNezzWmfMWTMyFC+hruxZ8jGm4KbohEI7/ADs7NGtuOKTzc+oAm/qGv3WWFjPnkLdiHDlNBM0I4avLu7GJ0q4LuPkJEsYc8E454fYfKPiqxfBbW4QTKyu0J0z+IJRTHQVer8IMipCa+MnUwlWPphZ4WbtL8+5iltrXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7S+uCbK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDQ+/1r6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFs1svWB9JPeEEJmzZUM+94jwfPwqVBAQxNiD/0lTU0=;
	b=O7S+uCbKgyeZOGcZJwImhWctF2LtMx74/i4COQaEt9jf8rA0KDeknkL0f8h69JanvmoTv9
	dIz+FHaflZ0xyKfgFsmn2ElK2jslg6h5/10n6hA2gEJtPPLE+PRxXqIa+Vg1THCvjCi0rK
	84TQVOb51K7w5FGBtAv0TrvOrJkiCNRaLghYIO5fLf1qDrMAvDIGF0WwLg8zdkZRZaRHeV
	ZXHT990lQ1RaLDIfrBHqHoJvhlWQ7LgShuEAuRyFrkEJWvMVXuTPOdGcCDy2IwMFiJwUAA
	XAZE2cbuamP92mvO4jwzdXJi8BJag12g68iSej6kRxtyowPc3+6yK44SW1ofUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFs1svWB9JPeEEJmzZUM+94jwfPwqVBAQxNiD/0lTU0=;
	b=LDQ+/1r6q2CFblN3TAE6ddV/PZm8gLgNyFbA2SgppYK2owSUmpU1UL+xzNr2wrJ7I8nRrs
	ZGh1kFFfyE9x5OBw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Constify _cpuid4_info_regs instances
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-9-darwi@linutronix.de>
References: <20250324133324.23458-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539307.14745.4461276325895313240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7b83e0d2b20b38a025d15ba88516c1b8fe9c6f3d
Gitweb:        https://git.kernel.org/tip/7b83e0d2b20b38a025d15ba88516c1b8fe9c6f3d
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:23 +01:00

x86/cacheinfo: Constify _cpuid4_info_regs instances

_cpuid4_info_regs instances are passed through a large number of
functions at cacheinfo.c.  For clarity, constify the instance parameters
where _cpuid4_info_regs is only read from.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-9-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index be9be5e..fc4b49e 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -841,7 +841,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    struct _cpuid4_info_regs *base)
+				    const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -898,7 +898,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 struct _cpuid4_info_regs *base)
+				 const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -933,7 +933,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, struct _cpuid4_info_regs *base)
+static void ci_info_init(struct cacheinfo *ci,
+			 const struct _cpuid4_info_regs *base)
 {
 	ci->id = base->id;
 	ci->attributes = CACHE_ID;


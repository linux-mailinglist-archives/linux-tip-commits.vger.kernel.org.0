Return-Path: <linux-tip-commits+bounces-1910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15E9458C0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED14282588
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4208C1C0DF7;
	Fri,  2 Aug 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUaa0t3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+FUZfBmg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAD1BF334;
	Fri,  2 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583731; cv=none; b=R8CQVJuPLTS8GwYwqqvY0UroRCq8gUgsoaLwwCbyO+UsG4wA7C0y1SrdLaBRdWu192oOvZDsuDmdsda368yYSdBl5W4aJ9HRaMph52yHHxx5kdlFXyBjM28oztVdMmLM4hyxbmIA5dt5IGjLhBLhnhhyb/rJqT17s+bp55zg9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583731; c=relaxed/simple;
	bh=BP2EQjdnb+3NpTozPSNCgVbJM1mUKscahB53+FBOaH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MfpA9zcwQIQD3q152R6cv2Ox9HES9LDXmeqFf/mtU/xbsY87LGPp5GFYHFvRi2TxiCwbbx894MhpquHRECL/+LhwNEvGOI92ssblW8cwPKTtR9MRTj+SiHkt/QZNFlKno+EjMYx/P4uO9/lEcOXYgV4EiIvFO31r2B/eUWmR2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUaa0t3c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+FUZfBmg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnqjfJKUeztmYYh2La0KcUAR6t3tKvfis029yz94QWs=;
	b=iUaa0t3cLV+Hm6REIxd9jM+QqVV8ag2onx3kce6hY4auzWYxtPLeKbyzPyfN6lQm7+0yIB
	soa5w1PVn+BWtDW/BinsQBaTKjh9lPSSdu12pnGzffpvY+Ldu+AcTuDsDqo2VdcBGYS/ee
	V6sOu59ENqOUEQzlAoc1WC+WHjm1C28xcRmuxIx9ItHA0BXqyODDjrtuEZOl9zII3D12Vw
	84T7spc7gJ6S13gmBqHvSEUS5q/NjLc9lLI5kxES/6QHVuRImCnvV9OHwSkUQAmEvEJzQw
	axk+AMf5mBEZ4O6mFsVBiNSUq3z0NSNXIM18+s81TwFYBkjBTUuHjphVzobwVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnqjfJKUeztmYYh2La0KcUAR6t3tKvfis029yz94QWs=;
	b=+FUZfBmgzMiWxC4u0Wac4dTj5npi8otMkwv2SjjFDXM+/wLoKiUgya28sL9+lFPL75MaeP
	znKMMlHQWYUgSfCA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] tools/x86/kcpuid: Properly align long-description columns
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-3-darwi@linutronix.de>
References: <20240718134755.378115-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372597.2215.17899593830433414242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a52e735f282c963155090d2d60726324ccd0e4bc
Gitweb:        https://git.kernel.org/tip/a52e735f282c963155090d2d60726324ccd0e4bc
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:18 +02:00

tools/x86/kcpuid: Properly align long-description columns

When kcpuid is invoked with "--all --details", the detailed description
column is not properly aligned for all bitfield rows:

CPUID_0x4_ECX[0x0]:
	 cache_level        	: 0x1       	- Cache Level ...
	 cache_self_init     - Cache Self Initialization

This is due to differences in output handling between boolean single-bit
"bitflags" and multi-bit bitfields.  For the former, the bitfield's value
is not outputted as it is implied to be true by just outputting the
bitflag's name in its respective line.

If long descriptions were requested through the --all parameter, properly
align the bitflag's description columns through extra tabs.  With that,
the sample output above becomes:

CPUID_0x4_ECX[0x0]:
	 cache_level        	: 0x1       	- Cache Level ...
	 cache_self_init     			- Cache Self Initialization

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-3-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index e1973d8..08f64d9 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -449,8 +449,9 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 		if (start == end) {
 			/* single bit flag */
 			if (value & (1 << start))
-				printf("\t%-20s %s%s\n",
+				printf("\t%-20s %s%s%s\n",
 					bdesc->simp,
+				        show_flags_only ? "" : "\t\t\t",
 					show_details ? "-" : "",
 					show_details ? bdesc->detail : ""
 					);


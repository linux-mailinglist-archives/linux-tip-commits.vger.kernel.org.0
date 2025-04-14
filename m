Return-Path: <linux-tip-commits+bounces-4954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1CA878D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7A01637A8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC91DC1A7;
	Mon, 14 Apr 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOcJKoms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzdcFMs/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806B19597F;
	Mon, 14 Apr 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616087; cv=none; b=SRj/+IJj9or1ZpYKFMWyxNwgBf9BEaEkQsFkt1adnRH7Ib/ylihbQhvgkJC4Mh3tgy4eUTvTK2c7/iMHmKnYVUGOIPDt/TbBjJBeIHMmLdek0Gu4ROCUWPHSH2lNY78+qMdfCR29lRiIKOsYNQbP5l40WMJQjkLxl/Y+qng1XCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616087; c=relaxed/simple;
	bh=C/urSx5Sfop9DHTUEjJi654T8mODpaZgDmLip1+mu1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RIcpugKAc/l+MOS1l64dTAzrL9uGegE2wYC4mvJhcsbHEajFqgHNR7NUpoZDp/HDH1SjJk6dBZ2UO880GeF6mGXQpKGJ9EvVmRZplnWTl8RcadWyL6pcv+/7Fzak07kdiPue+nb0RrOVwPPH5r8SZoc4D28r5FR8OelBoCzIydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOcJKoms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzdcFMs/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVKWEwdZUqmFRh+kAjI6nl/4uFVQPa3tqO0WIQhrOIs=;
	b=TOcJKomsXsZ/SRX47KOYODG5MgWEpm+dJbDHEQ2oxIJHFbNuEDx6T1y2txu3+sDxpMsx/r
	3iyo15rPntUs8rFvqvteHNM419kw3XpMA1wlI7vJheE8TxH34pQeAw23WqdwQS93H4GjCB
	vvGTvDD5yF2nLE33XO0y2Yax0mF7Tey86uHWlnOcLM53pY1mL+A6CG6NcFxXFJWOBFIQ3A
	6avhlkjBeo6qOElZDsuR3SVgQAH8bothwTeBX+Z0Q7E/vTBswUhbRK0OvWP+qfvTHnenuY
	xpcC9S1NiyDxE/xE9mk0X4pqdrI1w89AlOG9zr3fb15StcJWOCpn+m81WEBa5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVKWEwdZUqmFRh+kAjI6nl/4uFVQPa3tqO0WIQhrOIs=;
	b=BzdcFMs/2veyiIDXry5qC/RHEqcfSLEgikIrIcJ/m7YrvcbUokkwBYiROkV3kFlCEhRWBS
	KrDhcE87jfwAZmBQ==
From: "tip-bot2 for Pi Xiange" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add CPU model number for Bartlett Lake
 CPUs with Raptor Cove cores
Cc: Pi Xiange <xiange.pi@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414032839.5368-1-xiange.pi@intel.com>
References: <20250414032839.5368-1-xiange.pi@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608376.31282.1274518591545382020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f3b9b7278259477d03dc643058fd9de9369290cb
Gitweb:        https://git.kernel.org/tip/f3b9b7278259477d03dc643058fd9de9369290cb
Author:        Pi Xiange <xiange.pi@intel.com>
AuthorDate:    Mon, 14 Apr 2025 11:28:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:25:07 +02:00

x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores

Bartlett Lake has a P-core only product with Raptor Cove.

Signed-off-by: Pi Xiange <xiange.pi@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250414032839.5368-1-xiange.pi@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 3a97a7e..405bde6 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -126,6 +126,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD) /* Redwood Cove */
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_RAPTORCOVE		IFM(6, 0xD7) /* Bartlett Lake */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */


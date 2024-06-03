Return-Path: <linux-tip-commits+bounces-1325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6C38D7EBE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9931F27B36
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24285950;
	Mon,  3 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeuaKFCR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLWLgWZH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430E85926;
	Mon,  3 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407012; cv=none; b=bxooOoRN+zIMY8/GAaFinydfrmcIbs04XgekBlyJLA98acKZ0j8mi6ejf02FP9OiVaMxP/tmq3lIYs+wM2LzXGKRQqmmjeBTZGfmX8kiTq2OpkU1xZPRYB5oVaxdG6F/HSB37WUbzGoh4fVMPSY8aKKa4gIJvMEAEBQdgNQPRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407012; c=relaxed/simple;
	bh=JRjM954ahZNzNjeArYEL60+w7yyb/eUtkYULAldKVVA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rN6pK6y8umcpLOGavOonZkdmiZPiL2l0achoKDQJqpgM8jzDpfugM2F+F9oYO+et0Y/BXMzSPGYcf0imIyZiLeh1Qf3UqUvnIEIXZtZ7+xhK52rOHmdfam2LaglqJKDdQrXnwnupHfQ7pdK321j3xBRIZPorUMk/ybdXsDOrFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeuaKFCR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLWLgWZH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2gYZ2ttTD9n4alJBc3z1iW+TxngHiA3rj80v8+qkjg=;
	b=UeuaKFCRNfKr5CjJFMwy/ou4O3S45fX22+3rAHe2+WkprGRU+kCqI+ZXj/xenMBZ4x0T78
	PJ7jaRYv0KEx/drYXxTAIV+6opBNTiBHF+w5acDBK1WV6jbzD/tLZ+A+6exeJauN6ge37Y
	G8ERUxKlCIzgE7teXQOl9Qq9BtE+aDFQuh+XKcGB4YHso2fh3yxH2b6uy/XT/MbpMksDNT
	+tjs/2L0NaKkwZtITJ22D6FDz7Nnq7jmtwsmuZaHCWM8Nd7FE3J3wftwwxdtUN5DigAz24
	hQ7+1VSo6Xu0Y8IdhwA6sMpCTFL6BlsfdW2hcOqnivGnpEFe5Elvvt1JDcA/zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2gYZ2ttTD9n4alJBc3z1iW+TxngHiA3rj80v8+qkjg=;
	b=mLWLgWZHRLtHzzk1T5FbgQRvV6IO4GNLiry/nAessMBQog7kzRJP7ZhfwNYqNxeLmniIZq
	xeL0cJQdTXLxnMCg==
From: "tip-bot2 for Lakshmi Sowjanya D" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] x86/tsc: Remove obsolete ART to TSC conversion functions
Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-9-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-9-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700813.10875.1504437009909838616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0f532a789f1b24258043d0f856409d2ab974fb64
Gitweb:        https://git.kernel.org/tip/0f532a789f1b24258043d0f856409d2ab974fb64
Author:        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
AuthorDate:    Mon, 13 May 2024 16:08:09 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:51 +02:00

x86/tsc: Remove obsolete ART to TSC conversion functions

convert_art_to_tsc() and convert_art_ns_to_tsc() interfaces are no
longer required. The conversion is now handled by the core code.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-9-lakshmi.sowjanya.d@intel.com

---
 arch/x86/include/asm/tsc.h |  3 +--
 arch/x86/kernel/tsc.c      | 60 +-------------------------------------
 2 files changed, 63 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 405efb3..94408a7 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,9 +28,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d1888db..d4462fb 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1297,66 +1297,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art, art_base_clk.denominator);
-
-	res = art * art_base_clk.numerator;
-	tmp = rem * art_base_clk.numerator;
-
-	do_div(tmp, art_base_clk.denominator);
-	res += tmp + art_base_clk.offset;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timestamp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the ID of the
- *	corresponding clocksource:
- *	cycles:		System counter value
- *	cs_id:		The clocksource ID for validating comparability
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art_ns, USEC_PER_SEC);
-
-	res = art_ns * tsc_khz;
-	tmp = rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res += tmp;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**


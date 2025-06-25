Return-Path: <linux-tip-commits+bounces-5912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE8AE898F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A283A2B20
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BA2DAFD3;
	Wed, 25 Jun 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvWvxWCO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ibr6b8qT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403B2DA779;
	Wed, 25 Jun 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868172; cv=none; b=S8O7hrmFJDtgalQfn1TOFOQMkJviE2UiI+lW++PB+HeKutW5bEQolOxtaJ1yvDaACPDXPYqPFjG/l0BCg/+/DDpaH0oxsXaphYJ2ZRnQiHlu8gyl4uxReo4hHVU0OSQOleHGewGvm4RXdKlwA+jnTxYo+xOCwTu5pa8Q+VfUwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868172; c=relaxed/simple;
	bh=dZFGOrKMxjUsIAem9R1RKPVwXdQGmKlwNsQq25QtCVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ml33SYJdPcY4jEbANab6t0cQUpNWI/wSboBdI4cRWtfELIDtnWHrF4nzzJMvfUuup90A83TfR4cqIJOnlCfd1mGd2q4MPKkBg1X/Bv6hZT3Eo2BPwY0LDYIMIMgt4bWZs34GKIUdZq8YHcBT2PpPpMW+u4BodJI1WVG2toK4xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SvWvxWCO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ibr6b8qT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+ccQJv3uyqCoOzRKHlh7ybJKk2k81AW/xPRjsq9ix0=;
	b=SvWvxWCOb+9GZKVAse3N9pB1VnEOx3Caz6yvhFQdDLy8yyTW0VWvPPRLxuBqPvwt3G12qU
	uxpEUzIiRPJYDzvuc8qj97t3Z1ARwMtvJy5MFB1rGPzJJVxF7N0Rv6NeHbBMUggzjCdsal
	dGVA/dlDi/eyIx5tpv7EvhBeKhaFG0IyDAXbEE4QwX1yV2/5ylyYfXXrgTvTN3IX7tzd9A
	gB6m9B+irXllERNcKKMEhNBGbYACD4UAjWpcsQlYxI9yKXbEewIxQOIzW7raMnl6ZU1sdm
	+s7rlxMnlHlS1KjHg9nazAr/U+kxkJbVnSlc3ue/aE1EBleZFHG/Oe6hX1k4Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+ccQJv3uyqCoOzRKHlh7ybJKk2k81AW/xPRjsq9ix0=;
	b=Ibr6b8qTPlJJt7B/Te1d2Gq4eU/78PWu1a7HFK5exc3HIF4O2tu4+MukvvEeknnthKvY1w
	vTxPpEoL+GbmmTBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Cleanup kernel doc of
 __ktime_get_real_seconds()
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.715836017@linutronix.de>
References: <20250519083025.715836017@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816836.406.3815908813294281452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     506a54a0316ee4854b0ed113a8001477f5211d50
Gitweb:        https://git.kernel.org/tip/506a54a0316ee4854b0ed113a8001477f5211d50
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

timekeeping: Cleanup kernel doc of __ktime_get_real_seconds()



Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083025.715836017@linutronix.de

---
 kernel/time/timekeeping.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2ad78fb..d88d19f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -975,9 +975,14 @@ time64_t ktime_get_real_seconds(void)
 EXPORT_SYMBOL_GPL(ktime_get_real_seconds);
 
 /**
- * __ktime_get_real_seconds - The same as ktime_get_real_seconds
- * but without the sequence counter protect. This internal function
- * is called just when timekeeping lock is already held.
+ * __ktime_get_real_seconds - Unprotected access to CLOCK_REALTIME seconds
+ *
+ * The same as ktime_get_real_seconds() but without the sequence counter
+ * protection. This function is used in restricted contexts like the x86 MCE
+ * handler and in KGDB. It's unprotected on 32-bit vs. concurrent half
+ * completed modification and only to be used for such critical contexts.
+ *
+ * Returns: Racy snapshot of the CLOCK_REALTIME seconds value
  */
 noinstr time64_t __ktime_get_real_seconds(void)
 {


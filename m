Return-Path: <linux-tip-commits+bounces-3404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDCA39708
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B90B177EB4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2222DF8C;
	Tue, 18 Feb 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvGtG8ji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZeM8H5u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D422FADE;
	Tue, 18 Feb 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870738; cv=none; b=rV3y4Sjzs6J7VgH1SNu4EgnO1Rqh+0bq+/UhSIwa8BSmWealU/lLyWhprXMPBa/IDgwmdijFMaViJwMnF92PzgugjntMnLDXp/l84mqLMg38/EOkwuNuf1XS5rd4IGigvejnyLso0AuYUFRSwRJIEn9LZx3v7J/Gbk6t2hhklzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870738; c=relaxed/simple;
	bh=Otrp71BePA9KmeNJb7B89ombm1tJBYu1MylMinLAKco=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BR45lwa122uJxHs96Afa6nlnMANB5clPoW8fiKVecsGebTg7uoFTbJih1VR+OJamwvmfwSshPaQEnd3CihBDy7mp8AHKONO/kBorKC0DKuM+54IWqmT/HtAC267v7Gmxyk34aJRKlEfDFIQKontyJG0sgz/W5vONrljSaxGgtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvGtG8ji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZeM8H5u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:25:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739870735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hik2mAtUpxxD2y9GWCFEyTDkFM2Se1NROgPC3yboXc4=;
	b=bvGtG8jimPX4mCIOdzLEfk1WBJwNxcYnPWZt9QjJ6tHO4Iq1/N5ypdxT5DR7oF+G4Pq4J0
	Z5+SN9mkCxcPGaZwLlivHocafdj0koDBZvTv/flH7crCGms2dJUjsmk6dfDV5hSDvQEefQ
	1+K72pqk6Wrw59sF/4Zc6sSOal/POVnanbNhwHJ4weFB1pv2yyQ7QyuMkiqv3gcgeBOA0U
	hIcx5Ll6qeueNaSqZYLBZJ6K/vHW+yngKZ3ea0GeoafU5plbn2AJ/K3Qf0LE6e8T+kiPic
	38S9olzAeHJcdbT78DA1fxvf8qmpo/5u1sh/tyWG99/8xypMCT0QrKpRdi4tNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739870735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hik2mAtUpxxD2y9GWCFEyTDkFM2Se1NROgPC3yboXc4=;
	b=iZeM8H5u3b+hoYCSvGqmfreHBRk5lcTR+Rhf6wGgcfzOENWL8H9r0BJ9yyQ9YiYKZKZo3G
	sZdKf+94S02RxkAw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Replace hrtimer_clock_to_base_table with
 switch-case
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214134424.3367619-1-andriy.shevchenko@linux.intel.com>
References: <20250214134424.3367619-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987073439.10177.6616090097392460077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4441b976dfeff0d3579e8da3c0283300c618a553
Gitweb:        https://git.kernel.org/tip/4441b976dfeff0d3579e8da3c0283300c618a553
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 14 Feb 2025 15:43:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:12:49 +01:00

hrtimers: Replace hrtimer_clock_to_base_table with switch-case

Clang and GCC complain about overlapped initialisers in the
hrtimer_clock_to_base_table definition. With `make W=1` and CONFIG_WERROR=y
(which is default nowadays) this breaks the build:

  CC      kernel/time/hrtimer.o
kernel/time/hrtimer.c:124:21: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
  124 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,

kernel/time/hrtimer.c:122:27: note: previous initialization is here
  122 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,

(and similar for CLOCK_MONOTONIC, CLOCK_BOOTTIME, and CLOCK_TAI).

hrtimer_clockid_to_base(), which uses the table, is only used in
__hrtimer_init(), which is not a hotpath.

Therefore replace the table lookup with a switch case in
hrtimer_clockid_to_base() to avoid this warning.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250214134424.3367619-1-andriy.shevchenko@linux.intel.com
---
 kernel/time/hrtimer.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index deb1aa3..453dc76 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -117,16 +117,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
-static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
-	/* Make sure we catch unsupported clockids */
-	[0 ... MAX_CLOCKS - 1]	= HRTIMER_MAX_CLOCK_BASES,
-
-	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
-	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
-	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
-};
-
 static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -1587,14 +1577,19 @@ u64 hrtimer_next_event_without(const struct hrtimer *exclude)
 
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
-	if (likely(clock_id < MAX_CLOCKS)) {
-		int base = hrtimer_clock_to_base_table[clock_id];
-
-		if (likely(base != HRTIMER_MAX_CLOCK_BASES))
-			return base;
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
+	case CLOCK_MONOTONIC:
+		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_BOOTTIME:
+		return HRTIMER_BASE_BOOTTIME;
+	case CLOCK_TAI:
+		return HRTIMER_BASE_TAI;
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return HRTIMER_BASE_MONOTONIC;
 	}
-	WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
-	return HRTIMER_BASE_MONOTONIC;
 }
 
 static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)


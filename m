Return-Path: <linux-tip-commits+bounces-1927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0879461E9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE1B20EE1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF02136333;
	Fri,  2 Aug 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvEY/w7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6tJVQaA/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C016BE02;
	Fri,  2 Aug 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616985; cv=none; b=pjBnrCRg1WrvNQlYnZkh4zPGo77PQ7oEHjAXhIdqSqNhE1nO2tIGU1dVXPCOgXTTJNkje1wJa60h5HCtalTOhqLD4g/o5kJhotq/6Jk1MLw2M/CBUHqJc8mfWH/NcGzt/aZBOXHLVHobOMDhLsJtiHD5D72/XjywUBP4iytPqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616985; c=relaxed/simple;
	bh=YZZFREvXBaBuxgoKpL7dT0rkUj4scN5bZIzFV5YIFbo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WrxbciCkVkMiNvZhZL/mHB8hXspUPaqA8ggCrIEhXfeoNOzDFA7Uij0fIf/rghhXenT6Ph12aPHActh4vkh2QckaCZnoyLQCp1JZqe6wC0Uz77fDRCK50OG4IqRwWj5AZ7q0XJCUqdsePl1KiurGLxEgZoVeyJmoEsuNDmWo+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvEY/w7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6tJVQaA/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+3Og5NB1Eovsd8Mw82lvLN3mq5UmaYgt/Ya442vhUU=;
	b=ZvEY/w7vV3X3Edy/GykT3hcauZoBpkGVjnfMxvd4HLBeNqYGJeQAJc5+0+2Cypidad4hZo
	cHNZWaOyn2dwuV0QKDcjE9y5b8U7fn/Ai3dmsp5eQCIp/YD2pkcJxd1oPpSSjwv8+7Utn4
	s8mrTv/SzyjmKu5b65OY0dEbFgUrdOAHNOxZS1+xvLDHBkVrFGdkyc3XoXnMa/xlr7xAru
	GiVyrPEtYhTRsmRDz9KXQVyijwGxj+H2DhO/pwaU1Ml5S1C+XoclEExzWQgKho8fDy5780
	UtVPacd5+zDpyLpvp8h91r1DUC9+G/wMuAIegTgmI+Uc7HCJZJ1YJyz3Y7ZjwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+3Og5NB1Eovsd8Mw82lvLN3mq5UmaYgt/Ya442vhUU=;
	b=6tJVQaA/bvR/RnwECjIsBxHxpioO0RK91fFxAF6ukWPz6rnZmCEWlTXHRCyXLmaX4yAEn1
	em0JcEvuCFh3FzBw==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource: Set cs_watchdog_read() checks
 based on .uncertainty_margin
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802154618.4149953-4-paulmck@kernel.org>
References: <20240802154618.4149953-4-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261698202.2215.2818689375196414577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     4ac1dd3245b9067f929ab30141bb0475e9e32fc5
Gitweb:        https://git.kernel.org/tip/4ac1dd3245b9067f929ab30141bb0475e9e32fc5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2024 08:46:17 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:37:13 +02:00

clocksource: Set cs_watchdog_read() checks based on .uncertainty_margin

Right now, cs_watchdog_read() does clocksource sanity checks based
on WATCHDOG_MAX_SKEW, which sets a floor on any clocksource's
.uncertainty_margin.  These sanity checks can therefore act
inappropriately for clocksources with large uncertainty margins.

One reason for a clocksource to have a large .uncertainty_margin is when
that clocksource has long read-out latency, given that it does not make
sense for the .uncertainty_margin to be smaller than the read-out latency.
With the current checks, cs_watchdog_read() could reject all normal
reads from a clocksource with long read-out latencies, such as those
from legacy clocksources that are no longer implemented in hardware.

Therefore, recast the cs_watchdog_read() checks in terms of the
.uncertainty_margin values of the clocksources involved in the timespan in
question.  The first covers two watchdog reads and one cs read, so use
twice the watchdog .uncertainty_margin plus that of the cs.  The second
covers only a pair of watchdog reads, so use twice the watchdog
.uncertainty_margin.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802154618.4149953-4-paulmck@kernel.org

---
 kernel/time/clocksource.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ee0ad5e..23336ee 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -244,6 +244,7 @@ enum wd_read_status {
 
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
+	int64_t md = 2 * watchdog->uncertainty_margin;
 	unsigned int nretries, max_retries;
 	int64_t wd_delay, wd_seq_delay;
 	u64 wd_end, wd_end2;
@@ -258,7 +259,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 		local_irq_enable();
 
 		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
-		if (wd_delay <= WATCHDOG_MAX_SKEW) {
+		if (wd_delay <= md + cs->uncertainty_margin) {
 			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
@@ -271,12 +272,12 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 		 * there is too much external interferences that cause
 		 * significant delay in reading both clocksource and watchdog.
 		 *
-		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
-		 * report system busy, reinit the watchdog and skip the current
+		 * If consecutive WD read-back delay > md, report
+		 * system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
 		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
-		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+		if (wd_seq_delay > md)
 			goto skip_test;
 	}
 


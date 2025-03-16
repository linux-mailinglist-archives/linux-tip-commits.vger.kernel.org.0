Return-Path: <linux-tip-commits+bounces-4236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E97A6358C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3038816DFCD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F61A3142;
	Sun, 16 Mar 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyh/9KqN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvHRzsjx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70A19E971;
	Sun, 16 Mar 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126790; cv=none; b=PjevEcmC9RJJJmw4pqWUhrCZQn05JSN9KaQj26ANQUzdKD66G5KLrk/ssWw1UQCWSKGuqyk7zHp91XNTwiMBJyCd5YbgvhVNPnhhWgM0SF1CcfBWUplwskirSo47WT2IQ35IFhKfD4u2MmOPdd2FJsAFlU9aA3IoWh+pcLCdzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126790; c=relaxed/simple;
	bh=0JRQnEypsEBYBrLBpNDmer7L88pYWOaTFd5X3IG7JHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YsYKAyMqRq5pN2OIUTfptlnz8NFikWMWUkixk8b0ccKABhXAa9J+dkTojv9OpMDB7l8IeArybowoE1znwS18F0CoQjE/pNIdjHXH1kWSebNg2394xGk7nCH1rpAHwox9XxHorgC7l9X8KQJ6wwMNlrmfj9aEGYtMqc6s2+tx0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyh/9KqN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvHRzsjx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 12:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742126787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHBkBFbyqhKExGSnG3I967hul0QxOts6+lxLyQSSeXk=;
	b=jyh/9KqNl1rTaSZ5ykD/6V0juJlPE42pOfBjwSAMBTxu5c/+G9S7DTpJ48TWaqP5x4EudT
	fCjzuYrlQu2ygKSM7d+kbf/+PazE52UuPwKfYFydssOWbjdD436m1OVXrnHsw555Rslz+R
	5xbGf2Sf3JFOXR6olxZnmPYCrz2vzV47iYwYrdGWc+yby+oWLb1jcIMeBt+WP772OgQPkp
	0ZIdWKqnYSF+f1dlQe8+NpUgu78Yd2gAmHL5Rfx25GeG05to6IfDqNQfVoBNAr0/ebhnqn
	nGEmh9pBRu7ecdzC/4m0ipJBlDcYMdz4F4srsWnRP3lukB81klYFiq81KAsd7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742126787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHBkBFbyqhKExGSnG3I967hul0QxOts6+lxLyQSSeXk=;
	b=LvHRzsjxsCSAgzHW+xT4VHzYp5BJS6LymQL11nBJIbV+nsiq+TSLWvT0WgP2c7AaTtP50J
	yzn32W3Xajkh/GDw==
From: "tip-bot2 for XieLudan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Use sysfs_emit() instead of scnprintf()
Cc: XieLudan <xie.ludan@zte.com.cn>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250315141738452lXIH39UJAXlCmcATCzcBv@zte.com.cn>
References: <20250315141738452lXIH39UJAXlCmcATCzcBv@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174212678355.14745.11221386085667623478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b6ecb57f1fec114cfa19b1bf06f25f904ca928f9
Gitweb:        https://git.kernel.org/tip/b6ecb57f1fec114cfa19b1bf06f25f904ca928f9
Author:        XieLudan <xie.ludan@zte.com.cn>
AuthorDate:    Sat, 15 Mar 2025 14:17:38 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 12:38:27 +01:00

perf/core: Use sysfs_emit() instead of scnprintf()

Follow the advice in Documentation/filesystems/sysfs.rst:

  "- show() should only use sysfs_emit() or sysfs_emit_at() when formatting
     the value to be returned to user space."

No change in functionality intended.

[ mingo: Updated the changelog ]

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250315141738452lXIH39UJAXlCmcATCzcBv@zte.com.cn
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e7d0b05..2533fc3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11713,7 +11713,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
+	return sysfs_emit(page, "%d\n", pmu->nr_addr_filters);
 }
 DEVICE_ATTR_RO(nr_addr_filters);
 
@@ -11724,7 +11724,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->type);
+	return sysfs_emit(page, "%d\n", pmu->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -11735,7 +11735,7 @@ perf_event_mux_interval_ms_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->hrtimer_interval_ms);
+	return sysfs_emit(page, "%d\n", pmu->hrtimer_interval_ms);
 }
 
 static DEFINE_MUTEX(mux_interval_mutex);


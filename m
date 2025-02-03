Return-Path: <linux-tip-commits+bounces-3309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17BA259C1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A45A1887203
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CA20550C;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aA+iLX9W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0GNq5CS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21092204F82;
	Mon,  3 Feb 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=E1I0VM5XbDAYUbT1/OEftkAeppei8TEdzM+LkxSFNOIf8R02yFDNm7KK5J6r5R/w0dYRM8onBkHiI70e4ecDMwmteiSZfS9agVw023eQJ7Gg1d5zbmhn0cBQQj7XOHTvEgFlek7v5wfPHGk9TIaCo8renBTyYkzLzHZdN11KddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=WIUm3+LwImYx6n4WCijMJRe6Ir62MAPQW+vOEPw/8qM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kp6s4VT+P8/DzxzLSe1Zx0NeboIXstRuqaQGD6sqCV9UgKKhU++/VZV/J+Jn91F91bJMyBhHnFf586CrsvZUtogvNDnRrarbnR12cTcgkAgTkP0Kl4XqY5O7hpXfx+zlhCs3YJZ+HbyWJ93fu7iEp+zXWNJRtZVCVPr9KaAfIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aA+iLX9W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0GNq5CS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kLDun1gneFBdWYqZv9n7G7pbLgN24D2/TmiVhrNy6I=;
	b=aA+iLX9WUO6LfwmHVHx5tgX24Lhe+X4KtVrLgJA3mFUishOtJrP4x75o3xC/tuWyUwNTtS
	yWo5Z+623yeTDouazXjQyUwqm73iQmeB473kcgkX3FVjBL2Xo3cwthf4g5NZZKzivj9+GV
	drQ8yjqR42qTo9vmK8ABtlZb3Ax5ve0wxJrq4YjglAY2xP1veHO7Ex1h03YrXx8z3DWnWO
	ncVtsnVzvCIm7bjyOE3Z2Qy96fNTzBc1XCyjl3CcOXJRWSvaxzd2f+BjA7pa3JtVt0h9mR
	7kjWweI2ak4KEh+Ut4/cz4nGUF8LE/FG5SJ9dxIj6CuXjsrK6mlQCE/NG1DU5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kLDun1gneFBdWYqZv9n7G7pbLgN24D2/TmiVhrNy6I=;
	b=r0GNq5CSxPjMimqKhLt+zN5TAUM02YzmWkqDbCFos3musdu/jbIu8H9ZkkYg5YHWVBY3bS
	eZh810Ilzs4TO9AA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Ceil sample_period to min_period
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-9-ravi.bangoria@amd.com>
References: <20250115054438.1021-9-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689799.10177.15849214227121985213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fa5d0a824e3bbd1f793d962f9e012ab0a8ee11c5
Gitweb:        https://git.kernel.org/tip/fa5d0a824e3bbd1f793d962f9e012ab0a8ee11c5
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:37 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:06 +01:00

perf/amd/ibs: Ceil sample_period to min_period

The sample_period needs to be recalibrated after every sample to match
the desired sampling freq for a 'freq mode event'. Since the next
sample_period is calculated by generic kernel, PMU specific constraints
are not (explicitly) reckoned.

The sample_period value is programmed in a MaxCnt field of IBS PMUs, and
the MaxCnt field has following constraints:

1) MaxCnt must be multiple of 0x10.

  Kernel keeps track of residual / over-counted period into period_left,
  which should take care of this constraint by programming MaxCnt with
  (sample_period & ~0xF) and adding remaining period into the next sample.

2) MaxCnt must be >= 0x10 for IBS Fetch PMU and >= 0x90 for IBS Op PMU.

  Currently, IBS PMU driver allows sample_period below min_period, which
  is an undefined HW behavior. Reset sample_period to min_period whenever
  it's less than that.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-9-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aea893a..7978d79 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -457,6 +457,9 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
+	if (event->attr.freq && hwc->sample_period < perf_ibs->min_period)
+		hwc->sample_period = perf_ibs->min_period;
+
 	perf_ibs_set_period(perf_ibs, hwc, &period);
 	if (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_OPCNTEXT)) {
 		config |= period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1191,6 +1194,10 @@ fail:
 	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
+
+	if (event->attr.freq && hwc->sample_period < perf_ibs->min_period)
+		hwc->sample_period = perf_ibs->min_period;
+
 out:
 	if (throttle) {
 		perf_ibs_stop(event, 0);


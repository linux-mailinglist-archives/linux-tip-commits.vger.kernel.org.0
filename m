Return-Path: <linux-tip-commits+bounces-5143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C77AA4A7A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A1F1662FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1F231829;
	Wed, 30 Apr 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOzf0WY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z59D/N6x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B72580DE;
	Wed, 30 Apr 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014334; cv=none; b=STjU4vZfHzBDLJs1F//OTR4oyb61xZch5n20ewcv1Lti+4XwbCXGbSNdVLBRawBBgIghaw/yQsRw5R8ED4IHSB5pvRHM7J+gH/e0sWJ56BWrKwIYvH7emIVTGV/TYlQ6yxL6szGBa3wzLySTEL7+wcbonosD2aBfgAnRnWadCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014334; c=relaxed/simple;
	bh=iAMdlE5ijQ+HwHWj6z+tiNzc6psQ8i1lK86/btaTGUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L3mcFE6py7sdFvPfNKWHUuarLzJHkUpX5fpp0XOqQvng3z14xvetYrLXMA5boEHwqO4aRg+AQ/PWLRaBtV9PHWKTa3T7EYlDttMpcxz+UTLdpMWlvkFiRGvjGEVbQaIOD/IDNwN5L+QPGcYoJRWwzt3MqYF8rfN1bQRUUu3clfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOzf0WY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z59D/N6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDc3ZpdXq7hOb19gHXk3eWeFeMu/9LjDkpGigIyWA/c=;
	b=SOzf0WY/ejmIXGti388XAcLI+6lalw5uWSc4DzWR9MWPM8VvrpP3ec2bJGZlwLhERpgDKy
	8KPcNwDzGG3MZeuUTeJmZ1foAh2yjNj3NIoi3+LsbhuYYAZzD98ijpjwxvOMVfkT/eYj6P
	FL5ledhvtdXolTwN3PjS6M210trijrMM6JB2K9qBJAiESK2W+oj1mt3+v+108qBRcnnr1T
	kBkCSfWNlaYHbethKRZkiuHAp8l/vJ0iCuTdFqDkSO3pfhEDbszkIcXSAepgkkX0dXrs2U
	TzRVs0UctcjTkbI/og1u263hUCxRIJ6eSUYFUF4XhfhS+0vMiaK+y8lJjrHfFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDc3ZpdXq7hOb19gHXk3eWeFeMu/9LjDkpGigIyWA/c=;
	b=z59D/N6xr2EKHdEIEWaDr1zCY1JjXdNwEpFBXSikRKoqt9YiwrGhlUGdQyoanVnLaV4Hjs
	+FZHoVPfnk0m4gDQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Optimize the is_x86_event
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424134718.311934-5-kan.liang@linux.intel.com>
References: <20250424134718.311934-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601432586.22196.10566021473087857537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e830f657f69ab6a4822d72ec2f364c6d51beef8
Gitweb:        https://git.kernel.org/tip/3e830f657f69ab6a4822d72ec2f364c6d51beef8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Apr 2025 06:47:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:22 +02:00

perf/x86: Optimize the is_x86_event

The current is_x86_event has to go through the hybrid_pmus list to find
the matched pmu, then check if it's a X86 PMU and a X86 event. It's not
necessary.

The X86 PMU has a unique type ID on a non-hybrid machine, and a unique
capability type. They are good enough to do the check.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424134718.311934-5-kan.liang@linux.intel.com
---
 arch/x86/events/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b2762f2..92c3fb6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -762,15 +762,16 @@ void x86_pmu_enable_all(int added)
 
 int is_x86_event(struct perf_event *event)
 {
-	int i;
-
-	if (!is_hybrid())
-		return event->pmu == &pmu;
-
-	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (event->pmu == &x86_pmu.hybrid_pmu[i].pmu)
-			return true;
-	}
+	/*
+	 * For a non-hybrid platforms, the type of X86 pmu is
+	 * always PERF_TYPE_RAW.
+	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
+	 * is a unique capability for the X86 PMU.
+	 * Use them to detect a X86 event.
+	 */
+	if (event->pmu->type == PERF_TYPE_RAW ||
+	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
+		return true;
 
 	return false;
 }


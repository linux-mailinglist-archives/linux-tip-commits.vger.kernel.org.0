Return-Path: <linux-tip-commits+bounces-2909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFC9DFFF2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CFC280D12
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D365202F92;
	Mon,  2 Dec 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+SeVdn9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6J/hWBK1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A59200BB2;
	Mon,  2 Dec 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138062; cv=none; b=JWeWLx88WGFub4FU9ZguNIfrvS1M0Vbn/MAWyYFzJ46NdoX1EAczE1lfAwv3vlLBygaRLbgiy+jgX/8p5+9ExIsja4sRxrsR5p/f1/pNLNcCcAT8Zn0drchzoegf/8pdHsQcQmBNehfObx/nehGU6liBpk9Zd7N85NRMhFDDvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138062; c=relaxed/simple;
	bh=1vyJR8m3LgWP+CkooKVvrkyHDfdyyVK8V/RFX+HY+Q4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ARC+u50WTl9H3/2C8RoKmJ+vz5L1yxyGsOZzb8xak6JcOh2tWQcStwSXZhFFYhZTo99MNrcKkt5CrkDc8uN+uig7A/qwwKqqL81hyXQcsqbYOMlbEZyWkvBkXmni7ZrnOsWYRVSIhWad1Eotggcx9vyeUu1hdY3nz1C9TTGLWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+SeVdn9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6J/hWBK1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEQYUrupcXYnLvv232X8TLlJAH4/TQK4Z5oAKAdjznE=;
	b=m+SeVdn9Afcl43xAcz5HsE7lBiQRYPoBXHYUt03e/aqO8vK0qmtm18HkPmapP3GAH3C8JZ
	HlvwPlukGb6WGnVxdldzeEEozex801R5fnJKAVsK/pd2ZYnvHvF2TRVWYCjUF6u6NlvWfT
	pb28l7T/4CkSIZ7bhKdQz3IGAuy5quuE6a5o+W2wAKes6j6l1HETtMew44gqj/ncB7THT5
	rrApmof0Pi+qtzAj73fLXx/G4nA8CrVEdbXJfABvAYagioJ1nh0/YfWIICuHHHsRRjI/cG
	f3nhkKY3F68VwuxGphwq8r7BxBCaGKB87eKFKSkO2eOEIS7xTc4mXkPien862A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEQYUrupcXYnLvv232X8TLlJAH4/TQK4Z5oAKAdjznE=;
	b=6J/hWBK1mU662m2k9WbOTb25tiOnjm/k95DOM3LRmsPxONtjBd73sageUToD0rpLFewN3S
	fllW1mhzqM4FJODg==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-4-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-4-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805788.412.16876461711918804731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1d5e2f637a94a8ca8c8a1e292dd98ee80aa92815
Gitweb:        https://git.kernel.org/tip/1d5e2f637a94a8ca8c8a1e292dd98ee80aa92815
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:07:59 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:35 +01:00

perf/x86/rapl: Remove the cpu_to_rapl_pmu() function

Prepare for the addition of RAPL core energy counter support.
Post which, one CPU might be mapped to more than one rapl_pmu
(package/die one and a core one). So, remove the cpu_to_rapl_pmu()
function.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-4-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f70c49c..bf260f4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -158,19 +158,13 @@ static struct perf_msr *rapl_msrs;
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
 {
-	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					 topology_logical_die_id(cpu);
-}
-
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
-{
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-
 	/*
-	 * The unsigned check also catches the '-1' return value for non
-	 * existent mappings in the topology map.
+	 * Returns unsigned int, which converts the '-1' return value
+	 * (for non-existent mappings in topology map) to UINT_MAX, so
+	 * the error check in the caller is simplified.
 	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -350,6 +344,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
 	struct rapl_pmu *pmu;
+	unsigned int rapl_pmu_idx;
 
 	/* only look at RAPL events */
 	if (event->attr.type != rapl_pmus->pmu.type)
@@ -376,8 +371,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
+	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
+		return -EINVAL;
+
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
+	pmu = rapl_pmus->pmus[rapl_pmu_idx];
 	if (!pmu)
 		return -EINVAL;
 	event->pmu_private = pmu;


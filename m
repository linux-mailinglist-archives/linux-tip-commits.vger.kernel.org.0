Return-Path: <linux-tip-commits+bounces-1637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1966C92B88A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48D12822D8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B2158A09;
	Tue,  9 Jul 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tL9hj3tQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Txa1D+Yo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4315821A;
	Tue,  9 Jul 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525319; cv=none; b=KX0M0ovQzbv+gGpdJaiRS6/tuROiCv7KlY9a8ydDeQ6j6TiOzo2QjKUPCodJ9ZMZo76e9FotdVD0UzAIIBtiQcepYjPmkGwalhNX2DBADmkYL372CTwwunXcb2hwpkc5XUc6ViqLgWJGNm5oDaBLoSv6vK0g2kdb20EWC2MZssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525319; c=relaxed/simple;
	bh=7SYB1kdDUn3buUg2wZEG8/LJQdwEAVKy+zXhYxhDN48=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XGZxiv0lRC++9cKU912oCxBrSUSn4whQPq7/VhpOD121NwNSHrmxFAu+7jDalwMD0jU1uX3GCSra8oNNbOeLem7dD1D2SIP3UmIwV/8rsVwv6ZCgEARjj5O/r7Mmwqeu71wCtv9W++rYHutTcpEE+/6qMyJeD1LyQCc/iONRQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tL9hj3tQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Txa1D+Yo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIk0SFb4FtA05uKIiO3ilIbf+6k/czv9BAvhUTUZ730=;
	b=tL9hj3tQSeCJ/XTlwdBeJViZUe4bYoNSGSSBU84DNoq4p3si5TPmu2gYIcljs99f4JRika
	FD7mb3nyCCSP4W9m2gzYPIP2ZiSP1J5nB3HcwKiEtwMUAkRw6KemPPaa4EFs5iaRHD409+
	yHUte80BNJNI++4/VBxccu9pFo6etjBIz2/qII49xwWF2oeg8/WveV6MepVcoyDaCDPQgK
	3XuhzM3oiNBF5Gvv/isn5/GzbPJD8KyvVk13kIhWEak2mpJhjImi5PtgTOC32d3SSL1E7k
	+fjhWlQjRcj56wNmGVzai2GdXKBi4U49eVvbZSv++GuT3RZTFJHhTbGu+l4cRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIk0SFb4FtA05uKIiO3ilIbf+6k/czv9BAvhUTUZ730=;
	b=Txa1D+YocvruhTbMHHfzqInhLV80gWMFDC50PPjF4mspUAmmWsucyxDZuvOuuw8aWPZFtC
	hCa0e5AAAU9JZMDQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Hide Topdown metrics events if the
 feature is not enumerated
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240708193336.1192217-2-kan.liang@linux.intel.com>
References: <20240708193336.1192217-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531640.2215.2187640866774751729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     556a7c039a52c21da33eaae9269984a1ef59189b
Gitweb:        https://git.kernel.org/tip/556a7c039a52c21da33eaae9269984a1ef59189b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 08 Jul 2024 12:33:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:38 +02:00

perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated

The below error is observed on Ice Lake VM.

$ perf stat
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (slots).
/bin/dmesg | grep -i perf may provide additional information.

In a virtualization env, the Topdown metrics and the slots event haven't
been supported yet. The guest CPUID doesn't enumerate them. However, the
current kernel unconditionally exposes the slots event and the Topdown
metrics events to sysfs, which misleads the perf tool and triggers the
error.

Hide the perf-metrics topdown events and the slots event if the
perf-metrics feature is not enumerated.

The big core of a hybrid platform can also supports the perf-metrics
feature. Fix the hybrid platform as well.

Closes: https://lore.kernel.org/lkml/CAM9d7cj8z+ryyzUHR+P1Dcpot2jjW+Qcc4CPQpfafTXN=LEU0Q@mail.gmail.com/
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Link: https://lkml.kernel.org/r/20240708193336.1192217-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd8f2db..b613679 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5830,8 +5830,22 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
+static umode_t
+td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	/*
+	 * Hide the perf metrics topdown events
+	 * if the feature is not enumerated.
+	 */
+	if (x86_pmu.num_topdown_events)
+		return x86_pmu.intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
+	.is_visible = td_is_visible,
 };
 
 static struct attribute_group group_events_mem = {
@@ -6057,9 +6071,27 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
+static umode_t hybrid_td_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	if (!is_attr_for_this_pmu(kobj, attr))
+		return 0;
+
+
+	/* Only the big core supports perf metrics */
+	if (pmu->pmu_type == hybrid_big)
+		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group hybrid_group_events_td  = {
 	.name		= "events",
-	.is_visible	= hybrid_events_is_visible,
+	.is_visible	= hybrid_td_is_visible,
 };
 
 static struct attribute_group hybrid_group_events_mem = {


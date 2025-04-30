Return-Path: <linux-tip-commits+bounces-5146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C6AA4A80
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989E9188B930
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AB25A333;
	Wed, 30 Apr 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkoIKaNE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bhbj/9Z6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EA259C83;
	Wed, 30 Apr 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014336; cv=none; b=eADvT82Kq+WbESPeujFvkXEofAnw/Ci6FP104fpBkLBsigU/U98OpY2yHMrEVbqCYgwO3xXbOKaa0lH/dZ+N7v51hAtChiSwvqS+ykAvvw+81ZkLuB7zYBsJw7WoA1vSbyF+9aewFNJ2HTrH1oWbeJXWp1GS0osECY8/i0wNhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014336; c=relaxed/simple;
	bh=WwTcbUz7MxK6vH0vqjAvMSF5VUfR/DCgG9h7K6+2nkI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=giNl91mAhVURfGoWLgILrW+2U0YU6GnGxq5cHom2AQYZal/uVxbKwPgo5EoRpwLGPogtVtHonOR4z4/R8PEnTVLCzGfoHBVP/o25nIcvnX8VKAi4q154FQD+zxDz6mRKcM1yJtR/rRvLlg0u5fRzHbhysmo+siu8pgX3Rosfvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkoIKaNE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bhbj/9Z6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/bCM0FUpQXMpHS+XMY/+S3bsrRVQkc8+oj2OKP7GFs=;
	b=hkoIKaNEBTPtHgFnbe7MKQsM0jgQnn4CF4PbRmM8YJfNH8r5254bYrcCiKuM6A75qaUsoK
	EoeprKEO28kTqVTC0tNx/gLZqnuJ/9phyLzpMWQPgyAgkLCt0Aqcb4gJ4X7hlCa1hF5KvU
	k3BllQZvodkKr2wuZRORfjlhvQwji7Gtc7cb+gbF0nvqqz6GRzTF+WKBMBVyv+V3dfM8hY
	P3+Br1/saXfWqlN7HDxG2T/UZ9fv01LRDxh6x8RPGToHM2LtW5imBql1fIXlqv9hSgAoO/
	P0TWkfpMQNJXx08P8N8G9kcA3AuvNh7yJhBNjsaU+jQk6eq2oGVhQLxyCbKSUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/bCM0FUpQXMpHS+XMY/+S3bsrRVQkc8+oj2OKP7GFs=;
	b=Bhbj/9Z6uPFneJ1uOxtT8dQRbRE7eRO1PhpTgSiBqvyj+awKnuWnyFuhpapphMBUgwlJ6Y
	hifjq6LSWr0LabAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Fix counter backwards of
 non-precise events counters-snapshotting
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424134718.311934-6-kan.liang@linux.intel.com>
References: <20250424134718.311934-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601433215.22196.15691518087061204450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7da9960b59fb7e590eb8538c9428db55a4ea2d23
Gitweb:        https://git.kernel.org/tip/7da9960b59fb7e590eb8538c9428db55a4ea2d23
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Apr 2025 06:47:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:19 +02:00

perf/x86/intel/ds: Fix counter backwards of non-precise events counters-snapshotting

The counter backwards may be observed in the PMI handler when
counters-snapshotting some non-precise events in the freq mode.

For the non-precise events, it's possible the counters-snapshotting
records a positive value for an overflowed PEBS event. Then the HW
auto-reload mechanism reset the counter to 0 immediately. Because the
pebs_event_reset is cleared in the freq mode, which doesn't set the
PERF_X86_EVENT_AUTO_RELOAD.
In the PMI handler, 0 will be read rather than the positive value
recorded in the counters-snapshotting record.

The counters-snapshotting case has to be specially handled. Since the
event value has been updated when processing the counters-snapshotting
record, only needs to set the new period for the counter via
x86_pmu_set_period().

Fixes: e02e9b0374c3 ("perf/x86/intel: Support PEBS counters snapshotting")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424134718.311934-6-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 18c3ab5..9b20acc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2379,8 +2379,25 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 			 */
 			intel_pmu_save_and_restart_reload(event, count);
 		}
-	} else
-		intel_pmu_save_and_restart(event);
+	} else {
+		/*
+		 * For a non-precise event, it's possible the
+		 * counters-snapshotting records a positive value for the
+		 * overflowed event. Then the HW auto-reload mechanism
+		 * reset the counter to 0 immediately, because the
+		 * pebs_event_reset is cleared if the PERF_X86_EVENT_AUTO_RELOAD
+		 * is not set. The counter backwards may be observed in a
+		 * PMI handler.
+		 *
+		 * Since the event value has been updated when processing the
+		 * counters-snapshotting record, only needs to set the new
+		 * period for the counter.
+		 */
+		if (is_pebs_counter_event_group(event))
+			static_call(x86_pmu_set_period)(event);
+		else
+			intel_pmu_save_and_restart(event);
+	}
 }
 
 static __always_inline void


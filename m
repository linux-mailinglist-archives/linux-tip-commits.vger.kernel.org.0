Return-Path: <linux-tip-commits+bounces-3865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E932A4D732
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F763AC57F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33B1FECD3;
	Tue,  4 Mar 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1EDslUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIkoIqw/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0901FCFE6;
	Tue,  4 Mar 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078624; cv=none; b=PigVuNaBS7A8IFzAM/mPR/a1nUWEg2uym+9AKCGepVge6ti8o7BbIqzCkzVTAxHlJQhvXhLG71w9DDaVv4nFe4+Gg6w+HnE5aeVm6f9JLpgrtCS1aX2LlH2TlQTngVn/dbx9DwJ4JHAgXKCSo92r/qxZLR2eWdsHDIGCl4BScvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078624; c=relaxed/simple;
	bh=hKQTFZRFDN/O5T2zAGzpJrdHT2jYkHJvGFuIvzU+i6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=usnsY3UJ4AVKZyu1pryHt+BxO+A5QF5QkCxr34XTB4etBlN+6seIxcbR8FARr1yNGrct0bREy6iV1GW1qYHguK84dlEtGEGgqrwqDygC/EOP6CUY4YU3//16OkceDN8tJx9EQM+BKv1gbjA35doFbwvXbOLPbd1kN4wuVN3Y5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1EDslUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIkoIqw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3a+oAlC9i//khl/aFyDO/bKBt2rW1zbJsXBJ3mabvY=;
	b=N1EDslUaMix6nwF9LEKES12tyxVTzq9BWYg3DO6SHlo/H8eLg8cm1y0HiQilYQH2/yUW+d
	MfwX5SD59Tj/wwFX2Pe+vYzZpbod36QMceg2YAPlaH7KbZb0mvqO+oyfMuyFtx81gug5Wg
	fvBOyckY4Nwz4EHnBiAV4/T1zrMGC3O9S7hydDAaeI4+5E4fSykTM+lHLZfBHXhRGloO/w
	ftHcD1n+Gk2+HqqsAbi2Zz78iDOqt8gnDORg2Ty8JgGtCC4hB/y65rmmOmxadzpBjOrm2X
	L62CdAypF4ceTjn2u17K4TkdhMqDQIVD3+j30v50X8w1hgMg6W1cdgW7XHpS5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3a+oAlC9i//khl/aFyDO/bKBt2rW1zbJsXBJ3mabvY=;
	b=PIkoIqw/H3CH96dOxndQRXfe4+hlKPH43s3gb+88cpvTyzv2z4iF0VjGncDc4oHxjDdo2b
	4WpPmS4iSD9Ul7CA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Robustify perf_event_free_bpf_prog()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.978956692@infradead.org>
References: <20241104135518.978956692@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862138.14745.820346394726926625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c5b96789575b670b1e776071bb243e0ed3d3abaa
Gitweb:        https://git.kernel.org/tip/c5b96789575b670b1e776071bb243e0ed3d3abaa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:59 +01:00

perf/bpf: Robustify perf_event_free_bpf_prog()

Ensure perf_event_free_bpf_prog() is safe to call a second time;
notably without making any references to event->pmu when there is no
prog left.

Note: perf_event_detach_bpf_prog() might leave a stale event->prog

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241104135518.978956692@infradead.org
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 525c64e..ab4e497 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10905,6 +10905,9 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
+	if (!event->prog)
+		return;
+
 	if (!perf_event_is_tracing(event)) {
 		perf_event_free_bpf_handler(event);
 		return;


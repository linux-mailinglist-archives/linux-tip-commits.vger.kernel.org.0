Return-Path: <linux-tip-commits+bounces-4759-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE9A8156E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BFA8A2669
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AE4254867;
	Tue,  8 Apr 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFzLKjXZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaaBt46p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41D253B42;
	Tue,  8 Apr 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139109; cv=none; b=uvLCwqY+zwuM6Vg9qVSuGeanCc2UQRyVb9q2muP/NJ77Lv+H/c6NtBBW04WSROtgHtMQiIillr+RKpkWS2JDWzr9vbEDRmTxMyn9wAETQz61oR6iSsBn80pIuF9OFtazJ/hN8Csvh2vENqwluSCjvCyaRJSlc2IxrcorBp+jaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139109; c=relaxed/simple;
	bh=oPgmhWsz4TQavAmb2Lh3JnNdsz4SJE0zEGPpKpgB1Nk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HwJLA5BBNu24pzpkrYiqLvelDdtN94GMsDcBKDvyzrZkAksR1QUHOewjXLNPNn1rjupsDCA3mA7dw6UrgIaHLuuIpFBSWLNd18COWCo1koSF7biriEF9dVSfJ+lnXjJDMZh/sQdDef+8gbufLdxK0d2yGAq01yH+tyEJDypkKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFzLKjXZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaaBt46p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=432bzppfCCDS99zJysHZrpLMYDROQidyikzV2QBabN0=;
	b=NFzLKjXZWeqRTdPAWH8eLzwU03Huz5+JUc5xwue2syuIYzWDZSoP8cfml7T3UQL98s2RqK
	CDVz5yes6bIZAjB1Dct+bvIyYYbfl+O6nb5fIfRgJ35wGMBnMdeZEFEwz8ZfZ++bWck8MX
	wuPSezmpkMpgKxFHwxSczUlbq2WAEs8FmB1N64+kwmW6tWfFcRjkSexuWpCOWDoLsn6QeD
	UqD8wNIh5YL5u4sEz9x5ffJRRvub0vftf6NfTMZqx/cwEEn4oxcTShWnGL2u9QEtWjJpFd
	kSXLJLlb/ptKkIA6vRfwO6SBf47ZZ37ndXEgG4C6WDktIMzX7jaVw2jckR+iVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=432bzppfCCDS99zJysHZrpLMYDROQidyikzV2QBabN0=;
	b=yaaBt46pkoM+Jd5c278Ow8el4wV4LlfA9GCbaaJ3pvd4nmLRqS74amhYkQKi18P6T8JGDN
	5aYMkU8zNKtWgDDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Ensure bpf_perf_link path is properly serialized
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193305.486326750@infradead.org>
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910546.31282.13108128229694254483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7ed9138a72829d2035ecbd8dbd35b1bc3c137c40
Gitweb:        https://git.kernel.org/tip/7ed9138a72829d2035ecbd8dbd35b1bc3c137c40
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jan 2025 10:54:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:46 +02:00

perf: Ensure bpf_perf_link path is properly serialized

Ravi reported that the bpf_perf_link_attach() usage of
perf_event_set_bpf_prog() is not serialized by ctx->mutex, unlike the
PERF_EVENT_IOC_SET_BPF case.

Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193305.486326750@infradead.org
---
 kernel/events/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e93c195..a85d63b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6239,6 +6239,9 @@ static int perf_event_set_output(struct perf_event *event,
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -6301,7 +6304,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
-		err = perf_event_set_bpf_prog(event, prog, 0);
+		err = __perf_event_set_bpf_prog(event, prog, 0);
 		if (err) {
 			bpf_prog_put(prog);
 			return err;
@@ -11069,8 +11072,9 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
-			    u64 bpf_cookie)
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
 {
 	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
 
@@ -11108,6 +11112,20 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 	return perf_event_attach_bpf_prog(event, prog, bpf_cookie);
 }
 
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
+			    u64 bpf_cookie)
+{
+	struct perf_event_context *ctx;
+	int ret;
+
+	ctx = perf_event_ctx_lock(event);
+	ret = __perf_event_set_bpf_prog(event, prog, bpf_cookie);
+	perf_event_ctx_unlock(event, ctx);
+
+	return ret;
+}
+
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
 	if (!event->prog)
@@ -11130,7 +11148,15 @@ static void perf_event_free_filter(struct perf_event *event)
 {
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
+{
+	return -ENOENT;
+}
+
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
 			    u64 bpf_cookie)
 {
 	return -ENOENT;


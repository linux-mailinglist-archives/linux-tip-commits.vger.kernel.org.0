Return-Path: <linux-tip-commits+bounces-3310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E635BA259C3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788271883506
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFB20550E;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+sxU3wy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxqIrm6k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F656204F7F;
	Mon,  3 Feb 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=C+b6kuEvqOgViE5tAlW7Ez4MfPVTqIFxznR201kb2H4XWjscFztKayQniDa+j9JDZ2rkDzkr/hkj43w7wmi75q6d1dp8UY6A5TwFQZ9BRj5qNhW+EAACjX4HBeYY9v1z6jYR1erJ1I5XiRaPGBMnFI6R2sxbJntaXuRBB0GMWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=+rtK6Akxh+iKEsdsj9Xs2Lj/2o/qrKVfm/m8DOsLD4I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qHEGqjaya5b4a8VaQM+z4Nb6MmsR9xXTT5vvts7NGp4bwB3vOEkUqc7suKyQFaioH66RMwARxv3SaUtsY1PYkOROJETK/BpE7GbJewJjaJ0aCwMxpS1qLFPnC1KgmC7lriQdH8eqAURGC6wpAo8bYiExaimAU3vLF9alvw54hxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+sxU3wy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxqIrm6k; arc=none smtp.client-ip=193.142.43.55
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
	bh=z4OhxgcBewSMZGBTXQL2wTQM6c1bOW1leMuhjSREorI=;
	b=b+sxU3wyey3go01Y6qAuflaNRUYtAzO+PJj54/PmOrYSpTo2t4WpRUoptKRPmkpXxyCmnH
	TyXL0nhdf+XKearHtgewEcJFwZo4G8AMiWHhVDu6GflKs1V7gfjTjhiA4201jK1Bz6KbYt
	/yQAvVlaORr4faaP9ZpC9L0RwzkPPUnLYNVDOB1KFJUwc635YbJm+0BOqabu6Ky/MoFlTs
	xV1PtycRxPDKDhdzWQgLJPbZqUvBcu/9hP0Zy6tgHkbElOPd2fbEz0JWO2W6kUMTIGySSr
	bEzPVRFC4CSTYb6uW2HodEwPSWAFtximvUfDKD8+ibl65phD0OIjCvFEbhwC7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4OhxgcBewSMZGBTXQL2wTQM6c1bOW1leMuhjSREorI=;
	b=yxqIrm6kSv8uVApmHaAINurqURdsb4cWvUIp5bGMVWZ0+A6IONRru4vRbya7s3bCwRXpHH
	nXEpG1qVrs2CRyBA==
From: "tip-bot2 for Liao Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Remove redundant spinlock in uprobe_deny_signal()
Cc: Liao Chang <liaochang1@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250124093826.2123675-2-liaochang1@huawei.com>
References: <20250124093826.2123675-2-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689756.10177.14621017602283942308.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eae8a56ae0c74c1cf2f92a6709d215a9f329f60c
Gitweb:        https://git.kernel.org/tip/eae8a56ae0c74c1cf2f92a6709d215a9f329f60c
Author:        Liao Chang <liaochang1@huawei.com>
AuthorDate:    Fri, 24 Jan 2025 09:38:25 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:06 +01:00

uprobes: Remove redundant spinlock in uprobe_deny_signal()

Since clearing a bit in thread_info is an atomic operation, the spinlock
is redundant and can be removed, reducing lock contention is good for
performance.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250124093826.2123675-2-liaochang1@huawei.com
---
 kernel/events/uprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797c..33bd608 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2302,9 +2302,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
-		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
-		spin_unlock_irq(&t->sighand->siglock);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;


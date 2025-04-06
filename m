Return-Path: <linux-tip-commits+bounces-4712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB6A7CFC1
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C4188BCD2
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3D17A2F8;
	Sun,  6 Apr 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcp+bOoR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uhtDH5k9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B672E62C;
	Sun,  6 Apr 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964946; cv=none; b=EZiaFQedTNWqpk4EvDDfInWrHMCW/b73DBlHzJDgyRLIWMZQBDmFJAKlWYfWJSiN3BJoIYfIxJtOEZVLhquai/EAKw84d2eDCBRLLUvvQaBuU3OdTQBztSzvGU8bsacPv5gdxiPDYcii0ZRvnRYloSPf3lmVgU2FF5Xuq72C670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964946; c=relaxed/simple;
	bh=z7IyGIugvU25wFZxIBRUUQmzKyoNvqA3uTExL14tq/Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PVebdhILyKzP0RK6cZFFnnlOYt24gMoFRI5qBk/rM0fGfLuxDTlklaCPyosBJajnmC3W4Pdyg7x/4ZFhegAg0oN+WkSDsX3r1f7MpGLWOmJMWrxWAUNX4OMGNBpF1j1PhLQx6Y2QELXq3SmhpziGJ0rtsi23XjkOh0j8B6k1l5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcp+bOoR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uhtDH5k9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743964943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmj+zo6C3P/pSg/s1RkYC7RWN47ojlSz5x1oHCbh38s=;
	b=kcp+bOoRh1/W1Eg1W3Qf/Nv2mI0opUBOrg7J7S3/VjqSnK6kEvxQdzjRz8IaWMe9DhFnnR
	tyZg3OEiTtoQixTE8gZp2r2uLvHZSrx6jdANDMLt9ZiPjvyZ6vxedTAuD41kruyZ9abMcE
	GOhDT2oJbtewaeFvH3prZc3B+vPd6zS7u6b+N+9uOketNzj06/peW7D3U5OoBcxsjbf1aj
	643D7qgR02V+NTHJIhsmTLvgXmQIWMEXsrb3GnwfiZERPqrG+byhVT85nvaraVxEairy50
	z4orXIckL7ild6mKIHKLQSiP+RmsjmsA3ld1ZTxfyBQnIC1c3lWXojnYhxPZOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743964943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmj+zo6C3P/pSg/s1RkYC7RWN47ojlSz5x1oHCbh38s=;
	b=uhtDH5k9RSF+A2+oeAMD0xlNQrUBl94qDXkqNWQdnRvlDLrs8mcYtGOdAzFASsgjDsAUmu
	eX/LCRyUzFfjxGBw==
From: "tip-bot2 for Gabriel Shahrouzi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix WARN_ON(!ctx) in __free_event() for
 partial init
Cc: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
 Gabriel Shahrouzi <gshahrouzi@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250405203036.582721-1-gshahrouzi@gmail.com>
References: <20250405203036.582721-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396494203.31282.1919457781258540750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0ba3a4ab76fd3367b9cb680cad70182c896c795c
Gitweb:        https://git.kernel.org/tip/0ba3a4ab76fd3367b9cb680cad70182c896c795c
Author:        Gabriel Shahrouzi <gshahrouzi@gmail.com>
AuthorDate:    Sat, 05 Apr 2025 16:30:36 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:30:28 +02:00

perf/core: Fix WARN_ON(!ctx) in __free_event() for partial init

Move the get_ctx(child_ctx) call and the child_event->ctx assignment to
occur immediately after the child event is allocated. Ensure that
child_event->ctx is non-NULL before any subsequent error path within
inherit_event calls free_event(), satisfying the assumptions of the
cleanup code.

Details:

There's no clear Fixes tag, because this bug is a side-effect of
multiple interacting commits over time (up to 15 years old), not
a single regression.

The code initially incremented refcount then assigned context
immediately after the child_event was created. Later, an early
validity check for child_event was added before the
refcount/assignment. Even later, a WARN_ON_ONCE() cleanup check was
added, assuming event->ctx is valid if the pmu_ctx is valid.
The problem is that the WARN_ON_ONCE() could trigger after the initial
check passed but before child_event->ctx was assigned, violating its
precondition. The solution is to assign child_event->ctx right after
its initial validation. This ensures the context exists for any
subsequent checks or cleanup routines, resolving the WARN_ON_ONCE().

To resolve it, defer the refcount update and child_event->ctx assignment
directly after child_event->pmu_ctx is set but before checking if the
parent event is orphaned. The cleanup routine depends on
event->pmu_ctx being non-NULL before it verifies event->ctx is
non-NULL. This also maintains the author's original intent of passing
in child_ctx to find_get_pmu_context before its refcount/assignment.

[ mingo: Expanded the changelog from another email by Gabriel Shahrouzi. ]

Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/r/20250405203036.582721-1-gshahrouzi@gmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff3aa851d46ab82953a3
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 128db74..9af9726 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14016,6 +14016,9 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
+	get_ctx(child_ctx);
+	child_event->ctx = child_ctx;
+
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
@@ -14037,8 +14040,6 @@ inherit_event(struct perf_event *parent_event,
 		return NULL;
 	}
 
-	get_ctx(child_ctx);
-
 	/*
 	 * Make the child state follow the state of the parent event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
@@ -14059,7 +14060,6 @@ inherit_event(struct perf_event *parent_event,
 		local64_set(&hwc->period_left, sample_period);
 	}
 
-	child_event->ctx = child_ctx;
 	child_event->overflow_handler = parent_event->overflow_handler;
 	child_event->overflow_handler_context
 		= parent_event->overflow_handler_context;


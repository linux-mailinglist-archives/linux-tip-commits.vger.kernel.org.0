Return-Path: <linux-tip-commits+bounces-1806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B493F2E3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415111C21264
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D3146A64;
	Mon, 29 Jul 2024 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huWD821q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKFZLKQH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1E145FE3;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249253; cv=none; b=ZAYK6wbKhO3NwlvUlJtH2oRiYDRFHcPYkpZrDm4oNzr/D1iSDC3zQILCOoIykKKZ41iySPCoJslt2ywhCaNsYF5opMADoFckhl2E/wn2jfeacXMghlyJxBiZ4jc1yWR34f+fWu3uPO6wvDhWA7xNQlgkwOlRmjcaceSgkwxeT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249253; c=relaxed/simple;
	bh=8ROmRqdLmTu0bsx2CkZ944AjcaaNOcKMss9XTY3GlJ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IY+JhNm78bNbjnjYTUgU2GXdYNNbKfkX0FDks0bRxN4LSM/RfCnHsTZk7mnq/mEZ6/p4qOTCAg6hZ/2HReIwumJYe20FsW4eb+63htAuMrwpvEkq21vBHEA9/12mo6u5Qivus9tugF5ZjDnio7kiPUYyAPN7HxNw8bYjaO63Ya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=huWD821q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKFZLKQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9ZGAI8gFWC2hk5fGSYmZaHaE3vzuw5zMl/V5EVkreY=;
	b=huWD821qtyma6IF7NGP03j5WkLmLQb8ImkMQSNhh9LfvMJFzkQ6fd+vlau0bR/AwEOLbLz
	bk+sY6C77mqMMgWuUpI+qP1jkD4SuR4fChuB0Kb3zozelBy7rXlT1LzrcC3EL8mRfQRW8d
	yYYU55VtWbT6tq6lhZDUmP/3r6MFMUZtNSmz9MU0zyxUESxLyDmXohqO0Z7FDdEAdQvjA2
	JK6hgHxePaA+jHauHRprR4EFUA0lHK75zmKtfLDARwv0q8SnG5yy68ENMUvI64VFSVV5Xj
	7whsBuQYlVGZEFTa9hHXtngXrb29JYUe9YR1XaXZPaJpLAGUz8CvCs2lH6/J5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9ZGAI8gFWC2hk5fGSYmZaHaE3vzuw5zMl/V5EVkreY=;
	b=LKFZLKQHGm3QeURZiQPTJ7tXFKn5rMwDN7p5bh2sipInWSC738McBz/2DH+FLSXk29/Ezf
	BnjFBdu9THPJ1oDw==
From: "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smt: Fix unbalance sched_smt_present dec/inc
Cc: stable@kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703031610.587047-3-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-3-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924949.2215.7548335269199359250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e22f910a26cc2a3ac9c66b8e935ef2a7dd881117
Gitweb:        https://git.kernel.org/tip/e22f910a26cc2a3ac9c66b8e935ef2a7dd881117
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 03 Jul 2024 11:16:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:32 +02:00

sched/smt: Fix unbalance sched_smt_present dec/inc

I got the following warn report while doing stress test:

jump label: negative count!
WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_dec+0x9d/0xb0
Call Trace:
 <TASK>
 __static_key_slow_dec_cpuslocked+0x16/0x70
 sched_cpu_deactivate+0x26e/0x2a0
 cpuhp_invoke_callback+0x3ad/0x10d0
 cpuhp_thread_fun+0x3f5/0x680
 smpboot_thread_fn+0x56d/0x8d0
 kthread+0x309/0x400
 ret_from_fork+0x41/0x70
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Because when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),
the cpu offline failed, but sched_smt_present is decremented before
calling sched_cpu_deactivate(), it leads to unbalanced dec/inc, so
fix it by incrementing sched_smt_present in the error path.

Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology")
Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20240703031610.587047-3-yangyingliang@huaweicloud.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index acc04ed..949473e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8009,6 +8009,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	sched_update_numa(cpu, false);
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		sched_smt_present_inc(cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);


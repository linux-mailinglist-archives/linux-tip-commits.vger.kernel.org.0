Return-Path: <linux-tip-commits+bounces-2986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F209E6A7E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9651028C0CC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D61F4276;
	Fri,  6 Dec 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zs3WQzOq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7TiEIVj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BD1F7590;
	Fri,  6 Dec 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477916; cv=none; b=qSCKa3+8a+5eEiKCDO+EOyZTk5xlbL53JXOTITX5Nb/Ufuh+hNc/dcxJAfsWVe3GG852qYGkcN8aqjPJxkjkDQ19w4pw6Cp4maiMcSJwWgRgtb33Y3aTJIkJ0TWBIoRunU8PIjJek6BZ2NKsjVnKNRCw53jsfTyBGgkfSngZoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477916; c=relaxed/simple;
	bh=/CYJRW/a/u+ypqPzCdJD8GrIM/Rn0QYT7+X7espYaSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZD4l3LuIXcqCRUKy2HSQBcGTqlf2BBwip4j+OJT3wYGV5Sonb1X3x5dTY90i4L4GPjEgEITdkc0WYoPNvwg28b0BZiksDJed+nf35S6CsZBW3RhBsMkJ9hh1M3Wuuym0J+06L3ihoHgx/+AdUdvyOM9J7Xh+1j0BwZB/cORuz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zs3WQzOq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7TiEIVj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 09:38:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733477913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkKeYjt5oAoVtWon/vL7ZPcGk0qtpFUo1yr+ZB/iMCg=;
	b=Zs3WQzOqQjURM63U1IckJOafscTvk4X85a1hBv4UWJgp1SunjFZ1x3nggQGGpXWjGYEHZT
	F/uOtiPWCLwAVVeXZ11GLVU/JZAEVQuhDQ8EmE6tRSmPSfugkF2+T/yvPZ9dHvN7et7sMu
	NY3AqpbSic+0+fI4IzOF7ZW6QzPHH4OlJHzCT2hdjM1Dlh844t/YyagZtaMLCdohpVN1qk
	rxkLGqc2mg17oi8AL4EciBJlXuBs7OctJDJcKNjBKKp2xgMLygMyxQ+5cfn8vX5v4+g7M0
	vzuQrwLQTpHtimtdPGFLgWvd1u0RbHHs9epmD4RU95nmICUznj5NpMWwJ4VUpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733477913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkKeYjt5oAoVtWon/vL7ZPcGk0qtpFUo1yr+ZB/iMCg=;
	b=J7TiEIVjT/PtHoJwuVqd7muiXShkIfefyovu+OEDwq3gXL4bO0Wyd2gSYWe9cyws0c+Uow
	DFAbu9c1KyBcdqBg==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Ensure return_instance is detached from the
 list before freeing
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206002417.3295533-4-andrii@kernel.org>
References: <20241206002417.3295533-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173347791234.412.5705246973165227068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     681f5970dc69bd2243a991a06c98016f9d830a77
Gitweb:        https://git.kernel.org/tip/681f5970dc69bd2243a991a06c98016f9d830a77
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:16 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 09:52:01 +01:00

uprobes: Ensure return_instance is detached from the list before freeing

Ensure that by the time we call free_ret_instance() to clean up an
instance of struct return_instance it isn't reachable from
utask->return_instances anymore.

free_ret_instance() is called in a few different situations, all but one
of which already are fine w.r.t. return_instance visibility:

  - uprobe_free_utask() guarantees that ri_timer() won't be called
    (through timer_delete_sync() call), and so there is no need to
    unlink anything, because entire utask is being freed;
  - uprobe_handle_trampoline() is already unlinking to-be-freed
    return_instance with rcu_assign_pointer() before calling
    free_ret_instance().

Only cleanup_return_instances() violates this property, which so far is
not causing problems due to RCU-delayed freeing of return_instance,
which we'll change in the next patch. So make sure we unlink
return_instance before passing it into free_ret_instance(), as otherwise
reuse will be unsafe.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20241206002417.3295533-4-andrii@kernel.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cca1fe4..2345aeb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2116,12 +2116,12 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
 		ri_next = ri->next;
+		rcu_assign_pointer(utask->return_instances, ri_next);
 		utask->depth--;
 
 		free_ret_instance(ri, true /* cleanup_hprobe */);
 		ri = ri_next;
 	}
-	rcu_assign_pointer(utask->return_instances, ri);
 }
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,


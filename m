Return-Path: <linux-tip-commits+bounces-3198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D09A08A88
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Jan 2025 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD5F166C28
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Jan 2025 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2045220767A;
	Fri, 10 Jan 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvWBw+8l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tozW4FIm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E217B500;
	Fri, 10 Jan 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498449; cv=none; b=F0rSXnuwZLaHhwnmlHrG9EkZWONeLSqd3xGWIjANz3xUxbraJ9cIAZ/3i0K1cQvtlHXOZrTL8M/PdWLnZ+3hN3bHqa/ASqmy/aIgGpLFEhx7tuoheZ4u7+P4xvXXC1eR6jq19V6bTMXE/TC3LuVjNCpJv6AG1KNZpC8mdDRuGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498449; c=relaxed/simple;
	bh=F02pUMuK10RAx99xx/5roW1APeQDn/lBMSJwVjyYDLs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pp+B06NVKMBMrA1eR1gJEU2FFXJj4ZDhye/yz+sXXhcmlTM03KiDUuDBFz7278k7wRVJLptKXjHJ5JMuhjK17rDSZmXMyML/I7HUMioCVUX+IbW5oJrvYc9bEFHkcPGXEmMuS9I9QgRHftVWUbdfQVIhwx8o9AAvW0JhiBv8Quo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvWBw+8l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tozW4FIm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 Jan 2025 08:40:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736498444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b8S7s/5OG8dMbmydGLx3HQt6LS7fW/OfNUYKnsKI5Q=;
	b=vvWBw+8lHrJAIEUnyclvXYAaBwOdz6HeYcFj0GszKCfdCaQjCyiSiTtX1LJPBEuYw/Pfs1
	XmkKQ/N3hZVroCpkDrmPKIxJj2g0zLfZSNCei8Ne/Apx+x3322z9300YelhAhCzRIvxaSN
	rOUeI1kgXQOGKoPewrKQOB20jTFe0fvVG4XwdHSZpkEzlz2vsqGYBrfYwA/FRguQmOssWe
	8zL1cJdt/wOTPZCezuVft9lWd9eCwcJzsnZwdwOBSJREUYRP22CEbQwVgj+UwfHXKarJlX
	kHVWVxB7cABc5ywlc/P6NEoRjF+Wq3clSIMgBsHJ0blhUi2O582NaC+Y8Bt8gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736498444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b8S7s/5OG8dMbmydGLx3HQt6LS7fW/OfNUYKnsKI5Q=;
	b=tozW4FImtd+DyUPDhTPn0cvzeYpEW3ZnGptToW/NA9ksgXzXJIZhgTCWJqhaAqfgnPMMOo
	X9f863zTNeLFl5DA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Fix race in uprobe_free_utask
Cc: Max Makarov <maxpain@linux.com>, Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250109141440.2692173-1-jolsa@kernel.org>
References: <20250109141440.2692173-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173649843867.399.2703146797130848072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b583ef82b671c9a752fbe3e95bd4c1c51eab764d
Gitweb:        https://git.kernel.org/tip/b583ef82b671c9a752fbe3e95bd4c1c51eab764d
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 09 Jan 2025 15:14:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jan 2025 09:28:01 +01:00

uprobes: Fix race in uprobe_free_utask

Max Makarov reported kernel panic [1] in perf user callchain code.

The reason for that is the race between uprobe_free_utask and bpf
profiler code doing the perf user stack unwind and is triggered
within uprobe_free_utask function:
  - after current->utask is freed and
  - before current->utask is set to NULL

 general protection fault, probably for non-canonical address 0x9e759c37ee555c76: 0000 [#1] SMP PTI
 RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
 ...
  ? die_addr+0x36/0x90
  ? exc_general_protection+0x217/0x420
  ? asm_exc_general_protection+0x26/0x30
  ? is_uprobe_at_func_entry+0x28/0x80
  perf_callchain_user+0x20a/0x360
  get_perf_callchain+0x147/0x1d0
  bpf_get_stackid+0x60/0x90
  bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
  ? __smp_call_single_queue+0xad/0x120
  bpf_overflow_handler+0x75/0x110
  ...
  asm_sysvec_apic_timer_interrupt+0x1a/0x20
 RIP: 0010:__kmem_cache_free+0x1cb/0x350
 ...
  ? uprobe_free_utask+0x62/0x80
  ? acct_collect+0x4c/0x220
  uprobe_free_utask+0x62/0x80
  mm_release+0x12/0xb0
  do_exit+0x26b/0xaa0
  __x64_sys_exit+0x1b/0x20
  do_syscall_64+0x5a/0x80

It can be easily reproduced by running following commands in
separate terminals:

  # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }' -c ls; done
  # bpftrace -e 'profile:hz:100000 { @[ustack()] = count(); }'

Fixing this by making sure current->utask pointer is set to NULL
before we start to release the utask object.

[1] https://github.com/grafana/pyroscope/issues/3673

Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")
Reported-by: Max Makarov <maxpain@linux.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250109141440.2692173-1-jolsa@kernel.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fa04b14..5d71ef8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1915,6 +1915,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
 
 	timer_delete_sync(&utask->ri_timer);
@@ -1924,7 +1925,6 @@ void uprobe_free_utask(struct task_struct *t)
 		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
 
 	kfree(utask);
-	t->utask = NULL;
 }
 
 #define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */


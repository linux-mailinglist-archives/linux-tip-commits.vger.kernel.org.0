Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7373A28B407
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgJLLp0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 07:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbgJLLpZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 07:45:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9EC0613CE;
        Mon, 12 Oct 2020 04:45:25 -0700 (PDT)
Date:   Mon, 12 Oct 2020 11:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602503123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/ZSaZR0YJBI2cwJ0nGB8AuKWq/v+FHNtXdosmWZABk=;
        b=SJgWmIzkECNoLyx/TlivZajvnT1AojfnaQGQYJXoBxKQs4WWewHyZ2WvhLrmXbBzX/iY/g
        o5ioiwKwy0t+rOyF5roXdcBi6WpkD8uToRtOawxbc7ZDWxllocsF+cn3XTUBUv76s4egg+
        +H3Y405BDgYzJv1rvbedZ+WzJyHQb1XxZHLb3lm5Gya7FQ7ugzrMEmY0LmAFpi3W0Vln0Q
        5BiLE3aQW8QzlUYSgb2oQxfOHD7kAUxc979D8G28FCjs65NcIgIolKkW90QfbN4ntOWnTa
        iqtBX7vuYo4bfHb2LYZLZs5SiA8wVFt9UA/k0mTwcuAta0JhvDNpLHDffARjTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602503123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/ZSaZR0YJBI2cwJ0nGB8AuKWq/v+FHNtXdosmWZABk=;
        b=A08Uinidc+sTgUewhkCtx04xqPUKrTM+CL3ZJyzYuwzBG1pWMysOfmTrxm+ld7tYTdS+7T
        cYGvMBhoJJOj1BAA==
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix race in the perf_mmap_close() function
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Namhyung Kim <namhyung@kernel.org>,
        Wade Mealing <wmealing@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200916115311.GE2301783@krava>
References: <20200916115311.GE2301783@krava>
MIME-Version: 1.0
Message-ID: <160250312175.7002.16224226628192751806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f91072ed1b7283b13ca57fcfbece5a3b92726143
Gitweb:        https://git.kernel.org/tip/f91072ed1b7283b13ca57fcfbece5a3b92726143
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Wed, 16 Sep 2020 13:53:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 12 Oct 2020 13:24:26 +02:00

perf/core: Fix race in the perf_mmap_close() function

There's a possible race in perf_mmap_close() when checking ring buffer's
mmap_count refcount value. The problem is that the mmap_count check is
not atomic because we call atomic_dec() and atomic_read() separately.

  perf_mmap_close:
  ...
   atomic_dec(&rb->mmap_count);
   ...
   if (atomic_read(&rb->mmap_count))
      goto out_put;

   <ring buffer detach>
   free_uid

out_put:
  ring_buffer_put(rb); /* could be last */

The race can happen when we have two (or more) events sharing same ring
buffer and they go through atomic_dec() and then they both see 0 as refcount
value later in atomic_read(). Then both will go on and execute code which
is meant to be run just once.

The code that detaches ring buffer is probably fine to be executed more
than once, but the problem is in calling free_uid(), which will later on
demonstrate in related crashes and refcount warnings, like:

  refcount_t: addition on 0; use-after-free.
  ...
  RIP: 0010:refcount_warn_saturate+0x6d/0xf
  ...
  Call Trace:
  prepare_creds+0x190/0x1e0
  copy_creds+0x35/0x172
  copy_process+0x471/0x1a80
  _do_fork+0x83/0x3a0
  __do_sys_wait4+0x83/0x90
  __do_sys_clone+0x85/0xa0
  do_syscall_64+0x5b/0x1e0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Using atomic decrease and check instead of separated calls.

Tested-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Wade Mealing <wmealing@redhat.com>
Fixes: 9bb5d40cd93c ("perf: Fix mmap() accounting hole");
Link: https://lore.kernel.org/r/20200916115311.GE2301783@krava
---
 kernel/events/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 45edb85..fb662eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5895,11 +5895,11 @@ static void perf_pmu_output_stop(struct perf_event *event);
 static void perf_mmap_close(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
-
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
 	int mmap_locked = rb->mmap_locked;
 	unsigned long size = perf_data_size(rb);
+	bool detach_rest = false;
 
 	if (event->pmu->event_unmapped)
 		event->pmu->event_unmapped(event, vma->vm_mm);
@@ -5930,7 +5930,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&event->mmap_mutex);
 	}
 
-	atomic_dec(&rb->mmap_count);
+	if (atomic_dec_and_test(&rb->mmap_count))
+		detach_rest = true;
 
 	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
 		goto out_put;
@@ -5939,7 +5940,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mutex_unlock(&event->mmap_mutex);
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (atomic_read(&rb->mmap_count))
+	if (!detach_rest)
 		goto out_put;
 
 	/*

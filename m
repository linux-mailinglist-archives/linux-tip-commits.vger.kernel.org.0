Return-Path: <linux-tip-commits+bounces-3768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3186A4BC70
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8567C3AC6F1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9361F2BA9;
	Mon,  3 Mar 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqF/cnW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qir/20Ds"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885991F0E33;
	Mon,  3 Mar 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997954; cv=none; b=DGOYIiQFEWNokI81sT4/CqcDggD9S9YYA+Wr6zZCJini5RlckayzoLCWcawyf+F/ET0eC6saJrk7gxeG1UqseALicexT22aq9bHEW+GVCHCsXHwYo1EdNbtFAYrnpnjfyrTE4qg4kWBFnkszbnUOgrBnJ817NKKHOUwug39FguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997954; c=relaxed/simple;
	bh=+nfQiXqnCwGle5BXXhDY8Jd23oGojb8YDfjAGygBfIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RFtIFSR9M3H3fpushFy8xjXRJtUBjPJ/UJ9aZ9ugpm76JTjczOfOwJf2ZfMRmON7sAtMKqwqXoZknxAP5D/ud49ujYkpmoqZhr+fMVn/oZjf7CEDqPXaULQ4+g2suwqpZXpZScDZ8ZZOWr6rnIZZs+Rqc42k9fWOHFN5IvIbD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqF/cnW8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qir/20Ds; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:32:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740997950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFvO7tkmJTwwVinxlrw08FtBFbbUgFb4s/Mwsd9TKP0=;
	b=iqF/cnW8eHpe5QDXl/jRmJ/1v88SsjzPiu+p9pHYYJYetFwTLsoSvjlSfxS3XJ3FlDaBbW
	0RhNdCBHQbOxp5Mb9+E79jTf7QcuSE2SOuJSqNicdGZyk0Cu1D1CgwhWCw7+8J6+6pdvXh
	3K1X0MkNdPbBSy0zVdymOGr5ZabjVRnicdSn6zK5hilkFvCgzqWuM5r0OG1yI9IzmTtdlX
	8M6kFgoMn1B+TGiMTSzfpT9/Gy2+us1POm1UVCiYsgiyA8IGgktRKaP+bA6sU5uuZcR3+x
	rFNeX7ffCjV52EuItdQLkuRHwDRAIZ4mFKlyawK4ZsKbuWcT0iOO41lBxprshA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740997950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFvO7tkmJTwwVinxlrw08FtBFbbUgFb4s/Mwsd9TKP0=;
	b=qir/20DsN7jeMAGvuOJ/n90x2QXs3QZso5HD1PTjfJ/radlEuIfmzP2z0vipMGdWDR63lm
	mCQQ2Iua6B1BcFDQ==
From: "tip-bot2 for Nysal Jan K.A" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/membarrier: Fix redundant load of membarrier_state
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303060457.531293-1-nysal@linux.ibm.com>
References: <20250303060457.531293-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099794984.10177.13233860243995497269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ab02bd36eb444654183ad6c5b15211ddfa32a8f
Gitweb:        https://git.kernel.org/tip/7ab02bd36eb444654183ad6c5b15211ddfa32a8f
Author:        Nysal Jan K.A <nysal@linux.ibm.com>
AuthorDate:    Mon, 03 Mar 2025 11:34:50 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:25:40 +01:00

sched/membarrier: Fix redundant load of membarrier_state

On architectures where ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
is not selected, sync_core_before_usermode() is a no-op.
In membarrier_mm_sync_core_before_usermode() the compiler does not
eliminate redundant branches and load of mm->membarrier_state
for this case as the atomic_read() cannot be optimized away.

Here's a snippet of the code generated for finish_task_switch() on powerpc
prior to this change:

  1b786c:   ld      r26,2624(r30)   # mm = rq->prev_mm;
  .......
  1b78c8:   cmpdi   cr7,r26,0
  1b78cc:   beq     cr7,1b78e4 <finish_task_switch+0xd0>
  1b78d0:   ld      r9,2312(r13)    # current
  1b78d4:   ld      r9,1888(r9)     # current->mm
  1b78d8:   cmpd    cr7,r26,r9
  1b78dc:   beq     cr7,1b7a70 <finish_task_switch+0x25c>
  1b78e0:   hwsync
  1b78e4:   cmplwi  cr7,r27,128
  .......
  1b7a70:   lwz     r9,176(r26)     # atomic_read(&mm->membarrier_state)
  1b7a74:   b       1b78e0 <finish_task_switch+0xcc>

This was found while analyzing "perf c2c" reports on kernels prior
to commit c1753fd02a00 ("mm: move mm_count into its own cache line")
where mm_count was false sharing with membarrier_state.

There is a minor improvement in the size of finish_task_switch().
The following are results from bloat-o-meter for ppc64le:

  GCC 7.5.0
  ---------
  add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
  Function                                     old     new   delta
  finish_task_switch                           884     852     -32

  GCC 12.2.1
  ----------
  add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
  Function                                     old     new   delta
  finish_task_switch.isra                      852     820     -32

  LLVM 17.0.6
  -----------
  add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-36 (-36)
  Function                                     old     new   delta
  rt_mutex_schedule                            120     104     -16
  finish_task_switch                           792     772     -20

Results on aarch64:

  GCC 14.1.1
  ----------
  add/remove: 0/2 grow/shrink: 1/1 up/down: 4/-60 (-56)
  Function                                     old     new   delta
  get_nohz_timer_target                        352     356      +4
  e843419@0b02_0000d7e7_408                      8       -      -8
  e843419@01bb_000021d2_868                      8       -      -8
  finish_task_switch.isra                      592     548     -44

Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
Link: https://lore.kernel.org/r/20250303060457.531293-1-nysal@linux.ibm.com
---
 include/linux/sched/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 928a626..b134748 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -531,6 +531,13 @@ enum {
 
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
+	/*
+	 * The atomic_read() below prevents CSE. The following should
+	 * help the compiler generate more efficient code on architectures
+	 * where sync_core_before_usermode() is a no-op.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
+		return;
 	if (current->mm != mm)
 		return;
 	if (likely(!(atomic_read(&mm->membarrier_state) &


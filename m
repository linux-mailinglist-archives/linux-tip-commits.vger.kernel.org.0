Return-Path: <linux-tip-commits+bounces-2358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F59941E6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296F3280A47
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE191E570B;
	Tue,  8 Oct 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yj8D2NIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YfjNPipn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB001CDFDA;
	Tue,  8 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374185; cv=none; b=QoBZEzKN9PAk5YNl/e18LRTgRnerFDYAGGpf6Z8+MeUJJU7NdI6z5oaiQLup7WTN/HlVlHVLaRUk7Ly1uKCcFKLGYJOkw7dT5D4t+PSQmU6w1nrUc4vDk1DCgCsDoFT/6xj65oSefZnjGLgvnTVtZUFHnslHSDYBi6bTeVDMUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374185; c=relaxed/simple;
	bh=s0Bxv9SKOtnTVCla81T+1PRfMlx/XHnJidCCbDYKjzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVrrZRAm2LroZbDwHv+5ggBHgR7nVCgEhT1CIK8I6zYSNEsL/0m54qImdR1O1boNEBnhILyOc4JKW0CjsCLhkSdUfdZsqXQINDKlPsaLf9PGFxAIfTiheWc2h6zxnQ9DuiYRPF8nsiSVkfNwlYxXBQC9/tUuScq04qEpTAQZDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yj8D2NIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YfjNPipn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g5TZIXUOj1cA7euEhKF0WT5Do9vByysHxIzw+lrHHw=;
	b=Yj8D2NIgieORfOSIPNbCZwKUlcLo9Er7PijcFZJGJNL8kx8A6GYGT13QpkF3OOQUBEs2sj
	W4T5hc9Q6mKw5KtWFrK3GKESjcK4a/XC9rHb+yIF4XOXupOjElVRM9ckBbf0H93Yz6Zm0+
	BWYu2qcQI3xcxGcVob5Y2Gz57DdZ4ca3XyuqgMlbm98rozE/mMZyiY68HKsVS7en8iDrrN
	19zNqsHLIwR7wTSLW+vSGPtyK8Wm/lUXt5hgjpHwwcKedOb1Mo/CVz9w8i4Eb3VotSHuip
	YE9QFJb3kjQ222hcvahZFtP/L0NCs2DbsNoja0fJW0cSgHXRaSRkkMQhQH3ncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g5TZIXUOj1cA7euEhKF0WT5Do9vByysHxIzw+lrHHw=;
	b=YfjNPipn8QqiSSQz67/539tQCW3s6GGWhMFoAgDGvggcWlVSBzz3F0GcE9aJgcBV3YueHy
	tVni4Fw4f73CNmDg==
From: "tip-bot2 for David Disseldorp" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: remove unused __HAVE_THREAD_FUNCTIONS hook support
Cc: David Disseldorp <ddiss@suse.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240930050945.30304-2-ddiss@suse.de>
References: <20240930050945.30304-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837417999.1442.13689312973453261120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e9f0c4819deb9459f32f12c4fd2b47993b8c395
Gitweb:        https://git.kernel.org/tip/5e9f0c4819deb9459f32f12c4fd2b47993b8c395
Author:        David Disseldorp <ddiss@suse.de>
AuthorDate:    Mon, 30 Sep 2024 05:09:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:40 +02:00

sched: remove unused __HAVE_THREAD_FUNCTIONS hook support

__HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
provide their own task_thread_info(), task_stack_page(),
setup_thread_stack() and end_of_stack() hooks.

Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
conditionals to only check for the former case.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20240930050945.30304-2-ddiss@suse.de
---
 include/linux/sched.h            | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e6ee425..abf26f1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1898,7 +1898,7 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 # define task_thread_info(task)	(&(task)->thread_info)
-#elif !defined(__HAVE_THREAD_FUNCTIONS)
+#else
 # define task_thread_info(task)	((struct thread_info *)(task)->stack)
 #endif
 
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index bf10bdb..2e52cc4 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -33,7 +33,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
 #endif
 }
 
-#elif !defined(__HAVE_THREAD_FUNCTIONS)
+#else
 
 #define task_stack_page(task)	((void *)(task)->stack)
 


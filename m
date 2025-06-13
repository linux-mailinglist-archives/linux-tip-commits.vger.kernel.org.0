Return-Path: <linux-tip-commits+bounces-5844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB0AD9301
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75273AD033
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762021B8F6;
	Fri, 13 Jun 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XAIHO7aB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDMpJ6mg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE6215075;
	Fri, 13 Jun 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833076; cv=none; b=aiKQh1dISp0na6UKGx7FqihMPdyIcrGgAXhaxN/Bs3WLdPDBPDk7ys1A2qnC+0BZ9ZiBFvK/FjESLMUDk4yyls6CuWhm37llES3M6r1Q09+mRJdaDkn3RreBpY21eRR24aQhrG+2HHLPxoBt4XqfnNJhLVIo+6/qv/t6o7l7Fbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833076; c=relaxed/simple;
	bh=xMfJhVjLLsZqqIXjEDF9Nrbau7Pas3DqJKsVVZw2Ezg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c6uuP5e13aWrmRjoKu3/StZxZSsb2eu/my22IFdK1qLxa39x14rzar9HhqdsgdRtYIYdeBCnqR4EacvJLoAAxMUgwEN2iqcjlCB6kSYkn1XvJJDOwVDnV/OY/w4UxTp6fffumwafltCJADmaeXfc1k7JpobGeeDMRfGkVOjG7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XAIHO7aB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDMpJ6mg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 16:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749833072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fA8/Za0yKnj7/5MDepqz/tbu0Qt0ZotH1YfddqmTSY=;
	b=XAIHO7aBNu5nN5JCqQ0ZLdsEcw8MFV+HHTB+LNPBEf62hVu6HtGLYRsD3pTUF5DqVnGbd7
	IKLMvlip61Nf1HZ5TP7X6+5LYKddjkzFbV0rcSiB8yYWxim2FvHBMYoit/Op24soMPxeES
	s079NV0D+yESV/vTOPFGBmsxxOaCh2VhBVs5tN97OriNxGMHW2AjLKYAGWK+6hUvc0qJqT
	3tujKUe9HUWWvYu6jM4IGel9WMI9Bwzy+1XB6CGf4UheliWrWYYpgYyGcrwiotQ28VCfCc
	ofSFdy2pVCZoQqNSyzPzHhg6YpnqPR+zf/CdKt/6X0pdMDSC5U/4VEEEXQfExA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749833072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fA8/Za0yKnj7/5MDepqz/tbu0Qt0ZotH1YfddqmTSY=;
	b=xDMpJ6mgioz5fDleRiR7i1A0+qzgIsIStJHCeusILhvo8xSu4u6RW9uRvJtC8Rs3gXyLM3
	94pgC6X48FaQDzCg==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] syscall_user_dispatch: Add PR_SYS_DISPATCH_INCLUSIVE_ON
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <97947cc8e205ff49675826d7b0327ef2e2c66eea.1747839857.git.dvyukov@google.com>
References:
 <97947cc8e205ff49675826d7b0327ef2e2c66eea.1747839857.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174983307181.406.10132559995641241207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a2fc422ed75748eef2985454e97847fb22f873c2
Gitweb:        https://git.kernel.org/tip/a2fc422ed75748eef2985454e97847fb22f873c2
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Wed, 21 May 2025 17:04:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 18:36:39 +02:00

syscall_user_dispatch: Add PR_SYS_DISPATCH_INCLUSIVE_ON

There are two possible scenarios for syscall filtering:
 - having a trusted/allowed range of PCs, and intercepting everything else
 - or the opposite: a single untrusted/intercepted range and allowing
   everything else (this is relevant for any kind of sandboxing scenario,
   or monitoring behavior of a single library)

The current API only allows the former use case due to allowed
range wrap-around check. Add PR_SYS_DISPATCH_INCLUSIVE_ON that
enables the second use case.

Add PR_SYS_DISPATCH_EXCLUSIVE_ON alias for PR_SYS_DISPATCH_ON
to make it clear how it's different from the new
PR_SYS_DISPATCH_INCLUSIVE_ON.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/97947cc8e205ff49675826d7b0327ef2e2c66eea.1747839857.git.dvyukov@google.com


---
 Documentation/admin-guide/syscall-user-dispatch.rst | 23 ++++----
 include/uapi/linux/prctl.h                          |  7 +-
 kernel/entry/syscall_user_dispatch.c                | 36 +++++++-----
 tools/include/uapi/linux/prctl.h                    |  7 +-
 4 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index e3cfffe..c1768d9 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -53,20 +53,25 @@ following prctl:
 
   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
 
-<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
-disable the mechanism globally for that thread.  When
-PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
-
-[<offset>, <offset>+<length>) delimit a memory region interval
-from which syscalls are always executed directly, regardless of the
-userspace selector.  This provides a fast path for the C library, which
-includes the most common syscall dispatchers in the native code
-applications, and also provides a way for the signal handler to return
+<op> is either PR_SYS_DISPATCH_EXCLUSIVE_ON/PR_SYS_DISPATCH_INCLUSIVE_ON
+or PR_SYS_DISPATCH_OFF, to enable and disable the mechanism globally for
+that thread.  When PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
+
+For PR_SYS_DISPATCH_EXCLUSIVE_ON [<offset>, <offset>+<length>) delimit
+a memory region interval from which syscalls are always executed directly,
+regardless of the userspace selector.  This provides a fast path for the
+C library, which includes the most common syscall dispatchers in the native
+code applications, and also provides a way for the signal handler to return
 without triggering a nested SIGSYS on (rt\_)sigreturn.  Users of this
 interface should make sure that at least the signal trampoline code is
 included in this region. In addition, for syscalls that implement the
 trampoline code on the vDSO, that trampoline is never intercepted.
 
+For PR_SYS_DISPATCH_INCLUSIVE_ON [<offset>, <offset>+<length>) delimit
+a memory region interval from which syscalls are dispatched based on
+the userspace selector. Syscalls from outside of the range are always
+executed directly.
+
 [selector] is a pointer to a char-sized region in the process memory
 region, that provides a quick way to enable disable syscall redirection
 thread-wide, without the need to invoke the kernel directly.  selector
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6e..9785c1d 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -255,7 +255,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 5340c5a..a9055ec 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -78,7 +78,7 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		if (offset || len || selector)
 			return -EINVAL;
 		break;
-	case PR_SYS_DISPATCH_ON:
+	case PR_SYS_DISPATCH_EXCLUSIVE_ON:
 		/*
 		 * Validate the direct dispatcher region just for basic
 		 * sanity against overflow and a 0-sized dispatcher
@@ -87,30 +87,40 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		 */
 		if (offset && offset + len <= offset)
 			return -EINVAL;
-
+		break;
+	case PR_SYS_DISPATCH_INCLUSIVE_ON:
+		if (len == 0 || offset + len <= offset)
+			return -EINVAL;
 		/*
-		 * access_ok() will clear memory tags for tagged addresses
-		 * if current has memory tagging enabled.
-
-		 * To enable a tracer to set a tracees selector the
-		 * selector address must be untagged for access_ok(),
-		 * otherwise an untagged tracer will always fail to set a
-		 * tagged tracees selector.
+		 * Invert the range, the check in syscall_user_dispatch()
+		 * supports wrap-around.
 		 */
-		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
-			return -EFAULT;
-
+		offset = offset + len;
+		len = -len;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/*
+	 * access_ok() will clear memory tags for tagged addresses
+	 * if current has memory tagging enabled.
+	 *
+	 * To enable a tracer to set a tracees selector the
+	 * selector address must be untagged for access_ok(),
+	 * otherwise an untagged tracer will always fail to set a
+	 * tagged tracees selector.
+	 */
+	if (mode != PR_SYS_DISPATCH_OFF && selector &&
+		!access_ok(untagged_addr(selector), sizeof(*selector)))
+		return -EFAULT;
+
 	task->syscall_dispatch.selector = selector;
 	task->syscall_dispatch.offset = offset;
 	task->syscall_dispatch.len = len;
 	task->syscall_dispatch.on_dispatch = false;
 
-	if (mode == PR_SYS_DISPATCH_ON)
+	if (mode != PR_SYS_DISPATCH_OFF)
 		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
 		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 43dec6e..9785c1d 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -255,7 +255,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1


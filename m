Return-Path: <linux-tip-commits+bounces-7044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24AC19667
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85D3402802
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42FF330333;
	Wed, 29 Oct 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GM+0Vcm1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9gpfkrWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54F32ED52;
	Wed, 29 Oct 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730582; cv=none; b=rj3/WTahEVeY2Y1IWkDOcy64HBrsUxzDch5amdIziFcZd05uTbnxzDU3eNJxBRAY8QD3/Lu21SQeUXUijNilfQf1bG7Zl9rWzA/5begxjoORIHzXnNT4pyNu/0jrDvFW8wDVOHwaIRHvOLkmPFcJ1jjZPNkMvEfx9HwjmznCAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730582; c=relaxed/simple;
	bh=a+c0w3d6gWv9fCip13pbcRARvQOzM6slRZLGzMJQvt0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h7d0MHOk1ImQ0w2JaCd7uH/Ejh6eQPPA6KoM4eCJ7vy6KOwUs2uy5emub9DWshnA9YP1EXyAopjW3qqYRYxj2gopioMWyvlwI528zlv6J5a6XswIoJs9OyoFtK7aJXYAhyhfE27GDIwq4yeVB6MMpqSGvn4yXsRFZjqNnFvyxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GM+0Vcm1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9gpfkrWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCIb7wwhz119yZHowssHi3qYvov/FmYt1DmoKTrC2NU=;
	b=GM+0Vcm1XoCSaAMn9pMRqLfboxH5Vbh7XcBHd5Eauev09k3iT7G7PWwdv1OqMuUiA0ulwZ
	roqcNHvYNckJzvzCNolQPHgYSOvum+vvcqoPfwspLOZUaeNrbb5X0E9f6rgnVDB2IbFtpY
	Wzu2YEAiSohHV47QB5LAOocWdYX7r/EAQEsmejrXsLASmIaoIaQY7NVl09cgk1NEd2vfuf
	r1cEw0a4uUb78M2y0nQZKEbhQokB7lh2p+Fd0Y/IvKJ5KPwJEfVF8Z0Za7hha/xJxZkYcT
	xREs7W/uIP+cGI/HVCIV18637LlNkxMG9WTlKpvFHUwxB9GaGCl5SDxg0Ntv3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCIb7wwhz119yZHowssHi3qYvov/FmYt1DmoKTrC2NU=;
	b=9gpfkrWc/QYYKfBCT+jJ07RXENxvaYtBG3WkXixCLXNpQJKOICH45LeguiehGxNeGtlLBM
	RogEMNIPGp3xMgBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Add comment to unwind_deferred_task_exit()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080118.893367437@infradead.org>
References: <20250924080118.893367437@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057815.2601451.5401446227501331662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ae577ea0bc5249c483da09670f784dbc288c80b6
Gitweb:        https://git.kernel.org/tip/ae577ea0bc5249c483da09670f784dbc288=
c80b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:46:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:55 +01:00

unwind: Add comment to unwind_deferred_task_exit()

Explain why unwind_deferred_task_exit() exist and its constraints.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.893367437@infradead.org
---
 kernel/exit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f..5f6e78e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -939,7 +939,6 @@ void __noreturn do_exit(long code)
=20
 	tsk->exit_code =3D code;
 	taskstats_exit(tsk, group_dead);
-	unwind_deferred_task_exit(tsk);
 	trace_sched_process_exit(tsk, group_dead);
=20
 	/*
@@ -950,6 +949,12 @@ void __noreturn do_exit(long code)
 	 * gets woken up by child-exit notifications.
 	 */
 	perf_event_exit_task(tsk);
+	/*
+	 * PF_EXITING (above) ensures unwind_deferred_request() will no
+	 * longer add new unwinds. While exit_mm() (below) will destroy the
+	 * abaility to do unwinds. So flush any pending unwinds here.
+	 */
+	unwind_deferred_task_exit(tsk);
=20
 	exit_mm();
=20


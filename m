Return-Path: <linux-tip-commits+bounces-7047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7FC19661
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8DF4248B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DD3321D3;
	Wed, 29 Oct 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YH/zTHZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cySTUg+o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7A331A53;
	Wed, 29 Oct 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730586; cv=none; b=hYGzTc3q+4xIlaaqkhgbQgTex+D+/CkaSr/VDGcIQq/21lvG44GVf3JXKqZZQo8kqgNAOjfsMNc6Bifbie/XA9fmK4OXJllGgQ6wGtUGNdNChy2Yko/3yy5XOjqaGpHyFKiNLSlNfjagt+8R9eW1TYgmbKtSsZmUZcIrXP+QQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730586; c=relaxed/simple;
	bh=jKMC3jgB6GuOWBqRlAVoqu4RqsTPkDxiSEBt2IAvqO4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CXpqtZF76a1W2xv0I9GfahCs9AwN4oSw4vgXcM2fqlDMzRvqKT7lPG+BrfMiTveBCrpXOm3CWOEmtyLho0TeKVrl4MKmgAMQsYpYyj7PKeXq01q9T3JdaTyznJJfUHc+3Ea/zUuITFsm+hjOzl54gox0ADsHd6V1Mn2XnLtcslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YH/zTHZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cySTUg+o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6w07g2n2vSO4RgrY7pVNPTMQxhgiDsWE5rPUic4308=;
	b=YH/zTHZ8EdPYeezDNmVogO8KlUKNYTKYc/3jtVyAmGVGAFSvU1YUrUb4Z73eVsSLCq+sTM
	35jKGlxMzG9IjxfF0DIPTjFh3LfR12lSA4tNil6OhtsMEBv+pCxkHKIWj2Gi09BgcT/P0C
	5KtjBoBePGfW6uDaUtvEJIWjjQCwlGNG8mI3lluvnTSPmj+KlNgUkFUpW3h8Hrq28I+WPc
	lPL3RsTHUg5FBeBK6/yjhnHGNYno/S6B6+OYXYmiWa/msSFlOshrRTJyCLDxO87A2aBh9S
	DTuF+o2yvYYCsfwRUBRhnRKPeVANcxKFFf/4UF38ZRo8ijXqE1hdSuQkYte0zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6w07g2n2vSO4RgrY7pVNPTMQxhgiDsWE5rPUic4308=;
	b=cySTUg+olT79GqNh2bKxQv/B4NV07l/4oU7ssxspKST0YxRpgFlgKQkZxZF3BCqMs2FzDN
	77ncdHFtSiUgW7Bw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Shorten lines
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080118.545274393@infradead.org>
References: <20250924080118.545274393@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058161.2601451.6484047622911750090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c31b9d2f589463a7cb286467a618b3b598654890
Gitweb:        https://git.kernel.org/tip/c31b9d2f589463a7cb286467a618b3b5986=
54890
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:44:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:54 +01:00

unwind: Shorten lines

There are some exceptionally long lines that cause ugly wrapping.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.545274393@infradead.org
---
 include/linux/unwind_deferred.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d0..25f4dff 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -8,7 +8,9 @@
=20
 struct unwind_work;
=20
-typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_st=
acktrace *trace, u64 cookie);
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace,
+				  u64 cookie);
=20
 struct unwind_work {
 	struct list_head		list;
@@ -68,9 +70,17 @@ static __always_inline void unwind_reset_info(void)
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
=20
-static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { r=
eturn -ENOSYS; }
-static inline int unwind_deferred_init(struct unwind_work *work, unwind_call=
back_t func) { return -ENOSYS; }
-static inline int unwind_deferred_request(struct unwind_work *work, u64 *tim=
estamp) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
+{ return -ENOSYS; }
+
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
=20
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}


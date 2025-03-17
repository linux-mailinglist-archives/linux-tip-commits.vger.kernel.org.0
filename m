Return-Path: <linux-tip-commits+bounces-4262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC798A64A79
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CD63A39D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73A23ED6A;
	Mon, 17 Mar 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4hg39D5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dwxz/1Ha"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA823E242;
	Mon, 17 Mar 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207688; cv=none; b=LACfGphsRa52H6JsIN12wHWx+E7w2eQqa/pkrwPnjySNzlRM7I7L3iDLHzsBZoc0wYeygQh8i54S6XUtuRM9YmHcaFaWpP3rR63Z2Ce0YJbuJE6CwL8yBeqbiF+wrqPKP532TRS+a+WJhKmwWlCT6JRIa5Y9ZRMY0wivkvMXVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207688; c=relaxed/simple;
	bh=bsbr5Rzzdn7i5a2MqMLq8M3Bl1mapL2f45eDcRgPhKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=du3A5GpK51H+mgk71a5Zx8ZYPxXz6/CL+j4n/CS+v6iupSKc2EQMxhCy5bhYUEqwncNL0h4iBiH+bAAuhOlufyIEIH65x/Fvr3nak3Fd/qj/u7eYEM1/RFqR8eMWzy8aWGlT6AO7sAQsD7WOhJlPKAzexbnhHkNa2N0dNU5cSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4hg39D5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dwxz/1Ha; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yB8Zsr8N9HUz93L+FBQ+9K1N2ZTTc5elZbIv1tmyC9A=;
	b=h4hg39D52QD7BQUlqhz8gMY7vlYJ2kM2Iyl328fmRLzt5JoSt6YlI7hTUI8DvsL2n+EwXR
	WjdeDl/eNgbXwH+kA1y1TbQsk2rT7jyU/elAPPVnfioykjLcOju7DWjbdoEMAjzWJBcVxn
	zIZYwSl3MLwrS7yE6Euy8Xs1nrzcR66qtOM/DXLrU2jJrTqXR9Xoug07BZF5VWK6jKH6oO
	pXQlujjrFop0h/ha4ifKpB9myutihaBPkJcYk0eQhXayBWYet3LmZQO7OsIAaHOnDLgAJY
	RDZFwU8ynkmtu+/kjUVzsnbO6By4It+aQMkqEv83V4wAf3poxmao+G7t/fYy7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yB8Zsr8N9HUz93L+FBQ+9K1N2ZTTc5elZbIv1tmyC9A=;
	b=Dwxz/1Ha/ykroMJA8+ZXPAJ3JCXKcgkFiRIkzcmQ3WX1hf8ub7130X2f5PKT6XT4c5UZKA
	8KSEupuJcryrz/Bw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tracing: Use preempt_model_str()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-10-bigeasy@linutronix.de>
References: <20250314160810.2373416-10-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768431.14745.5641857053740015576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3bffa47a02636ed4134d558caecd35e92051e48d
Gitweb:        https://git.kernel.org/tip/3bffa47a02636ed4134d558caecd35e92051e48d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:41 +01:00

tracing: Use preempt_model_str()

Use preempt_model_str() instead of manually conducting the preemption
model.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20250314160810.2373416-10-bigeasy@linutronix.de
---
 kernel/trace/trace.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517..fd3cb2b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4100,12 +4100,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-		   preempt_model_none()      ? "server" :
-		   preempt_model_voluntary() ? "desktop" :
-		   preempt_model_full()      ? "preempt" :
-		   preempt_model_lazy()	     ? "lazy"    :
-		   preempt_model_rt()        ? "preempt_rt" :
-		   "unknown",
+		   preempt_model_str(),
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
 #ifdef CONFIG_SMP


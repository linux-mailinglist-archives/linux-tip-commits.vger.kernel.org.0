Return-Path: <linux-tip-commits+bounces-2248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79D9720D3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2802A283C48
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD118C00C;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXudShEe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dvfvA/sD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D904188A38;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902877; cv=none; b=PysV/1s5VPdVYFn0rU6FItuX2NIiJizpdijkwoJRNbo85YYtSwFCDP7xQloqcCuRJMY0iXm3qWEIB0Fb6/GMtScZerFSgq5gh8RqwNomwVgaVZBaSXduc3RVJ2iMoRzyHuPH/WRCc3BMS5fFh0VYcmF4NB2oG1X1Vfy+IwfNhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902877; c=relaxed/simple;
	bh=4xN3A91GeXDherd16ve51ucfDiDcl8doX3g9zmLNRpc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aK6eF1t9bNOCQc1d5UEYwZU7pQf7D/jsOHNCJI3gr66kIE4xrQgbLC5yYbaTRB1Ng6ik484/z046JFMEOZMyWkhI9FaO1Xr7N4bz7l4VbymR+G45sDDOC3nAdR4i0V9f7XC1lM8W0hq2qjP7JEzS9KMyNOHCcue+lYcXfeewtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXudShEe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dvfvA/sD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82Vz9EqcSlAR6YCygoei2NYgJzXOtx4W7yFtVxFuiLQ=;
	b=EXudShEeeTHDjQoO8k/h3JD+58W3iVxgHSehpoctrLcNZcZaSvWLfpG8CBbWMT1orlOSB+
	LHVDul0ecache9vKjQnAi42rs77agg2bOB5lxXSij1EvA2pVa2KZopTk9vliDgM7uWJM/H
	kE80zrdEM/CNiWsv2LT4OJXyFStQX2Jk8vkFK9o37aiF25apm/77fPSxxON2C9QlaS/ylY
	8h37/EsQYSYmVa3nsZIdAttM/J+NIGVKi6ZfL3hwUtQ5E/K6kjM2g/DS0Xjb9LN3tqtMW+
	7+TqVx7R3ubMGzgiGYe+vf0pnCawLHMYdIeRsnvORV72limetWKMt1K4R1eRbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82Vz9EqcSlAR6YCygoei2NYgJzXOtx4W7yFtVxFuiLQ=;
	b=dvfvA/sDCUv/K5tohqwR6kTf2C6ncUbfcQfg8NGffpW1blOddbMFfLK0HPmpCrDJ1dTPxc
	80nYNOBn7MnoYjDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] panic: Mark emergency section in warn
Cc: John Ogness <john.ogness@linutronix.de>,
 "Thomas Gleixner (Intel)" <tglx@linutronix.de>,
 Petr Mladek <pmladek@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-33-john.ogness@linutronix.de>
References: <20240820063001.36405-33-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286917.2215.13035846145855436377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     4833794db61c8cc4de4563a2754c7aedaffbb684
Gitweb:        https://git.kernel.org/tip/4833794db61c8cc4de4563a2754c7aedaffbb684
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:58 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 15:03:04 +02:00

panic: Mark emergency section in warn

Mark the full contents of __warn() as an emergency section. In
this section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-33-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 93096d5..1a10b6e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -718,6 +718,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -753,6 +755,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG


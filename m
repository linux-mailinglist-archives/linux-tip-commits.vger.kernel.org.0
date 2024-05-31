Return-Path: <linux-tip-commits+bounces-1318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191C8D5F1E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A5D282C44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B11420A8;
	Fri, 31 May 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+hOdA5I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzzTcxfl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBB140395;
	Fri, 31 May 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149588; cv=none; b=B/VQmPCfVdlySSFYPXdIah//WvK3r9bnG1jIu8bhOP1jd2f7WXWqhBOfljI9puypPH7nfIjWYZFt4OoKNLWzj9Z6gzaST3ZTompywQsgzcFPR1Ws8JxS+EqrwPc8VIouteaLzzdgd3K0A/IV4xkpeDMRu7F4eJ2L5c5IPWYjv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149588; c=relaxed/simple;
	bh=5bkerezig87RZ5oi5fPwTc4JzitlAm+g+mlN/HPTKqQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p+VcXV5yvDQkVwPCY/fK1fzj5aRjbq/i005S3UWeH3dMGJlNSd4PZwIdNJxh/F9Pqu48S++nNzNpp6rmyUBV1sqMBCOCDdRPSkOB0izpWbH5gKxxO7eDszX1EXkmi4UjgVXNfhF4BYTFjRnYtcu7Kn1+wEnuUWScfD4Ib6bsbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+hOdA5I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzzTcxfl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 09:59:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717149585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMVPF2GH7QajfvTeNubuoLs6K6kCrJH8oBiVsIrwks=;
	b=o+hOdA5I26IzDrWf5GcqvdVy/X5NTdaRS2LiLA88hEsW3Kdcefo7VB7V/Hd9t1NRH+WixL
	IMDZanxymo1z24J+kie01c2cloADAXRjHvfP6aUQD5yZsFTQ2qJV/oNHQUiiQRD4BYtmW5
	ih7xqSdTYmnh1XOMWUUMgsZBgL2+bBUJTCi3h9jDfFnkjaj40T/xUxrnS22RKhaD5P8Rt1
	hbmsLHkw9dziM4Iv8ju7Dr+AlOqiE56EMLSvK15maLj7YQYHT8hqpYogTwlNT5lE76FN3V
	MSZbOaBCo9i9tgFrgztmds0kTIgRr7jNmXBspF+RN2geLYckgNeLloj0jlwXRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717149585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMVPF2GH7QajfvTeNubuoLs6K6kCrJH8oBiVsIrwks=;
	b=VzzTcxflg6v3OsCZlPdpPAWLyuJqvfiCvC46GNLfn+HLJI1osmSpG9oWOT4Teo6JlVg3D6
	y2EVWOqKXmnFWJDw==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/x86: Export 'percpu arch_freq_scale'
Cc: Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240530181548.2039216-1-pauld@redhat.com>
References: <20240530181548.2039216-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171714958509.10875.11912816904466913393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d40605a6823577a6c40fad6fb1f10a40ea0389d7
Gitweb:        https://git.kernel.org/tip/d40605a6823577a6c40fad6fb1f10a40ea0389d7
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 30 May 2024 14:15:48 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 May 2024 11:48:42 +02:00

sched/x86: Export 'percpu arch_freq_scale'

Commit:

  7bc263840bc3 ("sched/topology: Consolidate and clean up access to a CPU's max compute capacity")

removed rq->cpu_capacity_orig in favor of using arch_scale_freq_capacity()
calls. Export the underlying percpu symbol on x86 so that external trace
point helper modules can be made to work again.

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240530181548.2039216-1-pauld@redhat.com
---
 arch/x86/kernel/cpu/aperfmperf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index f9a8c7b..b3fa61d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -345,6 +345,7 @@ static DECLARE_WORK(disable_freq_invariance_work,
 		    disable_freq_invariance_workfn);
 
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
 
 static void scale_freq_tick(u64 acnt, u64 mcnt)
 {


Return-Path: <linux-tip-commits+bounces-1265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388838C825A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E707E2815D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542929421;
	Fri, 17 May 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCCJp6z5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHfrrSZY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7A1A28B;
	Fri, 17 May 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933175; cv=none; b=YpBooxSqeLnvvKY8FYJLGkh6869yyxoJcTGhIuKJNZT5TqdNMlaGrOTX5t3LK+IvbLWshniyvXAmmQssAzUYhF97+MMTFP0iQGDlJ5FgBFQxJ6QTdSzdfM+1vfLPlljQzv1yXa0bP5zjewAL6RE+tSVIMVc+HKTJmQ0YcjFZeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933175; c=relaxed/simple;
	bh=p+f6z5lEdk2BPt4tpOa9NSusCoLHGwRBqkmLGKbl13c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EIXj2xQ8PjegbxLQHmn/AR/rjmB2toybAJQeolDLq/rCx0YoS3JvPpNOe/frA47jKr+X7pkTk65G6Mauyk46LHtuipqV/5LPIVq1gAfYIy2ky/JI6QSagJcfa11IqyoDuPLZ5Qq5MLxWG4kCwRgArkIrBtA+q+KMeHrGHHZQ82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCCJp6z5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHfrrSZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yb6qSVvJzENichVEG4o36skuc0PZzlzAYGBpYQFWo7Y=;
	b=nCCJp6z5Q0+rddQv0Btr4W81oxOH8pV9s8SWystJH4OnhHPoToH5eo0Vu7N72hPvzXU/SL
	JoqoZGP1BSdxNLzcZ2u0swI6avovItUpRj59ROQb1PZrzWh/A8PisFhC6TQKwL7wYgQBRr
	9aCXTA/5SJE5ZExiVovXYGh25fQR5EmXdTz130NPkbsPSqho4wHzGB2f6ZL5V48wFpBN2J
	WCsLohc5mBp25WKZXo7dc1XZAEJaaXk8pZgSY7bt2ZqDrsZ+fDj3YRpypHPTaRBObzgb9K
	omRQ3Qic2vjTZgoyhhRTbAawoY7aTr3jlQrxn1zo0R5Wbm7DyW3tEaSmTmD2tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yb6qSVvJzENichVEG4o36skuc0PZzlzAYGBpYQFWo7Y=;
	b=BHfrrSZYrFTB2YEi04Fg2wopmYcQX3H69H4oWlSVAJboV9gZlVvxYUxBdC1SovsAMcd7hq
	kDXhSO6KuR6/oKCA==
From: "tip-bot2 for Vitalii Bursov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] docs: cgroup-v1: Clarify that domain levels are
 system-specific
Cc: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <42b177a2e897cdf880caf9c2025f5b609e820334.1714488502.git.vitaly@bursov.com>
References:
 <42b177a2e897cdf880caf9c2025f5b609e820334.1714488502.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317094.10875.16081049841681398832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0f1c74befa656305ecc85c954dc31f84c1cc26e1
Gitweb:        https://git.kernel.org/tip/0f1c74befa656305ecc85c954dc31f84c1cc26e1
Author:        Vitalii Bursov <vitaly@bursov.com>
AuthorDate:    Tue, 30 Apr 2024 18:05:25 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:48:25 +02:00

docs: cgroup-v1: Clarify that domain levels are system-specific

Add a clarification that domain levels are system-specific
and where to check for system details.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/42b177a2e897cdf880caf9c2025f5b609e820334.1714488502.git.vitaly@bursov.com
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 7d3415e..f401af5 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -568,7 +568,7 @@ on the next tick.  For some applications in special situation, waiting
 
 The 'cpuset.sched_relax_domain_level' file allows you to request changing
 this searching range as you like.  This file takes int value which
-indicates size of searching range in levels ideally as follows,
+indicates size of searching range in levels approximately as follows,
 otherwise initial value -1 that indicates the cpuset has no request.
 
 ====== ===========================================================
@@ -581,6 +581,11 @@ otherwise initial value -1 that indicates the cpuset has no request.
    5   search system wide [on NUMA system]
 ====== ===========================================================
 
+Not all levels can be present and values can change depending on the
+system architecture and kernel configuration. Check
+/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
+details.
+
 The system default is architecture dependent.  The system default
 can be changed using the relax_domain_level= boot parameter.
 


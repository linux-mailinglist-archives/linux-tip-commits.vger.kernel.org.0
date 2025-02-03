Return-Path: <linux-tip-commits+bounces-3311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B124A259C2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD36164CA0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F220550F;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFrJEpEu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="59Rz0R22"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EE204F85;
	Mon,  3 Feb 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=ZvjfcawQekHvjcy2dOsrn4ikk0+EqUz91Nrlc64ZGdOeA9FZEWyDCN9AZmqatOBTTr6HBVDn46m59h2oQZozxtiTflFnld9zryILDsK1aqKY+G0L8niepI1Ty+L993eFPFqRSmS9sAK62xQN9A4uKwxb2vyxaZkqhPjbEwiRquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=I57nZrOe/XGH2HJ5MimuEi4DfkxoICraiHHOG62nSM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c2/F+CPK5Ai7T8f2hrZ4KZ8gDIe4QNtPhSFoqXyd2ikigCLKokcUZSUJWHgppGHMjdNBc4zBK8WBh02MvxRpHsp1bodxf+FnzOTVvUlWQ9xRJn3BeNVQB7QZ5fRkUpiwv4E6SbZ2CYFbJm/BD59mzjNduCIp+lYW5Nn2FKyU6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFrJEpEu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=59Rz0R22; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hdRM1hbk0mUWoPKFRFl45Qo9r4GgPBE1dWgwurZeck=;
	b=cFrJEpEunH/NUSumGwopyGHy1iDjdh8Ojiy4hZ51yB1MoUpEyeFIe7qjw55LjpFcdZm817
	4PjBuqhcch4BbObLSeBmmDnrrG/Kg8FXJ3j6jP5wraKuv/rMk3jHzpXnKUXo1LlJzGCm22
	D6CJ1MOus/S3ZcsZnK+wvMCXntlPZsura5F8lSDcJyWGN2TPWVKDXxX0uXNRZ2KmflvWIC
	Qj643Ig6GlDjzeR2uQwni5D+PpXr06uvL4KIzVpofCFkp93pbQtHSlVQjhPBrW09v155GS
	xnR/y1oJmNrZwukTidwpw8lXeNHYpkzL99/Swo5cOpg0JdoBpqveECu16OUsnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hdRM1hbk0mUWoPKFRFl45Qo9r4GgPBE1dWgwurZeck=;
	b=59Rz0R22mUe8V0/PwDqWShLk0GDWqZbwNjht3lfQLbjmiYhBZLMpBtLFuoTTWbAMK+Wxc6
	KS56jCV4CHGmwbCQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Don't allow freq mode event creation
 through ->config interface
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-6-ravi.bangoria@amd.com>
References: <20250115054438.1021-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689925.10177.10452300443051134355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e1e7844ced88f9558a48579390a7d4eaac6a28eb
Gitweb:        https://git.kernel.org/tip/e1e7844ced88f9558a48579390a7d4eaac6a28eb
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:34 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:05 +01:00

perf/amd/ibs: Don't allow freq mode event creation through ->config interface

Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
MSR. Since the sample period is programmed in these control registers,
IBS PMU driver allows opening an IBS event by setting sample period
value directly in perf_event_attr->config instead of using explicit
perf_event_attr->sample_period interface.

However, this logic is not applicable for freq mode events since the
semantics of control register fields are applicable only to fixed
sample period whereas the freq mode event adjusts sample period after
each and every sample. Currently, IBS driver (unintentionally) allows
creating freq mode event via ->config interface, which is semantically
wrong as well as detrimental because it can be misused to bypass
perf_event_max_sample_rate checks.

Don't allow freq mode event creation through perf_event_attr->config
interface.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-6-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d9c84f1..3e7ca1e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -315,6 +315,9 @@ static int perf_ibs_init(struct perf_event *event)
 	} else {
 		u64 period = 0;
 
+		if (event->attr.freq)
+			return -EINVAL;
+
 		if (perf_ibs == &perf_ibs_op) {
 			period = (config & IBS_OP_MAX_CNT) << 4;
 			if (ibs_caps & IBS_CAPS_OPCNTEXT)


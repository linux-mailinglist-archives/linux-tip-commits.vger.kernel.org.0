Return-Path: <linux-tip-commits+bounces-4397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F1A69A47
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC51B61999
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD14214A8E;
	Wed, 19 Mar 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQmUXJ4F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DGeXJokV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546A214225;
	Wed, 19 Mar 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416690; cv=none; b=D4RY+q/OZDBJHFyGRpDm/ZxKfouK/TMhjkos9IT3PajDAM2ejl2e7YJF3rqUxoFWu3LRhRVzDVrZr5TPheefDq8UHYoEuxVC/w8EAPf5MPscPHRTlzem6JlIdpRvr7P1qsKCRHhNO/pB7YcKSLG9H4Hkv7svcernaGFcd7EQEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416690; c=relaxed/simple;
	bh=QpHaH2Y1qKiY1OkMmec3M0e1H7fqNJlS5XExYXXpuzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rzaUZvKNm00rA61WtB6moWcfU1hWAWOjhRIH134YVJRg0k8wtuEtN3At7bOCHHjyQiShhBQKR1Z9F9TvkAbzgU5w0r63bag+0oK/uH1659MHmBNqUvYv0zEGYdhBMI/UzuQ1S2YtCfaiOZxmVSBJ9Qcjfl5QYH5VrJUPW2IQ/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQmUXJ4F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DGeXJokV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 20:38:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742416686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LiAwfjPWB+2zhYydM4Duvf8bn21xZ2kI459x4c4lUU=;
	b=jQmUXJ4FDWF0ypIdRT86fRblW7kHVY9GbSNOd0+2QMmc3RTyR+nTjjhTmyiwE3WEZVQekb
	ktJJ/l07Tp+SW91PsTWwcIZGI+i43vJ5/K6HO8g3Mp5XnOknvAkEeTDxIqkOVKCwml4Uk3
	GFGO4A9GvjOO7m6wVKmNvF0I1dV8b6G0zX3uYeSdydNXGQQnlouzMwCbKSt5BrJyzafhff
	j4w3CKrq0td9kuTqa0WuhsQQfjCLHHl9cVikbBqkp+r+D10niWlC5js2an21Zad5iobJua
	h0wJRDkGajgbHAWZ9Q14/tvysOAZq2KURBbmsBwvrs+Jxzm3FuqNGRPBaENMhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742416686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LiAwfjPWB+2zhYydM4Duvf8bn21xZ2kI459x4c4lUU=;
	b=DGeXJokVvbqAOqhjhE0YK+zCcYbJMPvQRkPf3iNhrv9KaFf7fXnVYGvpvzgLLp4DvdzB9i
	xQSTpwtlmNZIrpDg==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq/selftests: Fix namespace collision with rseq
 UAPI header
Cc: Mark Brown <broonie@kernel.org>, Michael Jeanson <mjeanson@efficios.com>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319202144.1141542-1-mjeanson@efficios.com>
References: <20250319202144.1141542-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174241668197.14745.5581057115219146862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d047e32b8d1b29d178074b5f4312372e991d5da2
Gitweb:        https://git.kernel.org/tip/d047e32b8d1b29d178074b5f4312372e991d5da2
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Wed, 19 Mar 2025 16:21:39 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 21:26:24 +01:00

rseq/selftests: Fix namespace collision with rseq UAPI header

When the rseq UAPI header is included, 'union rseq' clashes with 'struct
rseq'. It's not the case in the rseq selftests but it does break the KVM
selftests that also include this file.

Rename 'union rseq' to 'union rseq_tls' to fix this.

Fixes: e6644c967d3c ("rseq/selftests: Ensure the rseq ABI TLS is actually 1024 bytes")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20250319202144.1141542-1-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/rseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 6d8997d..663a9ce 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -75,13 +75,13 @@ static int rseq_ownership;
  * Use a union to ensure we allocate a TLS area of 1024 bytes to accomodate an
  * rseq registration that is larger than the current rseq ABI.
  */
-union rseq {
+union rseq_tls {
 	struct rseq_abi abi;
 	char dummy[RSEQ_THREAD_AREA_ALLOC_SIZE];
 };
 
 static
-__thread union rseq __rseq __attribute__((tls_model("initial-exec"))) = {
+__thread union rseq_tls __rseq __attribute__((tls_model("initial-exec"))) = {
 	.abi = {
 		.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 	},

